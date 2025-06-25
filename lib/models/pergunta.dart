class Pergunta {
  final String texto;
  final List<String> respostas;
  final int correta;


  Pergunta({required this.texto, required this.respostas, required this.correta}); //construtor da class pergunta

  factory Pergunta.fromJson(Map<String, dynamic> json) => Pergunta(
    texto: json['pergunta'],
    respostas: List<String>.from(json['respostas']),
    correta: json['correta'],
  );
}