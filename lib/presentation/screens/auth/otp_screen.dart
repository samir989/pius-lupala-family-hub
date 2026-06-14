import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final otp = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.t('verifyOtp'))),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: otp, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: l.t('otp')), validator: (v) => (v == null || v.length < 4) ? l.t('required') : null),
            if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            FilledButton(onPressed: loading ? null : _verify, child: Text(loading ? l.t('pleaseWait') : l.t('verifyOtp'))),
          ]),
        ),
      ),
    );
  }

  Future<void> _verify() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => loading = true);
    try {
      await context.read<AuthService>().signInWithOtp(widget.verificationId, otp.text.trim());
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }
}
