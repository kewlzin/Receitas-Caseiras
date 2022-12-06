import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_flutter_mobile/main.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/repositories/receitas_repository.dart';
import 'package:projeto_flutter_mobile/views/loginPage.dart';
import 'package:projeto_flutter_mobile/views/receitasFavoritas.dart';
import 'package:projeto_flutter_mobile/widgets/aut_check.dart';
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
    if (favoritas.lista.contains(widget.receita)) {
      favoritada = true;
    } else {
      favoritada = false;
    }
    ;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (FirebaseAuth.instance.currentUser?.email == null) {
              print('No user found');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AuthCheck(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text(
                      'Ops! Você precisa estar conectado para favoritar!'),
                  duration: const Duration(seconds: 2)));
            } else {
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
            }
            ;

            // print(selecionadas.length);
            // print(favoritas.lista.length);
            // print(favoritas.lista.toString());
            // print(favoritas.box.keys);
          },
          label: favoritada ? Text('Desfavoritar') : Text('Favoritar'),
          icon: const Icon(Icons.favorite),
          backgroundColor: favoritada ? Colors.grey : Colors.red),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: Stack(
        children: [
          Container(
            child: buildCoverImage(),
          ),
          ListView(
            padding: EdgeInsets.only(top: coverHeight + 120),
            children: [buildContent()],
          )
        ],

        //children: <Widget>[buildCoverImage(), buildContent()],
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(4, 24, 24, 24),
        elevation: 0,
      ),
    );
  }

  Widget buildCoverImage() => SizedBox(
        height: coverHeight + 100,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(widget.receita.imagem, fit: BoxFit.cover),
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
          Icon(Icons.watch_later_rounded),
          Flexible(
            child: Text(
              widget.receita.tempo + ' minutos',
              style: TextStyle(fontSize: 20),
            ),
          )
        ]),
        const SizedBox(
          height: 15,
        ),
        new Row(
          children: <Widget>[
            Icon(Icons.local_dining),
            Flexible(
                child:
                    Text('Modo de preparo:', style: TextStyle(fontSize: 20))),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        new Row(children: <Widget>[
          Flexible(
              child: new Text.rich(TextSpan(children: [
            TextSpan(
                text: widget.receita.preparo,
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 133, 133, 133))),
          ]))),
        ]),
        const SizedBox(
          height: 10,
        ),
      ]);
}
