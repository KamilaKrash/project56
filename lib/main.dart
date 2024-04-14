import 'package:flutter/material.dart';
import 'package:srs5/pages/bottom_bar.dart';
import 'package:srs5/pages/language.dart';
import 'package:srs5/service/shared_preference.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceHelper.init().then((_) {
    bool isAuthenticated = SharedPreferenceHelper.isAuthenticated();
    runApp(MyApp(isAuthenticated: isAuthenticated));
  });
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  MyApp({required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: isAuthenticated ? BottomBarPage(name: '', email: '', phoneNumber: '') : LanguagePage(),
    );
  }
}
