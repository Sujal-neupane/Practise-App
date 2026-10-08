import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    await credential.user?.updateDisplayName(name.trim());
    await credential.user?.reload();
    return credential;
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<void> updateName(String name) async {
    await _currentUser.updateDisplayName(name.trim());
    await _currentUser.reload();
  }

  Future<void> updateEmail({
    required String email,
    required String currentPassword,
  }) async {
    await _reauthenticate(currentPassword);
    await _currentUser.verifyBeforeUpdateEmail(email.trim());
    await _currentUser.reload();
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _reauthenticate(currentPassword);
    await _currentUser.updatePassword(newPassword);
  }

  User get _currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw StateError('No authenticated user.');
    }
    return user;
  }

  Future<void> _reauthenticate(String currentPassword) async {
    final user = _currentUser;
    final email = user.email;
    if (email == null) {
      throw StateError('This account cannot be re-authenticated with a password.');
    }

    await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      ),
    );
  }
}