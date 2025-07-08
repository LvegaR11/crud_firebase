import 'package:crud_firebase/Services/firebase.service.dart';
import 'package:flutter/material.dart';

class EditarUsuariosPage extends StatefulWidget {
  const EditarUsuariosPage({super.key});

  @override
  State<EditarUsuariosPage> createState() => _EditarUsuariosPageState();
}

class  _EditarUsuariosPageState extends State <EditarUsuariosPage> {
  
  TextEditingController nameController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = arguments['name'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(20.0),

        child : Column(
        children: [
          TextField(
            controller: nameController,
            decoration:  InputDecoration(
              labelText: 'Ingresa el nuevo Nombre',
            ),
          ),
          ElevatedButton(
            onPressed: () async{

             await updateUser(arguments['uid'], nameController.text).then((_){
              Navigator.pop(context);
             }); 
              
    
          }, 
          child: const Text("Actualizar"))
        ]
      ))
      
      
    );
  }
}