class Receita {
  final String nome;
  final String tempo;
  final double curtidas;
  final String imagem;
//  final String? preparo;

  Receita({
    required this.nome, //name
    required this.tempo, //totalTime
    required this.curtidas, //rating
    required this.imagem, //images/hostedLargeUrl
    //  required this.preparo, //preparationSteps
  });

  factory Receita.fromJson(dynamic json) {
    return Receita(
      nome: json['name'] as String,
      tempo: json['totalTime'] as String,
      curtidas: json['rating'] as double,
      imagem: json['images'][0]['hostedLargeUrl'] as String,
      //   preparo: json['preparationSteps'] as String,
    );
  }

  static List<Receita> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Receita.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Receita {nome: $nome, tempo: $tempo, curtidas: $curtidas, imagem: $imagem, preparo:}'; // $preparo
  }
}
