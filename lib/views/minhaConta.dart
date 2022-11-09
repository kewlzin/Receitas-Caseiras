// ignore: file_names
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_flutter_mobile/services/auth_services.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class minhaConta extends StatefulWidget {
  minhaConta({Key? key}) : super(key: key);

  @override
  State<minhaConta> createState() => _minhaContaState();
}

class _minhaContaState extends State<minhaConta> {
  final double coverHeight = 280;

  final double profileHeight = 144;
  List<Reference> refs = [];
  List<String> arquivos = [];
  bool loading = true;
  bool uploading = false;
  double total = 0;
//TODO Fazer botão de login/cadastro
  @override
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'images/img-${DateTime.now().toString()}.jpeg';
      final storageRef = FirebaseStorage.instance.ref();
      return storageRef.child(ref).putFile(
            file,
            SettableMetadata(
              cacheControl: "public, max-age=300",
              contentType: "image/jpeg",
              customMetadata: {
                "user": "123",
              },
            ),
          );
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickAndUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await upload(file.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          final photoRef = snapshot.ref;

          // final newMetadata = SettableMetadata(
          //   cacheControl: "public, max-age=300",
          //   contentType: "image/jpeg",
          // );
          // await photoRef.updateMetadata(newMetadata);

          arquivos.add(await photoRef.getDownloadURL());
          refs.add(photoRef);
          // final SharedPreferences prefs = await _prefs;
          // prefs.setStringList('images', arquivos);

          setState(() => uploading = false);
        }
      });
    }
  }

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
