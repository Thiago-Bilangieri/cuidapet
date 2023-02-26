import 'package:cuida_pet/app/helpers/environments.dart';
import 'package:cuida_pet/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ApplicationConfig {
  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _configureCoreConfig();
    await _loadEnvs();
  }

  Future<void> _configureCoreConfig() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> _loadEnvs() => Environments.loadEnvs();
}
