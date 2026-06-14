# Mama Group

Mama Group is a production-ready Flutter starter for a Tanzanian VICOBA / Women Savings Group. Kiswahili is the default language with English available from Settings.

## Features
- Firebase Authentication: email/password, phone verification hook, password reset, password change.
- Cloud Firestore modules for members, savings, loans, social fund and meetings.
- Dashboard totals, recent transactions and upcoming meetings.
- PDF reports via `pdf` and `printing`.
- Firebase Cloud Messaging initialization for loan, meeting and savings reminder workflows.
- Customer Support System with in-app tickets, admin replies, Help Center, WhatsApp/email contact options, and a floating AI Help Assistant.
- Provider state management, Clean Architecture-inspired folders, responsive Material 3 UI.

## Firebase configuration
1. Create a Firebase project.
2. Enable Authentication providers: Email/Password and Phone.
3. Create a Firestore database and Firebase Storage bucket.
4. Install FlutterFire CLI: `dart pub global activate flutterfire_cli`.
5. Run `flutterfire configure --project <project-id>` from this folder to replace `lib/firebase_options.dart`.
6. Deploy rules: `firebase deploy --only firestore:rules,storage`.
7. For Android, add the generated `android/app/google-services.json` and configure Gradle using the current FlutterFire docs.

## Run
```bash
flutter pub get
flutter run
```

## Data collections
`users`, `members`, `savings`, `loans`, `social_fund`, `meetings`, and `support_tickets` match the requested schema. Sample seed data is in `assets/sample_data/mama_group_seed.json`.
