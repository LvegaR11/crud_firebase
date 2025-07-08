import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Funcion para obtener todos los usuarios
Future<List> getAllUsers() async {
  List users = [];

  CollectionReference usersCollection = db.collection('Usuarios');

  QuerySnapshot queryUsuarios = await usersCollection.get();

  queryUsuarios.docs.forEach((doc) {

    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final user = {
      "Nombre": data['Nombre'], // Maneja ambos casos
      "uid": doc.id,
    };

    users.add(user);
  });

  await Future.delayed(const Duration(seconds: 1));

  return users;
}

//Funcion para agregar un usuario
Future<void> addUser(String name) async {
  CollectionReference usersCollection = db.collection('Usuarios');

  await usersCollection.add({'Nombre': name});
}

//Funcion para actualizar un usuario
Future<void> updateUser(String uid, String newName) async {
  CollectionReference usersCollection = db.collection('Usuarios');

  await usersCollection.doc(uid).set({'Nombre': newName});
}
