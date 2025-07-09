import 'package:flutter/material.dart';

class Celular {
  String? id;
  String marca;
  String emai;
  double pulgadas;
  double megapx;
  int ram;
  int almacenamientoPpal;
  int almacenamientoSecun;
  String sistemaOperativo;
  String operador;
  String tecnologiaDeBanda;
  bool wifi;
  bool bluetooth;
  int camaras;
  String marcaCpu;
  double velocidadCpu;
  bool NFC;
  bool huella;
  bool IR;
  bool resteAgua;
  int cantidadSim;

  Celular({
    this.id,
    required this.marca,
    required this.emai,
    required this.pulgadas,
    required this.megapx,
    required this.ram,
    required this.almacenamientoPpal,
    required this.almacenamientoSecun,
    required this.sistemaOperativo,
    required this.operador,
    required this.tecnologiaDeBanda,
    required this.wifi,
    required this.bluetooth,
    required this.camaras,
    required this.marcaCpu,
    required this.velocidadCpu,
    required this.NFC,
    required this.huella,
    required this.IR,
    required this.resteAgua,
    required this.cantidadSim,
  });

 factory Celular.fromMap(Map<String, dynamic> data, String documentId) {
  try {
    return Celular(
      id: documentId,
      marca: data['marca'] ?? '',
      emai: data['emai'] ?? '',
      pulgadas: (data['pulgadas'] ?? 0).toDouble(),
      megapx: (data['megapx'] ?? 0).toDouble(),
      ram: (data['ram'] ?? 0).toInt(),
      almacenamientoPpal: (data['almacenamientoPpal'] ?? 0).toInt(),
      almacenamientoSecun: (data['almacenamientoSecun'] ?? 0).toInt(),
      sistemaOperativo: data['sistemaOperativo'] ?? '',
      operador: data['operador'] ?? '',
      tecnologiaDeBanda: data['tecnologiaDeBanda'] ?? '',
      wifi: data['wifi'] ?? false,
      bluetooth: data['bluetooth'] ?? false,
      camaras: (data['cámaras'] ?? data['camaras'] ?? 0).toInt(),
      marcaCpu: data['marcaCpu'] ?? '',
      velocidadCpu: (data['velocidadCpu'] ?? 0).toDouble(),
      NFC: data['NFC'] ?? false,
      huella: data['huella'] ?? false,
      IR: data['IR'] ?? false,
      resteAgua: data['resteAgua'] ?? false,
      cantidadSim: (data['cantidadSim'] ?? 0).toInt(),
    );
  } catch (e, stack) {
    print('❌ Error en documento $documentId: $e');
    print('📌 Stack trace: $stack');
    rethrow;
  }
}


  Map<String, dynamic> toMap() {
    return {
      'marca': marca,
      'emai': emai,
      'pulgadas': pulgadas,
      'megapx': megapx,
      'ram': ram,
      'almacenamientoPpal': almacenamientoPpal,
      'almacenamientoSecun': almacenamientoSecun,
      'sistemaOperativo': sistemaOperativo,
      'operador': operador,
      'tecnologiaDeBanda': tecnologiaDeBanda,
      'wifi': wifi,
      'bluetooth': bluetooth,
      'camaras': camaras,
      'marcaCpu': marcaCpu,
      'velocidadCpu': velocidadCpu,
      'NFC': NFC,
      'huella': huella,
      'IR': IR,
      'resteAgua': resteAgua,
      'cantidadSim': cantidadSim,
    };
  }
}