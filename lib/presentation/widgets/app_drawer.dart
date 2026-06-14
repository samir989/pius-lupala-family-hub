import 'package:flutter/material.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/members/members_screen.dart';
import '../screens/savings/savings_screen.dart';
import '../screens/loans/loans_screen.dart';
import '../screens/social_fund/social_fund_screen.dart';
import '../screens/meetings/meetings_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/settings/settings_screen.dart';

class AppDrawer extends StatelessWidget { const AppDrawer({super.key});
  @override Widget build(BuildContext context){ final items=[('Dashboard',Icons.dashboard,const DashboardScreen()),('Members',Icons.group,const MembersScreen()),('Savings',Icons.savings,const SavingsScreen()),('Loans',Icons.account_balance,const LoansScreen()),('Social Fund',Icons.volunteer_activism,const SocialFundScreen()),('Meetings',Icons.event,const MeetingsScreen()),('Reports',Icons.picture_as_pdf,const ReportsScreen()),('Settings',Icons.settings,const SettingsScreen())]; return Drawer(child: SafeArea(child: ListView(children:[const DrawerHeader(child: Text('Mama Group\nVICOBA Digital', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))),...items.map((e)=>ListTile(leading:Icon(e.$2),title:Text(e.$1),onTap:()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>e.$3))))])));}
}
