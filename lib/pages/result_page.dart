import 'package:flutter/material.dart';
import 'home_page.dart';

class ResultPage extends StatelessWidget {
  final int pontos;
  const ResultPage({required this.pontos});

  String get msg {
    if (pontos <= 5) return 'Tente novamente';
    if (pontos <= 7) return 'Bom desempenho';
    return 'Muito bom!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pontuação: $pontos de 10'),
            Text(msg),
            ElevatedButton(
              child: Text('Reiniciar'), // volta pra tela inicial
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (_) => false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
