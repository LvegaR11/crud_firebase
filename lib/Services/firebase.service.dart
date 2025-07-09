import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Funcion para obtener todos los usuarios
Future<List<Map<String, dynamic>>> getAllUsers() async {
  List<Map<String, dynamic>> users = [];

  QuerySnapshot queryUsuarios = await db.collection('Usuarios').get();

  for (var doc in queryUsuarios.docs) {
    final data = doc.data() as Map<String, dynamic>;
    users.add({
      'uid': doc.id,
      'nombre': data['nombre'] ?? '',
      'username': data['username'] ?? '',
      'email': data['email'] ?? '',
      'password': data['password'] ?? '',
    });
  }

  return users;
}


//Funcion para agregar un usuario
Future<void> addUser({
  required String username,
  required String password,
  required String nombre,
  required String email,
}) async {
  await FirebaseFirestore.instance.collection('Usuarios').add({
    'username': username,
    'password': password,
    'nombre': nombre,
    'email': email,
  });
}


//Funcion para actualizar un usuario
Future<void> updateUser(
  String uid, {
  required String username,
  required String password,
  required String nombre,
  required String email,
}) async {
  await FirebaseFirestore.instance.collection('Usuarios').doc(uid).update({
    'username': username,
    'password': password,
    'nombre': nombre,
    'email': email,
  });
}


//Funcion para eliminar un usuario
Future<void> deleteUser(String uid) async {
  CollectionReference usersCollection = db.collection('Usuarios');

  await usersCollection.doc(uid).delete();
}
