// ignore: file_names
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_flutter_mobile/services/auth_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projeto_flutter_mobile/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:projeto_flutter_mobile/views/loginPage.dart';

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
  String profilePicUrl = "";
  bool loading = true;
  bool uploading = false;
  double total = 0;
  bool control = true;
//TODO Fazer botão de login/cadastro
  @override
  final FirebaseStorage storage = FirebaseStorage.instance;

  // void checkexist() async {
  //   if (control) {
  //     try {
  //       String downloadProfile = await storage
  //           .ref('images/img-${FirebaseAuth.instance.currentUser!.email}.jpeg')
  //           .getDownloadURL();
  //       print('certo');
  //       profilePicUrl = downloadProfile;
  //     } on FirebaseException catch (e) {
  //       if (e.code == 'object-not-found') {
  //         print('nãocerto');
  //         profilePicUrl = "";
  //       } else {
  //         print("${e.code}");
  //         profilePicUrl = "";
  //       }
  //     }
  //     control = true;
  //   }
  // }

  void initState() {
    super.initState();
    loadImages();
  }

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try {
      String ref =
          'images/img-${FirebaseAuth.instance.currentUser!.email}.jpeg';
      // String ref = 'images/img-${DateTime.now().toString()}.jpeg';
      final storageRef = FirebaseStorage.instance.ref();
      return storageRef.child(ref).putFile(
            file,
            SettableMetadata(
              cacheControl: "public, max-age=300",
              contentType: "image/jpeg",
              customMetadata: {
                "user": "${FirebaseAuth.instance.currentUser!.email}",
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
          photoRef.getDownloadURL().then(
            (value) {
              print(value);
              setState(() {
                profilePicUrl = value;
              });
            },
          );
          // final SharedPreferences prefs = await _prefs;
          // prefs.setStringList('images', arquivos);

          setState(() => uploading = false);
        }
      });
    }
  }

  loadImages() async {
    // final SharedPreferences prefs = await _prefs;
    // arquivos = prefs.getStringList('images') ?? [];

    // if (arquivos.isEmpty) {
    //   String downloadProfile = await storage
    //           .ref('images/img-${FirebaseAuth.instance.currentUser!.email}.jpeg')
    //           .getDownloadURL();
    //       print('certo');
    //       profilePicUrl = downloadProfile;
    try {
      String downloadProfile = await storage
          .ref('images/img-${FirebaseAuth.instance.currentUser!.email}.jpeg')
          .getDownloadURL();
      profilePicUrl = downloadProfile;
      if (this.mounted) {
        setState(() => loading = false);
      }
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        profilePicUrl = "";
      }
    }

    // prefs.setStringList('images', arquivos);
    // }
  }

  Widget build(BuildContext context) {
    setState(() {
      print(profilePicUrl);
    });
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        buildTop(context),
        buildContent(),
      ],
    ));
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Text(FirebaseAuth.instance.currentUser!.email.toString(),
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 34, 34))),
          const SizedBox(height: 8),
          new IconButton(
            icon: new Icon(Icons.logout),
            color: Colors.black,
            onPressed: () {
              context.read<AuthService>().logout();
            },
          ),
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

  Widget buildProfileImage() => SizedBox(
        height: 144,
        width: 144,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            profilePicUrl == ""
                ? CircleAvatar(
                    backgroundImage: AssetImage("images/usericon.jpg"),
                  )
                : CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(profilePicUrl)),
            Positioned(
              bottom: 0,
              right: -25,
              child: RawMaterialButton(
                onPressed: pickAndUploadImage,
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  uploading ? Icons.lock_clock : Icons.camera_alt_outlined,
                  color: Colors.orange,
                ),
                padding: EdgeInsets.all(10),
                shape: CircleBorder(),
              ),
            )
          ],
        ),
      );

//  Widget buildProfileImage() => CircleAvatar(
//        radius: profileHeight / 2,
//        backgroundColor: Colors.grey.shade800,
//        backgroundImage: AssetImage("images/usericon.jpg"),
//        child: InkWell(
//          onTap: () {},
//          splashColor: Colors.white,
//          child: Ink.image(
//            fit: BoxFit.cover,
//            width: 15,
//            height: 15,
//            image: AssetImage('images/change_profile_picture.png'),
//          ),
//        ),
//      );

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'images/fundo.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );
}
