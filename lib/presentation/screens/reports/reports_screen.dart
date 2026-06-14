import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/app_drawer.dart';
class ReportsScreen extends StatelessWidget{const ReportsScreen({super.key});@override Widget build(BuildContext context){final l=AppLocalizations.of(context);final reports=[l.t('savings'),l.t('loans'),l.t('social'),l.t('members'),'${l.t('reports')} / Monthly'];return Scaffold(appBar:AppBar(title:Text(l.t('reports'))),drawer:const AppDrawer(),body:ListView(padding:const EdgeInsets.all(16),children:reports.map((r)=>Card(child:ListTile(leading:const Icon(Icons.analytics),title:Text(r),trailing:const Icon(Icons.picture_as_pdf),onTap:()=>_export(r,l.t('app'))))).toList()));}Future<void> _export(String title,String app)async{final pdf=pw.Document();pdf.addPage(pw.Page(build:(_)=>pw.Column(children:[pw.Text(title,style:pw.TextStyle(fontSize:28,fontWeight:pw.FontWeight.bold)),pw.Text(app)])));await Printing.layoutPdf(onLayout:(_)=>pdf.save());}}
