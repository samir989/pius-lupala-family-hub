import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Icon(Icons.groups, size: 84, color: Colors.green),
                Text(l.t('app'), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(controller: email, decoration: InputDecoration(labelText: l.t('email')), validator: (v) => (v == null || v.isEmpty) ? l.t('required') : null),
                const SizedBox(height: 12),
                TextFormField(controller: password, obscureText: true, decoration: InputDecoration(labelText: l.t('password')), validator: (v) => (v == null || v.length < 6) ? l.t('required') : null),
                const SizedBox(height: 12),
                TextFormField(controller: phone, decoration: InputDecoration(labelText: '${l.t('phone')} (+255...)')),
                if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                FilledButton(onPressed: loading ? null : _login, child: Text(loading ? l.t('pleaseWait') : l.t('login'))),
                TextButton(onPressed: _resetPassword, child: Text(l.t('forgotPassword'))),
                OutlinedButton(onPressed: loading ? null : _phoneLogin, child: Text(l.t('phoneLogin'))),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);
    try {
      await context.read<AuthService>().signInWithEmail(email.text.trim(), password.text);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _resetPassword() async {
    if (email.text.trim().isEmpty) return setState(() => error = AppLocalizations.of(context).t('required'));
    await context.read<AuthService>().resetPassword(email.text.trim());
  }

  Future<void> _phoneLogin() async {
    final l = AppLocalizations.of(context);
    if (phone.text.trim().isEmpty) return setState(() => error = l.t('required'));
    setState(() => loading = true);
    try {
      await context.read<AuthService>().verifyPhone(
            phone: phone.text.trim(),
            completed: (credential) {},
            failed: (e) => setState(() => error = e.message),
            codeSent: (verificationId, _) => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpScreen(verificationId: verificationId))),
          );
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }
}
