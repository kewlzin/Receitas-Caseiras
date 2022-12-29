import 'dart:convert';
import '../models/receitas.dart';
import 'package:http/http.dart' as http;

class ReceitaApi {
  static Future<List<Receita>> getReceita() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "24", "start": "0", "tag": 'list.recipe.popular'});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "YOUR_API_KEY",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    //print(data);
    List _temp = [];

    //   data["feed"][0]["content"]["preparationSteps"];

    for (var i in data['feed']) {
      _temp.add(i['content']);
      //  _temp.add(i['content']['details']);
      //  _temp.add(i['content']['ingredientLines']);
    }

    return Receita.recipesFromSnapshot(_temp);
  }
}

//LEIA:
/*
The original source url of this recipe with the recipe's preparation steps. - Please note that the Yummly API does not provide the prep steps. As part of attribution to source...
A API que eu tava usando não providencia a receita, fiquei muito tempo tentando fazer funcionar sem saber */
