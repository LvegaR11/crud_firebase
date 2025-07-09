import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/Model/Celulares.dart';
import 'package:crud_firebase/Pages/Editar_celulares_page.dart';
import 'package:crud_firebase/Services/firebase.service.dart';
import 'package:flutter/material.dart';

class ListaCelularesPage extends StatelessWidget {
  const ListaCelularesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('Celulares Registrados'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<List<Celular>>(
        stream: getCelulares(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final celulares = snapshot.data!;
            if (celulares.isEmpty) {
              return const Center(child: Text('No hay celulares registrados.'));
            }
            return ListView.builder(
              itemCount: celulares.length,
              itemBuilder: (context, index) {
                final c = celulares[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarCelularPage(celular: c),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      leading: const Icon(
                        Icons.phone_android,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        '${c.marca} - ${c.sistemaOperativo}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'RAM: ${c.ram} GB | Almacenamiento: ${c.almacenamientoPpal} GB',
                      ),
                      trailing: Text('${c.pulgadas}"'),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los celulares.'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/celular');
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar celular'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
