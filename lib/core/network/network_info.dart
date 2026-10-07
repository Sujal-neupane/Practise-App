/// Contract for checking device network connectivity
abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

/// Simple default implementation (can later be backed by internet_connection_checker or connectivity_plus)
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}
