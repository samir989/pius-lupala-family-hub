import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static const supportedLocales = [Locale('sw'), Locale('en')];
  static const delegate = _Delegate();
  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const _values = {
    'sw': {
      'app': 'Mama Group', 'tagline': 'VICOBA Digital', 'login': 'Ingia', 'email': 'Barua pepe', 'password': 'Nenosiri', 'phone': 'Namba ya simu',
      'forgotPassword': 'Umesahau nenosiri', 'phoneLogin': 'Ingia kwa simu', 'otp': 'Msimbo wa OTP', 'verifyOtp': 'Thibitisha OTP', 'pleaseWait': 'Tafadhali subiri...',
      'dashboard': 'Dashibodi', 'members': 'Wanachama', 'savings': 'Akiba', 'loans': 'Mikopo', 'social': 'Mfuko wa Jamii', 'meetings': 'Mikutano', 'reports': 'Ripoti', 'settings': 'Mipangilio',
      'totalMembers': 'Jumla ya Wanachama', 'totalSavings': 'Jumla ya Akiba', 'totalLoans': 'Jumla ya Mikopo', 'fundBalance': 'Salio la Mfuko', 'recentTransactions': 'Miamala ya Karibuni', 'upcomingMeetings': 'Mikutano Ijayo',
      'save': 'Hifadhi', 'searchMembers': 'Tafuta Wanachama', 'addMember': 'Ongeza Mwanachama', 'editMember': 'Hariri Mwanachama', 'name': 'Jina', 'nationalId': 'Namba ya NIDA', 'address': 'Anwani',
      'required': 'Taarifa hii inahitajika', 'validAmount': 'Weka kiasi sahihi', 'recordSavings': 'Rekodi Akiba', 'savingsHistory': 'Historia ya Akiba', 'memberId': 'Kitambulisho cha mwanachama', 'amount': 'Kiasi',
      'loanApplication': 'Ombi la Mkopo', 'loanHistory': 'Historia ya Mikopo', 'interest': 'Riba (%)', 'contributionWithdrawal': 'Mchango / Utoaji', 'description': 'Maelezo', 'type': 'Aina',
      'createMeeting': 'Unda Mkutano', 'agenda': 'Ajenda', 'decisions': 'Maamuzi', 'attendance': 'Mahudhurio', 'changeLanguage': 'Badili Lugha', 'darkMode': 'Mwonekano wa Giza',
      'profile': 'Wasifu', 'changePassword': 'Badili Nenosiri', 'logout': 'Toka', 'loading': 'Inapakia...', 'noData': 'Hakuna taarifa', 'error': 'Hitilafu imetokea', 'exportPdf': 'Hamisha PDF', 'support': 'Msaada', 'helpCenter': 'Kituo cha Msaada', 'helpCenterSubtitle': 'Maswali na maelekezo ya kutumia app', 'emailSupport': 'Barua pepe', 'whatsAppSupport': 'WhatsApp', 'newTicket': 'Tuma swali au malalamiko', 'supportMessage': 'Andika ujumbe wako', 'sendTicket': 'Tuma Tiketi', 'myTickets': 'Tiketi zangu', 'adminSupportDashboard': 'Dashibodi ya Msaada', 'adminSupportSubtitle': 'Majibu ya admin na tiketi zote', 'reply': 'Jibu', 'markResolved': 'Weka imetatuliwa', 'aiHelp': 'Msaidizi', 'faqSaveQuestion': 'Ninawezaje kurekodi akiba?', 'faqSaveAnswer': 'Fungua Akiba, bonyeza +, chagua mwanachama na weka kiasi kilichochangwa.', 'faqLoanQuestion': 'Mkopo unahesabiwaje?', 'faqLoanAnswer': 'Salio la mkopo ni kiasi cha mkopo pamoja na riba: kiasi + (kiasi * riba / 100).', 'faqMeetingQuestion': 'Ninawezaje kusimamia mikutano?', 'faqMeetingAnswer': 'Fungua Mikutano, ongeza ajenda, tarehe, maamuzi na mahudhurio.', 'guideSavings': 'Mwongozo wa kuweka akiba', 'guideSavingsText': 'Hakikisha jina la mwanachama, kiasi, na tarehe vimehakikiwa kabla ya kuhifadhi.', 'guideLoan': 'Mwongozo wa kuomba mkopo', 'guideLoanText': 'Ingiza kiasi, riba, tarehe ya kutoa na tarehe ya mwisho. Mfumo utahesabu salio.', 'aiSavingsAnswer': 'Kwa akiba, tumia kitufe cha + kwenye ukurasa wa Akiba na hakiki kiasi kabla ya kuhifadhi.', 'aiLoansAnswer': 'Kwa mikopo, mfumo hutumia fomula ya kiasi pamoja na riba na kufuatilia salio.', 'aiMeetingsAnswer': 'Kwa mikutano, rekodi ajenda, maamuzi na mahudhurio ili historia ibaki salama.'
    },
    'en': {
      'app': 'Mama Group', 'tagline': 'Digital VICOBA', 'login': 'Login', 'email': 'Email', 'password': 'Password', 'phone': 'Phone number', 'forgotPassword': 'Forgot password', 'phoneLogin': 'Login with phone', 'otp': 'OTP code',
      'verifyOtp': 'Verify OTP', 'pleaseWait': 'Please wait...', 'dashboard': 'Dashboard', 'members': 'Members', 'savings': 'Savings', 'loans': 'Loans', 'social': 'Social Fund', 'meetings': 'Meetings', 'reports': 'Reports', 'settings': 'Settings',
      'totalMembers': 'Total Members', 'totalSavings': 'Total Savings', 'totalLoans': 'Total Loans', 'fundBalance': 'Social Fund Balance', 'recentTransactions': 'Recent Transactions', 'upcomingMeetings': 'Upcoming Meetings', 'save': 'Save',
      'searchMembers': 'Search Members', 'addMember': 'Add Member', 'editMember': 'Edit Member', 'name': 'Name', 'nationalId': 'National ID', 'address': 'Address', 'required': 'This field is required', 'validAmount': 'Enter a valid amount',
      'recordSavings': 'Record Savings', 'savingsHistory': 'Savings History', 'memberId': 'Member ID', 'amount': 'Amount', 'loanApplication': 'Loan Application', 'loanHistory': 'Loan History', 'interest': 'Interest (%)',
      'contributionWithdrawal': 'Contribution / Withdrawal', 'description': 'Description', 'type': 'Type', 'createMeeting': 'Create Meeting', 'agenda': 'Agenda', 'decisions': 'Decisions', 'attendance': 'Attendance', 'changeLanguage': 'Change Language',
      'darkMode': 'Dark Mode', 'profile': 'Profile', 'changePassword': 'Change Password', 'logout': 'Logout', 'loading': 'Loading...', 'noData': 'No data', 'error': 'Something went wrong', 'exportPdf': 'Export PDF', 'support': 'Support', 'helpCenter': 'Help Center', 'helpCenterSubtitle': 'FAQs and simple app guides', 'emailSupport': 'Email', 'whatsAppSupport': 'WhatsApp', 'newTicket': 'Send an issue or complaint', 'supportMessage': 'Write your message', 'sendTicket': 'Send Ticket', 'myTickets': 'My Tickets', 'adminSupportDashboard': 'Admin Support Dashboard', 'adminSupportSubtitle': 'Admin replies and all tickets', 'reply': 'Reply', 'markResolved': 'Mark resolved', 'aiHelp': 'AI Help', 'faqSaveQuestion': 'How do I record savings?', 'faqSaveAnswer': 'Open Savings, tap +, choose the member and enter the contributed amount.', 'faqLoanQuestion': 'How is loan balance calculated?', 'faqLoanAnswer': 'Loan balance is amount plus interest: amount + (amount * interest / 100).', 'faqMeetingQuestion': 'How do I manage meetings?', 'faqMeetingAnswer': 'Open Meetings, add agenda, date, decisions and attendance.', 'guideSavings': 'Savings guide', 'guideSavingsText': 'Confirm member name, amount and date before saving.', 'guideLoan': 'Loan application guide', 'guideLoanText': 'Enter amount, interest, issue date and due date. The system calculates balance.', 'aiSavingsAnswer': 'For savings, tap + on the Savings page and verify the amount before saving.', 'aiLoansAnswer': 'For loans, the system uses amount plus interest and tracks the remaining balance.', 'aiMeetingsAnswer': 'For meetings, record agenda, decisions and attendance so history stays safe.'
    },
  };

  String t(String key) => _values[locale.languageCode]?[key] ?? _values['sw']![key] ?? key;
}

class _Delegate extends LocalizationsDelegate<AppLocalizations> {
  const _Delegate();
  @override
  bool isSupported(Locale locale) => ['sw', 'en'].contains(locale.languageCode);
  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
