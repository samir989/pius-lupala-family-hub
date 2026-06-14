import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/models/support_ticket.dart';
import '../../../data/repositories/group_repository.dart';
import '../../../data/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/app_drawer.dart';
import 'admin_support_screen.dart';
import 'help_center_screen.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _message = TextEditingController();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final repo = context.read<GroupRepository>();
    final user = context.read<AuthService>().currentUser;
    return Scaffold(
      appBar: AppBar(title: Text(l.t('support'))),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(child: ListTile(leading: const Icon(Icons.help), title: Text(l.t('helpCenter')), subtitle: Text(l.t('helpCenterSubtitle')), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpCenterScreen())))),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: _openEmail, icon: const Icon(Icons.email), label: Text(l.t('emailSupport')))),
            const SizedBox(width: 12),
            Expanded(child: FilledButton.icon(onPressed: _openWhatsApp, icon: const Icon(Icons.chat), label: Text(l.t('whatsAppSupport')))),
          ]),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l.t('newTicket'), style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  TextFormField(controller: _message, minLines: 3, maxLines: 5, decoration: InputDecoration(labelText: l.t('supportMessage')), validator: (v) => (v == null || v.trim().length < 10) ? l.t('required') : null),
                  const SizedBox(height: 12),
                  FilledButton(onPressed: _sending || user == null ? null : () => _send(repo, user.uid), child: Text(_sending ? l.t('pleaseWait') : l.t('sendTicket'))),
                ]),
              ),
            ),
          ),
          ListTile(leading: const Icon(Icons.admin_panel_settings), title: Text(l.t('adminSupportDashboard')), subtitle: Text(l.t('adminSupportSubtitle')), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminSupportScreen()))),
          Text(l.t('myTickets'), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          StreamBuilder<List<SupportTicket>>(
            stream: repo.supportTickets(userId: user?.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return Center(child: Text(l.t('loading')));
              if (snapshot.hasError) return Text('${l.t('error')}: ${snapshot.error}');
              final tickets = snapshot.data ?? [];
              if (tickets.isEmpty) return Text(l.t('noData'));
              return Column(children: tickets.map((ticket) => _TicketCard(ticket: ticket)).toList());
            },
          ),
        ],
      ),
    );
  }

  Future<void> _send(GroupRepository repo, String userId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);
    try {
      await repo.createSupportTicket(SupportTicket(id: '', userId: userId, message: _message.text.trim(), createdAt: DateTime.now()));
      _message.clear();
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _openEmail() => launchUrl(Uri(scheme: 'mailto', path: 'samirluppah6@gmail.com', query: 'subject=Mama%20Group%20Support'));
  Future<void> _openWhatsApp() => launchUrl(Uri.parse('https://wa.me/255656794011?text=Habari%20Mama%20Group%20Support%2C%20nahitaji%20msaada%20kuhusu%20VICOBA.'), mode: LaunchMode.externalApplication);
}

class _TicketCard extends StatelessWidget {
  final SupportTicket ticket;
  const _TicketCard({required this.ticket});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: Icon(ticket.status == 'resolved' ? Icons.check_circle : Icons.support_agent, color: ticket.status == 'resolved' ? Colors.green : null), title: Text(ticket.message), subtitle: Text(ticket.reply.isEmpty ? ticket.status : '${ticket.status}\nReply: ${ticket.reply}')));
}
