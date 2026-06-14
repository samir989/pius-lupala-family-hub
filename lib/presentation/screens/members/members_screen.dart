import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/member.dart';
import '../../../data/repositories/group_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/app_drawer.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});
  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  String q = '';
  @override
  Widget build(BuildContext context) {
    final repo = context.read<GroupRepository>();
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.t('members'))),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(onPressed: () => _edit(context, repo), child: const Icon(Icons.add)),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12), child: TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), labelText: l.t('searchMembers')), onChanged: (v) => setState(() => q = v.toLowerCase()))),
        Expanded(child: StreamBuilder(
          stream: repo.members(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: Text(l.t('loading')));
            if (snapshot.hasError) return Center(child: Text('${l.t('error')}: ${snapshot.error}'));
            final data = (snapshot.data ?? []).where((m) => m.name.toLowerCase().contains(q) || m.phone.contains(q)).toList();
            if (data.isEmpty) return Center(child: Text(l.t('noData')));
            return ListView(children: data.map((m) => ListTile(leading: CircleAvatar(backgroundImage: m.photo.isEmpty ? null : NetworkImage(m.photo), child: m.photo.isEmpty ? Text(m.name.isEmpty ? '?' : m.name[0]) : null), title: Text(m.name), subtitle: Text('${m.phone} • ${m.nationalId}'), onTap: () => _edit(context, repo, m), trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => repo.deleteMember(m.id)))).toList());
          },
        )),
      ]),
    );
  }

  void _edit(BuildContext context, GroupRepository repo, [Member? m]) {
    final l = AppLocalizations.of(context);
    final formKey = GlobalKey<FormState>();
    final name = TextEditingController(text: m?.name);
    final phone = TextEditingController(text: m?.phone);
    final nid = TextEditingController(text: m?.nationalId);
    final address = TextEditingController(text: m?.address);
    var saving = false;
    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (context, setDialogState) => AlertDialog(
      title: Text(m == null ? l.t('addMember') : l.t('editMember')),
      content: Form(key: formKey, child: SingleChildScrollView(child: Column(children: [
        TextFormField(controller: name, decoration: InputDecoration(labelText: l.t('name')), validator: (v) => (v == null || v.isEmpty) ? l.t('required') : null),
        TextFormField(controller: phone, decoration: InputDecoration(labelText: l.t('phone')), validator: (v) => (v == null || v.isEmpty) ? l.t('required') : null),
        TextFormField(controller: nid, decoration: InputDecoration(labelText: l.t('nationalId'))),
        TextFormField(controller: address, decoration: InputDecoration(labelText: l.t('address'))),
      ]))),
      actions: [FilledButton(onPressed: saving ? null : () async { if (!formKey.currentState!.validate()) return; setDialogState(() => saving = true); await repo.saveMember(Member(id: m?.id ?? '', name: name.text, phone: phone.text, nationalId: nid.text, address: address.text, joinDate: m?.joinDate ?? DateTime.now())); if (context.mounted) Navigator.pop(context); }, child: Text(saving ? l.t('pleaseWait') : l.t('save')))],
    )));
  }
}
