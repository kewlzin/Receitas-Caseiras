import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:projeto_flutter_mobile/adapters/receita_hive_adapter.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';

class FavoritasRepository extends ChangeNotifier {
  List<Receita> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(ReceitaHiveAdapter());
    box = await Hive.openLazyBox<Receita>('receitas_favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((receita) async {
      Receita m = await box.get(receita);
      _lista.add(m);
      notifyListeners();
    });
  }

  UnmodifiableListView<Receita> get lista => UnmodifiableListView(_lista);

  saveAll(List<Receita> receitas) {
    receitas.forEach((receita) {
      if (!_lista.any((atual) => atual.nome == receita.nome)) {
        _lista.add(receita);
        box.put(receita.nome, receita);
      }
    });
    notifyListeners();
  }

  remove(Receita receita) {
    _lista.remove(receita);
    box.delete(receita.nome);
    notifyListeners();
  }
}
