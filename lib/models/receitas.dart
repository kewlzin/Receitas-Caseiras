class Receita {
  final String nome;
  final String tempo;
  final double curtidas;
  final String imagem;
  final List ingredientes;
  //final String? preparo;

  Receita({
    required this.nome, //name
    required this.tempo, //totalTime
    required this.curtidas, //rating
    required this.imagem, //images/hostedLargeUrl
    required this.ingredientes,
    // required this.preparo, //preparationSteps
  });

  factory Receita.fromJson(dynamic json) {
    return Receita(
      nome: json['details']['name'] as String,
      tempo: json['details']['totalTime'] as String,
      curtidas: json['details']['rating'] as double,
      imagem: json['details']['images'][0]['hostedLargeUrl'] as String,
      ingredientes: json['ingredientLines'] as List,

      //  preparo: json['preparationSteps'][0] as String,
    );
  }

  static List<Receita> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Receita.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Receita {nome: $nome, tempo: $tempo, curtidas: $curtidas, imagem: $imagem, ingredientes: $ingredientes}'; // $preparo
  }
}
