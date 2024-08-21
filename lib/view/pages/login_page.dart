import 'package:alquran_digital/app/const/method_channel_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> authenticateWithBiometrics() async {
    try {
      await platform.invokeMethod('authenticateWithBiometrics');

      /// Handle the method calls coming from the native side.
      platform.setMethodCallHandler((call) async {
        if (call.method == 'authenticationResult') {
          if (call.arguments ?? false) {
            context.goNamed('home');
          } else {
            const SnackBar(content: Text('Login failed'));
          }
        }
      });
    } on PlatformException catch (e) {
      // The type of error coming from native is always [PlatformException].
      SnackBar(content: Text(e.message ?? ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: authenticateWithBiometrics,
          child: const Text("Sign in"),
        ),
      ),
    );
  }
}
