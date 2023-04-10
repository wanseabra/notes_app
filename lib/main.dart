import 'package:firebase_notes/notes_page.dart';
import 'package:firebase_notes/utils.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Home());
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final bool loggedUser = getUser();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: loggedUser? const NotesPage(): const HomePage(),
      theme: ThemeData(
        // useMaterial3: true
      ),
    );
  }
}
