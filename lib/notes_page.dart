import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_notes/homepage.dart';
import 'package:firebase_notes/main.dart';
import 'package:firebase_notes/utils.dart';
import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'firestore.dart';
import 'nota.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _authentication = FirebaseAuth.instance;
  late User loggedUser;
  late List<NoteTile> notesList = <NoteTile>[];
  final _notasRefDB = FirebaseDatabase.instance.ref('notas');

  @override
  void initState() {
    getUser();
    getNotas();
    super.initState();
  }

  void getUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getNotas() async {
    final DatabaseReference notaRefDB = FirebaseDatabase.instance.ref('notas');
    notaRefDB.get().then((snapshot) {
      for (final nota in snapshot.children) {
        Nota notaCriada = Nota();
        notaCriada
          ..data = DateTime.parse(nota.child("data").value.toString())
          ..conteudo = nota.child("conteudo").value.toString()
          ..titulo = nota.child("titulo").value.toString();
        notesList.add(NoteTile(nota: notaCriada));
      }
    }, onError: (error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Notas'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => optionsMenu(context, _authentication),
              child: const Icon(Icons.person),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(stream: _notasRefDB.onValue, builder: (context, snapshot) {
                  if (snapshot.hasData){
                    final teste = Map<String, dynamic>.from((snapshot.data!).snapshot.value as Map);
                    final List<NoteTile> tempList = <NoteTile>[];
                    teste.forEach((key, value) {
                      final nota = Nota.fromMap(value, key);
                      tempList.add(NoteTile(nota: nota));
                    });
                    notesList = tempList;
                  }
                  return ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Dismissible(
                                background: const Card(
                                  color: Colors.red,
                                ),
                                key: UniqueKey(),
                                onDismissed: (DismissDirection direction) {
                                  setState(() {
                                    var temporary = notesList[index];

                                    notesList.removeAt(index);
                                    _notasRefDB.child(temporary.nota.key).remove();
                                    final snackBar = SnackBar(
                                      content: const Text('Nota Deletada!'),
                                      action: SnackBarAction(
                                        label: 'Desfazer',
                                        onPressed: () {
                                          setState(() {
                                            notesList.insert(index, temporary);
                                          });
                                        },
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                                child: notesList[index]));
                      });
                },),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var note = await addNoteMenu(context);
            if (note != null) {
              setState(() {
                // notesList.add(NoteTile(nota: note));
                var notaUpload = NotaDAO();
                try {
                  notaUpload.salvarNota(note);
                } catch (e) {
                  print(e.toString());
                }
              });
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Adcionar Nota')),
    );
  }
}
