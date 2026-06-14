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
      'profile': 'Wasifu', 'changePassword': 'Badili Nenosiri', 'logout': 'Toka', 'loading': 'Inapakia...', 'noData': 'Hakuna taarifa', 'error': 'Hitilafu imetokea', 'exportPdf': 'Hamisha PDF'
    },
    'en': {
      'app': 'Mama Group', 'tagline': 'Digital VICOBA', 'login': 'Login', 'email': 'Email', 'password': 'Password', 'phone': 'Phone number', 'forgotPassword': 'Forgot password', 'phoneLogin': 'Login with phone', 'otp': 'OTP code',
      'verifyOtp': 'Verify OTP', 'pleaseWait': 'Please wait...', 'dashboard': 'Dashboard', 'members': 'Members', 'savings': 'Savings', 'loans': 'Loans', 'social': 'Social Fund', 'meetings': 'Meetings', 'reports': 'Reports', 'settings': 'Settings',
      'totalMembers': 'Total Members', 'totalSavings': 'Total Savings', 'totalLoans': 'Total Loans', 'fundBalance': 'Social Fund Balance', 'recentTransactions': 'Recent Transactions', 'upcomingMeetings': 'Upcoming Meetings', 'save': 'Save',
      'searchMembers': 'Search Members', 'addMember': 'Add Member', 'editMember': 'Edit Member', 'name': 'Name', 'nationalId': 'National ID', 'address': 'Address', 'required': 'This field is required', 'validAmount': 'Enter a valid amount',
      'recordSavings': 'Record Savings', 'savingsHistory': 'Savings History', 'memberId': 'Member ID', 'amount': 'Amount', 'loanApplication': 'Loan Application', 'loanHistory': 'Loan History', 'interest': 'Interest (%)',
      'contributionWithdrawal': 'Contribution / Withdrawal', 'description': 'Description', 'type': 'Type', 'createMeeting': 'Create Meeting', 'agenda': 'Agenda', 'decisions': 'Decisions', 'attendance': 'Attendance', 'changeLanguage': 'Change Language',
      'darkMode': 'Dark Mode', 'profile': 'Profile', 'changePassword': 'Change Password', 'logout': 'Logout', 'loading': 'Loading...', 'noData': 'No data', 'error': 'Something went wrong', 'exportPdf': 'Export PDF'
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
