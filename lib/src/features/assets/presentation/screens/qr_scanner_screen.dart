import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../domain/entities/asset.dart';
import '../providers/asset_providers.dart';
import '../providers/qr_providers.dart';
import '../widgets/scanner_overlay.dart';
import '../widgets/scanner_controls.dart';

/// Pantalla para escanear códigos QR de activos
class QrScannerScreen extends ConsumerStatefulWidget {
  /// Constructor de la pantalla de escáner QR
  const QrScannerScreen({super.key});

  @override
  ConsumerState<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends ConsumerState<QrScannerScreen>
    with WidgetsBindingObserver {
  MobileScannerController? _controller;
  bool _isScanning = true;
  bool _hasPermission = false;
  String? _lastScannedCode;
  DateTime? _lastScanTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeScanner();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null) return;

    switch (state) {
      case AppLifecycleState.resumed:
        if (_hasPermission && _isScanning) {
          _controller?.start();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _controller?.stop();
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  /// Inicializa el escáner de códigos QR
  Future<void> _initializeScanner() async {
    try {
      _controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
        torchEnabled: false,
      );

      // Los permisos se manejan automáticamente por mobile_scanner
      setState(() {
        _hasPermission = true;
      });

      if (_hasPermission) {
        await _controller!.start();
      }
    } catch (e) {
      _showErrorSnackBar('Error al inicializar la cámara: $e');
    }
  }

  /// Maneja la detección de códigos QR
  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final code = barcode.rawValue;

    if (code == null || code.isEmpty) return;

    // Evitar escaneos duplicados muy rápidos
    final now = DateTime.now();
    if (_lastScannedCode == code &&
        _lastScanTime != null &&
        now.difference(_lastScanTime!).inSeconds < 2) {
      return;
    }

    _lastScannedCode = code;
    _lastScanTime = now;

    _processScannedCode(code);
  }

  /// Procesa el código QR escaneado
  Future<void> _processScannedCode(String code) async {
    setState(() {
      _isScanning = false;
    });

    try {
      // Validar el código QR
      final qrService = ref.read(qrServiceProvider);
      final isValid = qrService.isValidAssetQrData(code);

      if (!isValid) {
        _showErrorSnackBar('Código QR inválido');
        _resumeScanning();
        return;
      }

      // Extraer el ID del activo
      final assetId = qrService.extractAssetIdFromQrData(code);
      if (assetId == null) {
        _showErrorSnackBar('No se pudo obtener el ID del activo');
        _resumeScanning();
        return;
      }

      // Buscar el activo
      final assetRepository = ref.read(assetRepositoryProvider);
      final result = await assetRepository.getAssetById(assetId);

      if (result.isSuccess) {
        final asset = result.data;
        if (asset == null) {
          _showErrorSnackBar('Activo no encontrado');
          _resumeScanning();
        } else {
          _showAssetDetails(asset);
        }
      } else {
         _showErrorSnackBar('Error al buscar el activo: ${result.exception?.message ?? "Error desconocido"}');
         _resumeScanning();
       }
    } catch (e) {
      _showErrorSnackBar('Error al procesar el código QR: $e');
      _resumeScanning();
    }
  }

  /// Muestra los detalles del activo escaneado
  void _showAssetDetails(Asset asset) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AssetDetailsModal(
        asset: asset,
        onClose: () {
          Navigator.of(context).pop();
          _resumeScanning();
        },
        onViewDetails: () {
          Navigator.of(context).pop();
          // TODO: Navegar a la pantalla de detalles del activo
          _resumeScanning();
        },
      ),
    );
  }

  /// Reanuda el escaneo
  void _resumeScanning() {
    setState(() {
      _isScanning = true;
      _lastScannedCode = null;
      _lastScanTime = null;
    });
  }

  /// Alterna el flash de la cámara
  Future<void> _toggleFlash() async {
    if (_controller == null) return;
    await _controller!.toggleTorch();
  }

  /// Cambia la cámara (frontal/trasera)
  Future<void> _switchCamera() async {
    if (_controller == null) return;
    await _controller!.switchCamera();
  }

  /// Muestra un SnackBar de error
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Escanear Código QR',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Cámara
          if (_hasPermission && _controller != null)
            MobileScanner(
              controller: _controller!,
              onDetect: _onDetect,
            )
          else
            _buildPermissionDeniedView(),

          // Overlay del escáner
          const ScannerOverlay(),

          // Controles del escáner
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ScannerControls(
              isScanning: _isScanning,
              onToggleFlash: _toggleFlash,
              onSwitchCamera: _switchCamera,
              onResumeScan: _resumeScanning,
            ),
          ),

          // Indicador de estado
          if (!_isScanning)
            Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Procesando código QR...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Construye la vista cuando no se tienen permisos de cámara
  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 80,
              color: Colors.white54,
            ),
            const SizedBox(height: 24),
            const Text(
              'Permisos de Cámara Requeridos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Para escanear códigos QR, necesitamos acceso a tu cámara. '
              'Por favor, otorga los permisos necesarios.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _initializeScanner,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('Solicitar Permisos'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modal para mostrar detalles del activo escaneado
class _AssetDetailsModal extends StatelessWidget {
  const _AssetDetailsModal({
    required this.asset,
    required this.onClose,
    required this.onViewDetails,
  });

  final Asset asset;
  final VoidCallback onClose;
  final VoidCallback onViewDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Activo Escaneado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  icon: Icons.inventory_2,
                  label: 'Nombre:',
                  value: asset.name,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.tag,
                  label: 'ID:',
                  value: asset.id,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.business,
                  label: 'Sucursal:',
                  value: asset.branchId,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.info_outline,
                  label: 'Estado:',
                  value: asset.status,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.attach_money,
                  label: 'Valor:',
                  value: '\$${asset.value.toStringAsFixed(2)}',
                ),
                if (asset.description?.isNotEmpty == true) ...[
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    icon: Icons.description,
                    label: 'Descripción:',
                    value: asset.description!,
                  ),
                ]
              ],
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onClose,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Continuar Escaneando'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onViewDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Ver Detalles'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Construye una fila de detalle
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}