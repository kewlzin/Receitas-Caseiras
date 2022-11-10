import 'dart:ui';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/repositories/receitas_repository.dart';
import 'package:projeto_flutter_mobile/views/receitasFavoritas.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';

class ReceitasDetalhesPage extends StatefulWidget {
  Receita receita;

  ReceitasDetalhesPage({Key? key, required this.receita}) : super(key: key);

  @override
  _ReceitasDetalhesPageState createState() => _ReceitasDetalhesPageState();
}

late FavoritasRepository favoritas;

class _ReceitasDetalhesPageState extends State<ReceitasDetalhesPage> {
  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  final double coverHeight = 200;
  List<Receita> selecionadas = [];
  @override
  Widget build(BuildContext context) {
    favoritas = context.watch<FavoritasRepository>();
    //
    bool favoritada = false;
    if (favoritas.box.containsKey(widget.receita.nome)) {
      //if (favoritas.lista.contains(widget.receita)) {
      favoritada = true;
    } else {
      favoritada = false;
    }
    ;
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              (selecionadas.contains(widget.receita))
                  ? selecionadas.remove(widget.receita)
                  : selecionadas.add(widget.receita);
              if (!favoritada) {
                favoritas.saveAll(selecionadas);
                favoritada = true;
              } else {
                favoritada = false;
                favoritas.remove(widget.receita);
              }

              limparSelecionadas();
              print(selecionadas.length);
              print(favoritas.lista.length);
            },
            label: favoritada ? Text('Desfavoritar') : Text('Favoritar'),
            icon: const Icon(Icons.favorite),
            backgroundColor: favoritada ? Colors.grey : Colors.red),
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
          title: Text(
            widget.receita.nome,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[buildCoverImage(), buildContent()],
        ));
  }

  Widget buildCoverImage() => SizedBox(
        height: coverHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(widget.receita.imagem, fit: BoxFit.cover),
            ClipRRect(
                child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.orange.withOpacity(0.2),
                alignment: Alignment.center,
              ),
            ))
          ],
        ),
      );

  Widget buildContent() => Column(children: [
        const SizedBox(height: 8),
        Text(widget.receita.nome,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 34, 34, 34))),
        const SizedBox(height: 15),
        new Row(children: <Widget>[
          Flexible(
              child: GestureDetector(
                  child: Text(
                    'Tempo de Preparo:\n ' + widget.receita.tempo + ' minutos',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    print(favoritas.lista.length);
                  }))
        ]),
        const SizedBox(
          height: 25,
        ),
        new Row(
          children: <Widget>[
            new Flexible(
                child: new Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Modo de Preparo:\n', style: TextStyle(fontSize: 20)),
              TextSpan(
                  text: widget.receita.preparo, style: TextStyle(fontSize: 17)),
            ]))),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]);
}
