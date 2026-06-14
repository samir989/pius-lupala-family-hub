import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final faqs = [
      (l.t('faqSaveQuestion'), l.t('faqSaveAnswer')),
      (l.t('faqLoanQuestion'), l.t('faqLoanAnswer')),
      (l.t('faqMeetingQuestion'), l.t('faqMeetingAnswer')),
      (l.t('guideSavings'), l.t('guideSavingsText')),
      (l.t('guideLoan'), l.t('guideLoanText')),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(l.t('helpCenter'))),
      body: ListView(padding: const EdgeInsets.all(16), children: faqs.map((item) => Card(child: ExpansionTile(title: Text(item.$1), children: [Padding(padding: const EdgeInsets.all(16), child: Text(item.$2))]))).toList()),
    );
  }
}
