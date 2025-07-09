import 'package:flutter/foundation.dart';

class Usuario {
  final String id;
  final String username;
  final String password;
  final String nombre;
  final String email;

  Usuario({
    required this.id,
    required this.username,
    required this.password,
    required this.nombre,
    required this.email,
  });



  @override
  String toString() {
    return 'Usuario{id: $id, username: $username, password: $password, nombre: $nombre, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Usuario &&
        other.id == id &&
        other.username == username &&
        other.password == password &&
        other.nombre == nombre &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ username.hashCode ^ password.hashCode ^ nombre.hashCode ^ email.hashCode;
  }
}   