import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/group_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/ai_help_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final repo = context.read<GroupRepository>();
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('${l.t('app')} ${l.t('dashboard')}')),
      drawer: const AppDrawer(),
      floatingActionButton: const AiHelpButton(),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        FutureBuilder(
          future: repo.service.totals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: Text(l.t('loading')));
            if (snapshot.hasError) return Text('${l.t('error')}: ${snapshot.error}');
            final t = snapshot.data ?? {};
            return Wrap(runSpacing: 8, children: [
              SummaryCard(title: l.t('totalMembers'), value: '${t['members'] ?? 0}', icon: Icons.group),
              SummaryCard(title: l.t('totalSavings'), value: 'TZS ${t['savings'] ?? 0}', icon: Icons.savings),
              SummaryCard(title: l.t('totalLoans'), value: 'TZS ${t['loans'] ?? 0}', icon: Icons.account_balance),
              SummaryCard(title: l.t('fundBalance'), value: 'TZS ${t['fund'] ?? 0}', icon: Icons.volunteer_activism),
            ]);
          },
        ),
        const SizedBox(height: 16),
        Text(l.t('recentTransactions'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        StreamBuilder(
          stream: repo.savings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Text(l.t('loading'));
            if (snapshot.hasError) return Text('${l.t('error')}: ${snapshot.error}');
            final data = snapshot.data ?? [];
            if (data.isEmpty) return Text(l.t('noData'));
            return Column(children: data.take(5).map((x) => ListTile(leading: const Icon(Icons.payments), title: Text('TZS ${x.amount}'), subtitle: Text(x.date.toString()))).toList());
          },
        ),
        Text(l.t('upcomingMeetings'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        StreamBuilder(
          stream: repo.meetings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Text(l.t('loading'));
            if (snapshot.hasError) return Text('${l.t('error')}: ${snapshot.error}');
            final data = snapshot.data ?? [];
            if (data.isEmpty) return Text(l.t('noData'));
            return Column(children: data.take(3).map((x) => ListTile(leading: const Icon(Icons.event), title: Text(x.agenda), subtitle: Text(x.date.toString()))).toList());
          },
        ),
      ]),
    );
  }
}
