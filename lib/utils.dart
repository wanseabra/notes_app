import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'nota.dart';

bool getUser() {
  final authentication = FirebaseAuth.instance;
  User? user;
  try {
    user = authentication.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
  }
  return false;
}

Future<void> optionsMenu(BuildContext context, FirebaseAuth authentication) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Opções'),
        content: ElevatedButton(
            onPressed: () {
              authentication.signOut();
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomePage();
              }), (r) {
                return false;
              });
            },
            child: const Text("Log out")),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Voltar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

Future<Nota?> addNoteMenu(BuildContext context) {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  return showDialog<Nota>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Adicionar Nova Nota'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: "Titulo",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.amber, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: contentController,
              maxLines: 5,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: "Conteúdo",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.amber, width: 4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Voltar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
              onPressed: () {
                Nota notaCriada = Nota();

                notaCriada
                  ..data = DateTime.now()
                  ..conteudo = contentController.text
                  ..titulo = titleController.text;
                Navigator.of(context).pop(notaCriada);
              },
              child: const Text('Add Nota'))
        ],
      );
    },
  );
}
