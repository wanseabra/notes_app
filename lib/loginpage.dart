import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'custom_widgets.dart';
import 'notes_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _authentication = FirebaseAuth.instance;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
                controller: email,
                obscure: false,
                label: 'E-mail',
                inputType: TextInputType.emailAddress,
                icon: Icons.email),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(
                controller: password,
                obscure: true,
                label: 'Password',
                inputType: TextInputType.text,
                icon: Icons.lock),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user =
                          await _authentication.signInWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      print(user);
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const NotesPage();
                            }), (r) {
                              return false;
                            });
                      }
                    } on FirebaseAuthException catch (e) {
                      print(e);
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)),
                  child: const Text("Fazer Login", style: TextStyle(fontSize: 20,))),
            ),
          ],
        ),
      ),
    );
  }
}
