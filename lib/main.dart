import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_flutter_mobile/configs/hive_config.dart';
import 'package:projeto_flutter_mobile/repositories/favoritas_repository.dart';
import 'package:projeto_flutter_mobile/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'views/homePage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveConfig.start();

  // runApp(ChangeNotifierProvider(
  //     create: (context) => FavoritasRepository(), child: MyApp()));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);
  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas Caseiras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                  color: Color.fromARGB(255, 255, 255, 255), size: 30)),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 0,
              selectedItemColor: Color.fromARGB(255, 70, 70, 70),
              unselectedItemColor: Color.fromARGB(200, 130, 130, 130),
              backgroundColor: Colors.white)),
      home: HomePage(),
    );
  }
}
