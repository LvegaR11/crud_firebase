import 'package:flutter/material.dart';
import 'package:crud_firebase/Model/Celulares.dart';
import 'package:crud_firebase/Services/firebase.service.dart';

class EditarCelularPage extends StatefulWidget {
  final Celular celular;

  const EditarCelularPage({super.key, required this.celular});

  @override
  State<EditarCelularPage> createState() => _EditarCelularPageState();
}

class _EditarCelularPageState extends State<EditarCelularPage> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> campos;

  @override
  void initState() {
    super.initState();
    campos = widget.celular.toMap();
  }

  Future<void> guardarCambios() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final celularActualizado = Celular.fromMap(campos, widget.celular.id!);
      await updateCelular(widget.celular.id!, celularActualizado);
      Navigator.pop(context);
    }
  }

  Widget campoTexto(String label, String key, {TextInputType tipo = TextInputType.text}) {
    return TextFormField(
      initialValue: campos[key]?.toString(),
      keyboardType: tipo,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
      onSaved: (value) {
        if (tipo == TextInputType.number) {
          campos[key] = double.tryParse(value!) ?? 0;
        } else {
          campos[key] = value;
        }
      },
    );
  }

  Widget campoSwitch(String label, String key) {
    return SwitchListTile(
      title: Text(label),
      value: campos[key] ?? false,
      onChanged: (val) => setState(() => campos[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Celular'), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              campoTexto('Marca', 'marca'),
              const SizedBox(height: 12),
              campoTexto('IMEI', 'emai'),
              const SizedBox(height: 12),
              campoTexto('Pulgadas', 'pulgadas', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('RAM (GB)', 'ram', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Almacenamiento', 'almacenamientoPpal', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Sistema Operativo', 'sistemaOperativo'),
              const SizedBox(height: 12),
              campoSwitch('WiFi', 'wifi'),
              campoSwitch('Bluetooth', 'bluetooth'),
              campoSwitch('NFC', 'NFC'),
              campoSwitch('Huella', 'huella'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: guardarCambios,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(183, 230, 224, 224),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('¿Eliminar celular?'),
                      content: const Text('Esta acción no se puede deshacer.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await deleteCelular(widget.celular.id!);
                    Navigator.pop(context); // Cierra la pantalla de edición
                  }
                },
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar celular'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}