import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AiHelpButton extends StatelessWidget {
  const AiHelpButton({super.key});
  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        heroTag: 'aiHelp',
        onPressed: () => _showAssistant(context),
        icon: const Icon(Icons.smart_toy),
        label: Text(AppLocalizations.of(context).t('aiHelp')),
      );

  void _showAssistant(BuildContext context) {
    final l = AppLocalizations.of(context);
    final answers = [
      (l.t('savings'), l.t('aiSavingsAnswer')),
      (l.t('loans'), l.t('aiLoansAnswer')),
      (l.t('meetings'), l.t('aiMeetingsAnswer')),
    ];
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => ListView(padding: const EdgeInsets.all(16), children: [
        Text(l.t('aiHelp'), style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...answers.map((answer) => Card(child: ExpansionTile(leading: const Icon(Icons.question_answer), title: Text(answer.$1), children: [Padding(padding: const EdgeInsets.all(16), child: Text(answer.$2))]))),
      ]),
    );
  }
}
