import 'package:flutter/material.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Iniciar'),
          onPressed: () => Navigator.push( //nevagacao para tela do quiz
            context,
            MaterialPageRoute(builder: (_) => QuizPage()),
          ),
        ),
      ),
    );
  }
}