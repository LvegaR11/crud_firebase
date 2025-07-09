import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/Model/Celulares.dart';

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


//Funcion para agregar un celular
Future<void> addCelular(Celular celular) async {
  await FirebaseFirestore.instance
      .collection('celulares')
      .add(celular.toMap());
}

//Funcion para obtener todos los celulares
Stream<List<Celular>> getCelulares() {
  return FirebaseFirestore.instance
      .collection('celulares')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          try {
            return Celular.fromMap(doc.data(), doc.id);
          } catch (e) {
            return null;
          }
        }).whereType<Celular>().toList();
      });
}


//Funcion para editar un celular
Future<void> updateCelular(String id, Celular celular) async {
  await FirebaseFirestore.instance
      .collection('celulares')
      .doc(id)
      .update(celular.toMap());
}

//Funcion para eliminar un celular
Future<void> deleteCelular(String id) async {
  await FirebaseFirestore.instance.collection('celulares').doc(id).delete();
}

