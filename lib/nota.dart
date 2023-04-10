class Nota {
  late String _titulo;
  late DateTime _data;
  late String _conteudo;
  late String? _key;

  String get key => _key!;
  String get titulo => _titulo;
  DateTime get data => _data;
  String get conteudo => _conteudo;

  set titulo(String value) {
    _titulo = value;
  }

  set data(DateTime value) {
    _data = value;
  }

  set conteudo(String value) {
    _conteudo = value;
  }

  set key(String value) {
    _key = value;
  }

  Nota ();

  Map<String, dynamic> toMap() {
    return {
      'titulo': _titulo,
      'data': _data.toString(),
      'conteudo': _conteudo,
    };
  }

  Nota.fromMap(Map<dynamic, dynamic> notaMap, String key)
      : _titulo = notaMap["titulo"],
        _data = DateTime.parse(notaMap["data"]),
        _key = key,
        _conteudo = notaMap["conteudo"];
}
