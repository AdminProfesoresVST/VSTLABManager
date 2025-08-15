// Barrel file para exportar todos los componentes de activos

// Domain
export 'domain/entities/asset.dart';
export 'domain/repositories/asset_repository.dart';

// Data
export 'data/models/asset_model.dart';
export 'data/repositories/asset_repository_sqlite.dart';

// Presentation
export 'presentation/providers/asset_providers.dart';
export 'presentation/providers/qr_providers.dart';

// Domain - Services
export 'domain/services/qr_service.dart';

// Data - Services
export 'data/services/qr_service_impl.dart';

export 'presentation/screens/asset_creation_screen.dart';
export 'presentation/screens/qr_generation_screen.dart';
export 'presentation/screens/qr_scanner_screen.dart';
export 'presentation/widgets/asset_form_field.dart';
export 'presentation/widgets/asset_form_button.dart';
export 'presentation/widgets/qr_action_button.dart';
export 'presentation/widgets/scanner_overlay.dart';
export 'presentation/widgets/scanner_controls.dart';