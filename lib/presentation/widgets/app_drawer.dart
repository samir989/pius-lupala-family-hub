import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/members/members_screen.dart';
import '../screens/savings/savings_screen.dart';
import '../screens/loans/loans_screen.dart';
import '../screens/social_fund/social_fund_screen.dart';
import '../screens/meetings/meetings_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = [
      (l.t('dashboard'), Icons.dashboard, const DashboardScreen()),
      (l.t('members'), Icons.group, const MembersScreen()),
      (l.t('savings'), Icons.savings, const SavingsScreen()),
      (l.t('loans'), Icons.account_balance, const LoansScreen()),
      (l.t('social'), Icons.volunteer_activism, const SocialFundScreen()),
      (l.t('meetings'), Icons.event, const MeetingsScreen()),
      (l.t('reports'), Icons.picture_as_pdf, const ReportsScreen()),
      (l.t('settings'), Icons.settings, const SettingsScreen()),
    ];
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(child: Text('${l.t('app')}\n${l.t('tagline')}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            ...items.map((e) => ListTile(
                  leading: Icon(e.$2),
                  title: Text(e.$1),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => e.$3));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
