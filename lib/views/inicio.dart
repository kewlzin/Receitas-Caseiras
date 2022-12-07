// ignore_for_file: prefer_const_constructors
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:projeto_flutter_mobile/widgets/receita_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/models/receitas.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/repositories/receitas_repository.dart';
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
  }

  Widget build(BuildContext context) {
    final tabela = ReceitaRepository.tabela;
    //   favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Food Recipe')
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _receitas.length,
                itemBuilder: (context, index) {
                  return ReceitaCard(
                    nome: _receitas[index].nome,
                    tempo: _receitas[index].tempo,
                    curtidas: _receitas[index].curtidas.toString(),
                    imagem: _receitas[index].imagem,
                    modopreparo: _receitas[index].preparo,
                  );
                },
              ));
  }
}
//TODO category scroller

