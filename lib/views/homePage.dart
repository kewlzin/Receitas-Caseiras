import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/views/inicio.dart';
import 'package:projeto_flutter_mobile/views/minhaConta.dart';
import 'package:projeto_flutter_mobile/widgets/aut_check.dart';
import 'package:provider/provider.dart';
import './receitasFavoritas.dart';

class HomePage extends StatefulWidget {
  @override
  HomePage({Key? key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
    super.initState();
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

//TODO fazer pagina configurações e receitas favoritas
  @override
  Widget build(BuildContext context) {
    //favoritas = Provider.of<FavoritasRepository>(context);

    return Scaffold(
      body: PageView(
        controller: pc,
        children: [inicio(), AuthCheck(), ReceitasFavoritas()],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Minha Conta'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Curtidas'),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
