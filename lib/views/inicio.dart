// ignore_for_file: prefer_const_constructors
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/repositories/receitas_repository.dart';
import 'package:projeto_flutter_mobile/views/receitas_detalhes.dart';

class inicio extends StatefulWidget {
  const inicio({super.key});
  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  mostrarDetalhes(Receita receita) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReceitasDetalhesPage(receita: receita),
      ),
    );
  }

//  late FavoritasRepository favoritas;
  @override
  Widget build(BuildContext context) {
    final tabela = ReceitaRepository.tabela;
    //   favoritas = context.watch<FavoritasRepository>();
    return Container(
        color: Colors.transparent,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          new Container(
              height: 60,
              margin: const EdgeInsets.only(
                top: 30,
              ),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(17, 0, 0, 0),
                    blurRadius: 8,
                    spreadRadius: 3,
                    offset: Offset(0, 10))
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Receitas',
                      style: TextStyle(
                        color: Color.fromARGB(255, 78, 78, 78),
                        fontSize: 30,
                        fontFamily: 'Schyler',
                      )),
                  Icon(
                    Icons.local_dining,
                    color: Color.fromARGB(255, 219, 143, 29),
                  ),
                  Text('Caseiras',
                      style: TextStyle(
                        color: Color.fromARGB(255, 78, 78, 78),
                        fontSize: 30,
                        fontFamily: 'Schyler',
                      )),
                ],
              )),
          Expanded(
              //      child: ListView(
              child: ListView.builder(
                  itemCount: tabela.length,
                  itemBuilder: ((context, receita) {
                    return Container(
                        child: InkWell(
                      splashColor: Colors.grey,
                      // onTap: () => print(tabela[receita].nome + "foi pressionado"),
                      onTap: () => mostrarDetalhes(tabela[receita]),
                      child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 30,
                            left: 50,
                            right: 50,
                          ),
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(tabela[receita].imagem),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                            ),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Color.fromARGB(255, 150, 14, 4)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      tabela[receita].nome,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontFamily: 'avenir',
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(Icons.favorite,
                                            color: Colors.white),
                                        Text(
                                          tabela[receita].curtidas,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Icon(Icons.timelapse_sharp,
                                            color: Colors.white),
                                        Text(
                                          tabela[receita].tempo,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ));
                  })))
        ]));
  }
}
//TODO category scroller

