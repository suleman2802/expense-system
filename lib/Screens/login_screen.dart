import 'package:flutter/material.dart';

import '../Widgets/auth_widget.dart';
class LoginScreen extends StatelessWidget {
  static const String routeName = "./loginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthWidget(),
    );
  }
}
