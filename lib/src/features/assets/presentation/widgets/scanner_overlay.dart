import 'package:flutter/material.dart';

/// Widget que muestra el overlay del escáner con el marco de escaneo
class ScannerOverlay extends StatelessWidget {
  /// Constructor del overlay del escáner
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo semi-transparente
        Container(
          color: Colors.black.withValues(alpha: 0.5),
        ),
        
        // Marco de escaneo
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Esquinas del marco
                _buildCorner(
                  alignment: Alignment.topLeft,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                  ),
                  context: context,
                ),
                _buildCorner(
                  alignment: Alignment.topRight,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                  context: context,
                ),
                _buildCorner(
                  alignment: Alignment.bottomLeft,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                  ),
                  context: context,
                ),
                _buildCorner(
                  alignment: Alignment.bottomRight,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                  ),
                  context: context,
                ),
                
                // Línea de escaneo animada
                const _ScanLine(),
              ],
            ),
          ),
        ),
        
        // Instrucciones
        Positioned(
          bottom: 120,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            child: const Text(
              'Apunta la cámara hacia el código QR del activo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
  
  /// Construye una esquina del marco de escaneo
  Widget _buildCorner({
    required Alignment alignment,
    required BorderRadius borderRadius,
    required BuildContext context,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 4,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Widget animado que muestra la línea de escaneo
class _ScanLine extends StatefulWidget {
  const _ScanLine();

  @override
  State<_ScanLine> createState() => _ScanLineState();
}

class _ScanLineState extends State<_ScanLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value * 220, // 250 - 30 (altura de la línea)
          left: 15,
          right: 15,
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Theme.of(context).primaryColor,
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      },
    );
  }
}