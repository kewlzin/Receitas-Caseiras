import 'dart:convert';
import '../models/receitas.dart';
import 'package:http/http.dart' as http;

class ReceitaApi {
  static Future<List<Receita>> getReceita() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "6cbd9f4e9amsh09f3a46c8d8de64p1b6639jsn4257afe9832e",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Receita.recipesFromSnapshot(_temp);
  }
}
