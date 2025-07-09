import 'package:crud_firebase/Services/firebase.service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(snapshot.data?[index]['uid']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Estás seguro de que quieres eliminar a ${snapshot.data?[index]['nombre']}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Sí, Eliminar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) async {
                    await deleteUser(snapshot.data?[index]['uid']);
                    setState(() {
                      snapshot.data?.removeAt(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Text(
                            (snapshot.data?[index]['nombre'] ?? '?').substring(0, 1).toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          snapshot.data?[index]['nombre'] ?? 'Nombre no disponible',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          snapshot.data?[index]['email'] ?? 'Sin correo',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: {
                              'uid': snapshot.data?[index]['uid'],
                              'nombre': snapshot.data?[index]['nombre'] ?? '',
                              'username': snapshot.data?[index]['username'] ?? '',
                              'email': snapshot.data?[index]['email'] ?? '',
                              'password': snapshot.data?[index]['password'] ?? '',
                            },
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los usuarios'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'btnCelulares',
            onPressed: () {
              Navigator.pushNamed(context, '/celulares');
            },
            icon: const Icon(Icons.smartphone),
            label: const Text('Celulares'),
            backgroundColor: const Color.fromARGB(183, 230, 224, 224),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'btnAgregarUsuario',
            onPressed: () async {
              await Navigator.pushNamed(context, '/add');
              setState(() {});
            },
            child: const Icon(Icons.person_add),
          ),
        ],
      ),
    );
    
  }
}