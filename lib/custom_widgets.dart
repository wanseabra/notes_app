import 'package:flutter/material.dart';
import 'nota.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscure,
    required this.label,
    required this.inputType,
    required this.icon,
  });

  final TextEditingController controller;
  final bool obscure;
  final String label;
  final TextInputType inputType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField (
        controller: controller,
        textAlign: TextAlign.left,
        obscureText: obscure,
        keyboardType: inputType,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 4),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({Key? key, required this.nota}) : super(key: key);

  final Nota nota;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: SizedBox(
          // width: 300,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nota.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(nota.conteudo,
                    style:
                        const TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    nota.data.toString(),
                    style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
