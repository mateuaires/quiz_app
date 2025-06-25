import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(MaterialApp(
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

// quando não rodar, executar:
// 1. exclua a pasta build
//2. no terminal:
// flutter clean
// flutter pub get
// flutter run