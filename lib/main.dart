import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List _perguntas = [];
  int _indice = 0;
  int _pontos = 0;

  @override
  void initState() {
    super.initState();
    _carregarPerguntas();
  }

  Future<void> _carregarPerguntas() async {
    final String data = await rootBundle.loadString('assets/perguntas.json');
    setState(() {
      _perguntas = json.decode(data);
    });
  }

  void _responder(int selecionada) {
    if (selecionada == _perguntas[_indice]['correta']) {
      _pontos++;
    }

    setState(() {
      _indice++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_perguntas.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_indice >= _perguntas.length) {
      return Scaffold(
        appBar: AppBar(title: Text("Resultado")),
        body: Center(
          child: Text(
            "Você acertou $_pontos de ${_perguntas.length}!",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final perguntaAtual = _perguntas[_indice];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz Flutter")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              perguntaAtual['pergunta'],
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ...(perguntaAtual['respostas'] as List<String>).asMap().entries.map((entry) {
              int i = entry.key;
              String resposta = entry.value;
              return ElevatedButton(
                onPressed: () => _responder(i),
                child: Text(resposta),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
