part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthSubscriptionRequested extends AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

final class AuthRegistrationRequested extends AuthEvent {
  const AuthRegistrationRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}

final class AuthLogoutRequested extends AuthEvent {}

final class AuthNameUpdateRequested extends AuthEvent {
  const AuthNameUpdateRequested(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

final class AuthEmailUpdateRequested extends AuthEvent {
  const AuthEmailUpdateRequested({
    required this.email,
    required this.currentPassword,
  });

  final String email;
  final String currentPassword;

  @override
  List<Object?> get props => [email, currentPassword];
}

final class AuthPasswordUpdateRequested extends AuthEvent {
  const AuthPasswordUpdateRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;

  @override
  List<Object?> get props => [currentPassword, newPassword];
}
