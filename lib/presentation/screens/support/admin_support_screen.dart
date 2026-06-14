import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/support_ticket.dart';
import '../../../data/repositories/group_repository.dart';
import '../../../l10n/app_localizations.dart';

class AdminSupportScreen extends StatelessWidget {
  const AdminSupportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final repo = context.read<GroupRepository>();
    return Scaffold(
      appBar: AppBar(title: Text(l.t('adminSupportDashboard'))),
      body: StreamBuilder<List<SupportTicket>>(
        stream: repo.supportTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: Text(l.t('loading')));
          if (snapshot.hasError) return Center(child: Text('${l.t('error')}: ${snapshot.error}'));
          final tickets = snapshot.data ?? [];
          if (tickets.isEmpty) return Center(child: Text(l.t('noData')));
          return ListView(padding: const EdgeInsets.all(16), children: tickets.map((ticket) => _AdminTicketCard(ticket: ticket)).toList());
        },
      ),
    );
  }
}

class _AdminTicketCard extends StatelessWidget {
  final SupportTicket ticket;
  const _AdminTicketCard({required this.ticket});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final repo = context.read<GroupRepository>();
    final reply = TextEditingController(text: ticket.reply);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(ticket.message, style: Theme.of(context).textTheme.titleMedium),
          Text('${ticket.userId} • ${ticket.status}', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          TextField(controller: reply, minLines: 2, maxLines: 4, decoration: InputDecoration(labelText: l.t('reply'))),
          Row(children: [
            FilledButton(onPressed: () => repo.replyToSupportTicket(ticket.id, reply.text.trim()), child: Text(l.t('reply'))),
            const SizedBox(width: 8),
            OutlinedButton(onPressed: () => repo.resolveSupportTicket(ticket.id), child: Text(l.t('markResolved'))),
          ]),
        ]),
      ),
    );
  }
}
