import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/views/receitas_detalhes.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';
import 'package:provider/provider.dart';

class ReceitasFavoritas extends StatefulWidget {
  const ReceitasFavoritas({super.key});

  @override
  State<ReceitasFavoritas> createState() => _ReceitasFavoritasState();
}

class _ReceitasFavoritasState extends State<ReceitasFavoritas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Receitas Favoritas',
          style: TextStyle(color: Color.fromARGB(255, 37, 37, 37)),
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: 30),
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.lista.isEmpty
                ? const ListTile(
                    leading: Icon(Icons.heart_broken),
                    title: Text('Você ainda não tem receitas favoritas'),
                  )
                : ListView.builder(
                    itemCount: favoritas.lista.length,
                    itemBuilder: ((context, index) {
                      return Container(
                          child: InkWell(
                        splashColor: Colors.grey,
                        // onTap: () => print(tabela[receita].nome + "foi pressionado"),
                        child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 30,
                              left: 50,
                              right: 50,
                            ),
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage(favoritas.lista[index].imagem),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        favoritas.lista[index].nome,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                            favoritas.lista[index].curtidas,
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
                                            favoritas.lista[index].tempo,
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
                    }),
                  );
          },
        ),
      ),
    );
  }
}
