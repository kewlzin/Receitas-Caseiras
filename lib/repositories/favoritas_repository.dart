import 'dart:collection';

import 'package:flutter/widgets.dart';
import './receitas_repository.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';

class FavoritasRepository extends ChangeNotifier {
  List<Receita> _lista = [];

  UnmodifiableListView<Receita> get lista => UnmodifiableListView(_lista);

  saveAll(List<Receita> receitas) {
    receitas.forEach((receita) {
      if (!_lista.contains(receita)) _lista.add(receita);
    });

    notifyListeners();
  }

  remove(Receita receita) {
    _lista.remove(receita);
    notifyListeners();
  }
}
