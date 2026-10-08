import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_app/features/auth/data/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState.unknown()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegistrationRequested>(_onRegistrationRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthNameUpdateRequested>(_onNameUpdateRequested);
    on<AuthEmailUpdateRequested>(_onEmailUpdateRequested);
    on<AuthPasswordUpdateRequested>(_onPasswordUpdateRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach<User?>(
      _authRepository.authStateChanges,
      onData: (user) => user == null
          ? const AuthState.unauthenticated()
          : AuthState.authenticated(user),
      onError: (_, _) => const AuthState.unauthenticated(),
    );
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.submitting, clearError: true));
    try {
      await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _messageFor(error),
        ),
      );
    }
  }

  Future<void> _onRegistrationRequested(
    AuthRegistrationRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.submitting, clearError: true));
    try {
      await _authRepository.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _messageFor(error),
        ),
      );
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
  }

  Future<void> _onNameUpdateRequested(
    AuthNameUpdateRequested event,
    Emitter<AuthState> emit,
  ) => _runProfileOperation(emit, () => _authRepository.updateName(event.name));

  Future<void> _onEmailUpdateRequested(
    AuthEmailUpdateRequested event,
    Emitter<AuthState> emit,
  ) => _runProfileOperation(
    emit,
    () => _authRepository.updateEmail(
      email: event.email,
      currentPassword: event.currentPassword,
    ),
  );

  Future<void> _onPasswordUpdateRequested(
    AuthPasswordUpdateRequested event,
    Emitter<AuthState> emit,
  ) => _runProfileOperation(
    emit,
    () => _authRepository.updatePassword(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
    ),
  );

  Future<void> _runProfileOperation(
    Emitter<AuthState> emit,
    Future<void> Function() operation,
  ) async {
    emit(state.copyWith(status: AuthStatus.submitting, clearError: true));
    try {
      await operation();
      final user = _authRepository.currentUser;
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } on FirebaseAuthException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _messageFor(error),
        ),
      );
    } on StateError catch (error) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: error.message),
      );
    }
  }

  String _messageFor(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
      case 'wrong-password':
        return 'The email or password is incorrect.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Choose a stronger password.';
      case 'requires-recent-login':
        return 'Please sign in again before making this change.';
      default:
        return error.message ?? 'Something went wrong. Please try again.';
    }
  }
}
