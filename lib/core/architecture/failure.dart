abstract class Failure {
  final String message;

  const Failure(
    this.message,
  );

  @override
  String toString() => 'Failure(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class APIFailure extends Failure {
  const APIFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("Kiểm tra kết nối internet");
}

class PlatformFailure extends Failure {
  const PlatformFailure(String message) : super(message);
}
