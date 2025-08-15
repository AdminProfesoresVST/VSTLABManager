import '../exceptions/app_exceptions.dart';

/// Tipo de resultado que encapsula éxito o falla de una operación
/// Inspirado en el patrón Result de Rust y Either de programación funcional
sealed class Result<T> {
  const Result();
  
  /// Crea un resultado exitoso
  const factory Result.success(T data) = Success<T>;
  
  /// Crea un resultado de falla
  const factory Result.failure(AppException exception) = Failure<T>;
  
  /// Verifica si el resultado es exitoso
  bool get isSuccess => this is Success<T>;
  
  /// Verifica si el resultado es una falla
  bool get isFailure => this is Failure<T>;
  
  /// Obtiene los datos si es exitoso, null si es falla
  T? get data => switch (this) {
    Success<T>(data: final data) => data,
    Failure<T>() => null,
  };
  
  /// Obtiene la excepción si es falla, null si es exitoso
  AppException? get exception => switch (this) {
    Success<T>() => null,
    Failure<T>(exception: final exception) => exception,
  };
  
  /// Transforma el resultado aplicando una función si es exitoso
  Result<R> map<R>(R Function(T) transform) {
    return switch (this) {
      Success<T>(data: final data) => Result.success(transform(data)),
      Failure<T>(exception: final exception) => Result.failure(exception),
    };
  }
  
  /// Transforma el resultado aplicando una función que retorna Result
  Result<R> flatMap<R>(Result<R> Function(T) transform) {
    return switch (this) {
      Success<T>(data: final data) => transform(data),
      Failure<T>(exception: final exception) => Result.failure(exception),
    };
  }
  
  /// Ejecuta una función si el resultado es exitoso
  Result<T> onSuccess(void Function(T) action) {
    if (this is Success<T>) {
      action((this as Success<T>).data);
    }
    return this;
  }
  
  /// Ejecuta una función si el resultado es una falla
  Result<T> onFailure(void Function(AppException) action) {
    if (this is Failure<T>) {
      action((this as Failure<T>).exception);
    }
    return this;
  }
  
  /// Obtiene el valor o lanza la excepción
  T getOrThrow() {
    return switch (this) {
      Success<T>(data: final data) => data,
      Failure<T>(exception: final exception) => throw exception,
    };
  }
  
  /// Obtiene el valor o retorna un valor por defecto
  T getOrElse(T defaultValue) {
    return switch (this) {
      Success<T>(data: final data) => data,
      Failure<T>() => defaultValue,
    };
  }
}

/// Resultado exitoso
final class Success<T> extends Result<T> {
  /// Los datos del resultado exitoso
  final T data;
  
  const Success(this.data);
  
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Success<T> && other.data == data);
  }
  
  @override
  int get hashCode => data.hashCode;
  
  @override
  String toString() => 'Success($data)';
}

/// Resultado de falla
final class Failure<T> extends Result<T> {
  /// La excepción que causó la falla
  final AppException exception;
  
  const Failure(this.exception);
  
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Failure<T> && other.exception == exception);
  }
  
  @override
  int get hashCode => exception.hashCode;
  
  @override
  String toString() => 'Failure($exception)';
}