import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practise_app/app.dart';
import 'package:practise_app/common/notifications/notification_service.dart';
import 'package:practise_app/firebase_options.dart';

export 'package:practise_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().initialize();

  runApp(const MyApp());
}
