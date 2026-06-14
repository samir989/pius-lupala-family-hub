import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../widgets/app_drawer.dart';
class ReportsScreen extends StatelessWidget{const ReportsScreen({super.key});@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Reports')),drawer:const AppDrawer(),body:ListView(padding:const EdgeInsets.all(16),children:['Savings Report','Loan Report','Social Fund Report','Member Report','Monthly Report'].map((r)=>Card(child:ListTile(leading:const Icon(Icons.analytics),title:Text(r),trailing:const Icon(Icons.picture_as_pdf),onTap:()=>_export(r)))).toList())); Future<void> _export(String title) async{final pdf=pw.Document();pdf.addPage(pw.Page(build:(_)=>pw.Column(children:[pw.Text(title,style:pw.TextStyle(fontSize:28,fontWeight:pw.FontWeight.bold)),pw.Text('Mama Group production report export')] )));await Printing.layoutPdf(onLayout:(_)=>pdf.save());}}
