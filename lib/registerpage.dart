import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_widgets.dart';
import 'loginpage.dart';
import 'notes_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            CustomTextField(controller: email, obscure: false, label: 'E-mail', inputType: TextInputType.emailAddress,icon: Icons.email),
            const SizedBox(
              height: 8,
            ),
            CustomTextField(controller: password, obscure: true, label: 'Password', inputType: TextInputType.text,icon: Icons.lock),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user =
                          await _authentication.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      print(user);
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesPage()),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
                  child: const Text("Registrar", style: TextStyle(fontSize: 20,))),
            ),
          ],
        ),
      ),
    );
  }
}
