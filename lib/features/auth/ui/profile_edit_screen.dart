import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_app/common/theme/app_colors.dart';
import 'package:practise_app/features/auth/bloc/auth_bloc.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please sign in first.')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated &&
              state.errorMessage == null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile updated.')));
          }
          if (state.status == AuthStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                (user.displayName?.isNotEmpty == true
                        ? user.displayName![0]
                        : user.email![0])
                    .toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _EditTile(
              icon: Icons.badge_outlined,
              title: 'Name',
              value: user.displayName ?? 'Add your name',
              onTap: () => _showNameDialog(context, user.displayName ?? ''),
            ),
            _EditTile(
              icon: Icons.email_outlined,
              title: 'Email',
              value: user.email ?? 'No email',
              onTap: () => _showEmailDialog(context, user.email ?? ''),
            ),
            _EditTile(
              icon: Icons.lock_outline,
              title: 'Password',
              value: 'Change your password',
              onTap: () => _showPasswordDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNameDialog(BuildContext context, String currentName) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ProfileEditDialog(
        mode: _ProfileEditMode.name,
        initialValue: currentName,
      ),
    );
  }

  Future<void> _showEmailDialog(
    BuildContext context,
    String currentEmail,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ProfileEditDialog(
        mode: _ProfileEditMode.email,
        initialValue: currentEmail,
      ),
    );
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) => const _ProfileEditDialog(mode: _ProfileEditMode.password),
    );
  }
}

enum _ProfileEditMode { name, email, password }

class _ProfileEditDialog extends StatefulWidget {
  const _ProfileEditDialog({required this.mode, this.initialValue = ''});

  final _ProfileEditMode mode;
  final String initialValue;

  @override
  State<_ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<_ProfileEditDialog> {
  late String _primaryValue;
  String _secondaryValue = '';

  @override
  void initState() {
    super.initState();
    _primaryValue = widget.initialValue;
  }

  String get _title {
    switch (widget.mode) {
      case _ProfileEditMode.name:
        return 'Update name';
      case _ProfileEditMode.email:
        return 'Update email';
      case _ProfileEditMode.password:
        return 'Change password';
    }
  }

  void _save() {
    final bloc = context.read<AuthBloc>();
    switch (widget.mode) {
      case _ProfileEditMode.name:
        if (_primaryValue.trim().isEmpty) return;
        bloc.add(AuthNameUpdateRequested(_primaryValue));
      case _ProfileEditMode.email:
        if (_primaryValue.trim().isEmpty || _secondaryValue.isEmpty) {
          return;
        }
        bloc.add(
          AuthEmailUpdateRequested(
            email: _primaryValue,
            currentPassword: _secondaryValue,
          ),
        );
      case _ProfileEditMode.password:
        if (_primaryValue.isEmpty || _secondaryValue.length < 6) {
          return;
        }
        bloc.add(
          AuthPasswordUpdateRequested(
            currentPassword: _primaryValue,
            newPassword: _secondaryValue,
          ),
        );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isName = widget.mode == _ProfileEditMode.name;
    final isEmail = widget.mode == _ProfileEditMode.email;
    return AlertDialog(
      title: Text(_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: widget.initialValue,
            autofocus: true,
            obscureText: !isName && !isEmail,
            onChanged: (value) => _primaryValue = value,
            decoration: InputDecoration(
              labelText: isName
                  ? 'Name'
                  : isEmail
                  ? 'New email'
                  : 'Current password',
            ),
          ),
          if (!isName)
            TextFormField(
              obscureText: true,
              onChanged: (value) => _secondaryValue = value,
              decoration: InputDecoration(
                labelText: isEmail ? 'Current password' : 'New password',
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }
}

class _EditTile extends StatelessWidget {
  const _EditTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(value),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}
