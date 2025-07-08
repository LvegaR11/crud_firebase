import 'package:crud_firebase/Services/firebase.service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Usuarios')),

      body: FutureBuilder(
        future: getAllUsers(),

        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,

              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async{
                    await deleteUser(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  } ,


                  confirmDismiss: (direction) async {
                    bool confirm = false;

                    confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Estás seguro de que quieres eliminar a ${snapshot.data?[index]['Nombre']}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                //await deleteUser(snapshot.data?[index]['uid']);
                                Navigator.pop(context, true);
                              },
                              child: const Text("Si, Eliminar"),
                            ),
                          ],
                        );
                      },
                    );

                    return confirm;
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    title: Text(snapshot.data?[index]['Nombre']),

                    onTap: (() async {
                      await Navigator.pushNamed(
                        context,
                        '/edit',
                        arguments: {
                          'name': snapshot.data?[index]['Nombre'],
                          'uid': snapshot.data?[index]['uid'],
                        },
                      );
                      setState(
                        () {},
                      ); // Actualiza la lista de usuarios después de editar uno
                    }),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(
            () {},
          ); // Acrualiza la lista de usuarios después de agregar uno nuevo
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
