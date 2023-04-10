import 'package:firebase_database/firebase_database.dart';
import 'nota.dart';

class NotaDAO {
  //document access object
  final DatabaseReference _notaRefDB = FirebaseDatabase.instance.ref();

  Future<void> salvarNota(Nota nota) async {
    await _notaRefDB.child('notas').push().set(nota.toMap()).then((value) => 'Nota Salva!');
  }

  Query getNotaQuery() {
    return _notaRefDB;
  }

}
