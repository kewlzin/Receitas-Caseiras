// ignore_for_file: prefer_const_constructors
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_flutter_mobile/widgets/receita_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/views/receitas_detalhes.dart';
import '../models/receitas.api.dart';
import '../models/receitas.dart';

class inicio extends StatefulWidget {
  const inicio({super.key});
  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  late List<Receita> _receitas;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    getReceitas();
  }

  Future<void> getReceitas() async {
    _receitas = await ReceitaApi.getReceita();
    setState(() {
      _isLoading = false;
    });
    print(_receitas);
  }

  Widget build(BuildContext context) {
    // final tabela = ReceitaRepository.tabela;
    //   favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Color.fromARGB(255, 236, 181, 30),
              ),
              SizedBox(width: 10),
              Text(
                'Receitas Caseiras',
                style: TextStyle(color: Color.fromARGB(255, 236, 181, 30)),
              )
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _receitas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ReceitasDetalhesPage(receita: _receitas[index]),
                          ),
                        );
                      },
                      child: ReceitaCard(
                        nome: _receitas[index].nome,
                        tempo: _receitas[index].tempo,
                        curtidas: _receitas[index].curtidas.toString(),
                        imagem: _receitas[index].imagem,
                        //preparo: _receitas[index].preparo,
                      ));
                },
              ));
  }
}
//TODO category scroller

