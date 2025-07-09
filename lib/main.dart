import 'package:crud_firebase/Pages/Agregar_usuarios_page.dart';
import 'package:crud_firebase/Pages/Editar_usuarios_page.dart';
import 'package:crud_firebase/Pages/Login_usuarios_page.dart';
import 'package:crud_firebase/Pages/home_page.dart';
import 'package:flutter/material.dart';

//Importamos el paquete de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Firebase',
      initialRoute: '/login',
      routes: {
         '/': (context) => const Home(), // Lista de usuarios
         '/login': (context) => const LoginPage(),
         '/add': (context) => const AgregarUsuarios(),
         '/edit': (context) => const EditarUsuariosPage(),

      },
    );
  }
}

