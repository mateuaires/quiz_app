import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/pergunta.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget { //mudança dinamica da teça com statefull mudando com o tempo
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Pergunta> _perguntas = [];
  int _indice = 0, _pontos = 0, _tempo = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() async { 
    final data = await rootBundle.loadString('assets/perguntas.json');
    final lista = json.decode(data);
    _perguntas = lista.map<Pergunta>((e) => Pergunta.fromJson(e)).toList(); //carrega as perguntas json
    _iniciarTimer();
    setState(() {});
  }


  void _iniciarTimer() {
    _tempo = 10; //contagem regressiva de 10s
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_tempo > 0) {
        setState(() => _tempo--);
      } else {
        _proxima();
      }
    });
  }

  void _responder(int i) { //verifica se a resposta e avança 
    if (_timer?.isActive ?? false) _timer?.cancel();
    if (i == _perguntas[_indice].correta) _pontos++;
    Future.delayed(Duration(seconds: 1), _proxima);
  }

  void _proxima() { //
    _timer?.cancel();
    if (_indice + 1 < _perguntas.length) {
      setState(() {
        _indice++;
        _iniciarTimer();
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultPage(pontos: _pontos)),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


// interface
  @override
  Widget build(BuildContext context) {
    if (_perguntas.isEmpty) return Scaffold(body: Center(child: CircularProgressIndicator()));
    final p = _perguntas[_indice];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tempo: $_tempo s'),
            SizedBox(height: 20),
            Text(p.texto, style: TextStyle(fontSize: 18)),
            ...p.respostas.asMap().entries.map((e) => ElevatedButton(
              onPressed: () => _responder(e.key),
              child: Text(e.value),
            )),
          ],
        ),
      ),
    );
  }
}