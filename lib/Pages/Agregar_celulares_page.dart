import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgregarCelularPage extends StatefulWidget {
  const AgregarCelularPage({super.key});

  @override
  State<AgregarCelularPage> createState() => _AgregarCelularPageState();
}

class _AgregarCelularPageState extends State<AgregarCelularPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> celular = {};

  Future<void> guardarCelular() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('celulares').add(celular);
      Navigator.pop(context);
    }
  }

  Widget campoTexto(String label, String key, {TextInputType tipo = TextInputType.text}) {
    return TextFormField(
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
      onSaved: (value) => celular[key] = tipo == TextInputType.number ? double.tryParse(value!) ?? 0 : value,
    );
  }

  Widget campoSwitch(String label, String key) {
    return SwitchListTile(
      title: Text(label),
      value: celular[key] ?? false,
      onChanged: (val) => setState(() => celular[key] = val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('Registrar Celular'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.phone_android, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 20),
              campoTexto('Marca', 'marca'),
              const SizedBox(height: 12),
              campoTexto('IMEI', 'emai'),
              const SizedBox(height: 12),
              campoTexto('Pulgadas', 'pulgadas', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Megapíxeles', 'megapx', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('RAM (GB)', 'ram', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Almacenamiento Principal (GB)', 'almacenamientoPpal', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Almacenamiento Secundario (GB)', 'almacenamientoSecun', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Sistema Operativo', 'sistemaOperativo'),
              const SizedBox(height: 12),
              campoTexto('Operador', 'operador'),
              const SizedBox(height: 12),
              campoTexto('Tecnología de Banda', 'tecnologiaDeBanda'),
              const SizedBox(height: 12),
              campoTexto('Cantidad de Cámaras', 'camaras', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Marca CPU', 'marcaCpu'),
              const SizedBox(height: 12),
              campoTexto('Velocidad CPU (GHz)', 'velocidadCpu', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoTexto('Cantidad SIM', 'cantidadSim', tipo: TextInputType.number),
              const SizedBox(height: 12),
              campoSwitch('WiFi', 'wifi'),
              campoSwitch('Bluetooth', 'bluetooth'),
              campoSwitch('NFC', 'NFC'),
              campoSwitch('Huella', 'huella'),
              campoSwitch('Infrarrojo (IR)', 'IR'),
              campoSwitch('Resistente al Agua', 'resteAgua'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: guardarCelular,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Celular'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
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