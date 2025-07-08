import 'package:crud_firebase/Services/firebase.service.dart';
import 'package:flutter/material.dart';

class AgregarUsuarios extends StatefulWidget {
  const AgregarUsuarios({super.key});

  @override
  State<AgregarUsuarios> createState() => _AgregarUsuariosState();
}

class _AgregarUsuariosState extends State<AgregarUsuarios> {
  // Aquí puedes agregar variables y métodos para manejar la lógica de agregar usuarios
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Usuario'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(20.0),

        child : Column(
        children: [
          TextField(
            controller: nameController,
            decoration:  InputDecoration(
              labelText: 'Ingresa un Nombre',
            ),
          ),
          ElevatedButton(onPressed: () async{
             await addUser(nameController.text).then((_) {
              Navigator.pop(context);
             });
          }, 
          child: const Text("Guardar Usuario"))
        ]
      ))
      
      
    );
  }
}