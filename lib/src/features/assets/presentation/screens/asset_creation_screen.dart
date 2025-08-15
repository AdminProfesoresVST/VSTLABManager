import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/asset_providers.dart';
import '../widgets/asset_form_field.dart';
import '../widgets/asset_form_button.dart';

/// Pantalla para crear un nuevo activo
class AssetCreationScreen extends ConsumerStatefulWidget {
  /// Constructor de la pantalla de creación de activos
  const AssetCreationScreen({super.key});

  @override
  ConsumerState<AssetCreationScreen> createState() => _AssetCreationScreenState();
}

class _AssetCreationScreenState extends ConsumerState<AssetCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _branchIdController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _valueController.dispose();
    _branchIdController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  /// Valida y envía el formulario
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final assetNotifier = ref.read(assetNotifierProvider.notifier);
    
    final success = await assetNotifier.createAsset(
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      value: double.parse(_valueController.text.trim()),
      branchId: _branchIdController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty 
          ? null 
          : _imageUrlController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Activo creado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  /// Limpia todos los campos del formulario
  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _valueController.clear();
    _branchIdController.clear();
    _imageUrlController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final assetState = ref.watch(assetNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Activo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _clearForm,
            icon: const Icon(Icons.clear_all),
            tooltip: 'Limpiar formulario',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título de la sección
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.inventory_2,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Información del Activo',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Complete los campos requeridos para registrar un nuevo activo en el sistema.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Campos del formulario
              AssetFormField(
                controller: _nameController,
                label: 'Nombre del Activo',
                hint: 'Ej: Laptop Dell Inspiron 15',
                icon: Icons.label,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre es requerido';
                  }
                  if (value.trim().length < 3) {
                    return 'El nombre debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              AssetFormField(
                controller: _descriptionController,
                label: 'Descripción',
                hint: 'Descripción detallada del activo',
                icon: Icons.description,
                isRequired: true,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La descripción es requerida';
                  }
                  if (value.trim().length < 10) {
                    return 'La descripción debe tener al menos 10 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              AssetFormField(
                controller: _valueController,
                label: 'Valor (USD)',
                hint: 'Ej: 1500.00',
                icon: Icons.attach_money,
                isRequired: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El valor es requerido';
                  }
                  final doubleValue = double.tryParse(value.trim());
                  if (doubleValue == null) {
                    return 'Ingrese un valor numérico válido';
                  }
                  if (doubleValue <= 0) {
                    return 'El valor debe ser mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              AssetFormField(
                controller: _branchIdController,
                label: 'ID de Sucursal',
                hint: 'Ej: BRANCH-001',
                icon: Icons.business,
                isRequired: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El ID de sucursal es requerido';
                  }
                  if (value.trim().length < 3) {
                    return 'El ID debe tener al menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              AssetFormField(
                controller: _imageUrlController,
                label: 'URL de Imagen (Opcional)',
                hint: 'https://ejemplo.com/imagen.jpg',
                icon: Icons.image,
                isRequired: false,
                validator: (value) {
                  if (value != null && value.trim().isNotEmpty) {
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null || !uri.hasScheme) {
                      return 'Ingrese una URL válida';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              
              // Mostrar error si existe
              if (assetState.error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    border: Border.all(color: Colors.red[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: Colors.red[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          assetState.error!,
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Botones de acción
              Row(
                children: [
                  Expanded(
                    child: AssetFormButton(
                      onPressed: assetState.isCreating ? null : () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancelar',
                      type: AssetFormButtonType.secondary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: AssetFormButton(
                      onPressed: assetState.isCreating ? null : _submitForm,
                      text: 'Registrar Activo',
                      type: AssetFormButtonType.primary,
                      isLoading: assetState.isCreating,
                      icon: Icons.save,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}