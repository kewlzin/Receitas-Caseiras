// ignore: file_names
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/services/auth_services.dart';
import 'package:projeto_flutter_mobile/views/loginPage.dart';
import 'package:provider/provider.dart';
import './homePage.dart';

// ignore: camel_case_types
class minhaConta extends StatelessWidget {
  const minhaConta({super.key});
  final double coverHeight = 280;
  final double profileHeight = 144;
//TODO Fazer botão de login/cadastro
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        buildTop(context),
        buildContent(),
        FloatingActionButton(
            onPressed: () => context.read<AuthService>().logout())
      ],
    ));
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          const Text('Usuário',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 34, 34))),
          const SizedBox(height: 8),
          const Text('seuemail@email.com',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 34, 34, 34))),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          //         buildInfoPerfil(),
        ],
      );

  // Widget buildInfoPerfil() => Column(
  //       children: const [
  //         SizedBox(
  //           height: 10,
  //         ),
  //          Text('Suas Receitas:'),
  //       ],
  //     );

  Widget buildTop(context) {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ]);
  }

  Widget buildProfileImage() => CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: AssetImage("images/usericon.jpg"));

  Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.asset('images/fundo.jpg',
          width: double.infinity, height: coverHeight, fit: BoxFit.cover));
}
