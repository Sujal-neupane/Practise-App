part of 'auth_bloc.dart';

enum AuthStatus { unknown, unauthenticated, authenticated, submitting, failure }

class AuthState extends Equatable {
  const AuthState({required this.status, this.user, this.errorMessage});

  const AuthState.unknown() : this(status: AuthStatus.unknown);

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  const AuthState.authenticated(User user)
    : this(status: AuthStatus.authenticated, user: user);

  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user?.uid,
    user?.displayName,
    user?.email,
    errorMessage,
  ];
}
