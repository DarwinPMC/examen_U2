// ignore_for_file: file_names, must_be_immutable, prefer_collection_literals
import 'package:flutter/material.dart';

@immutable
class ActividadModeloFire {
  late String id = "";
  late final String nombreActividad;
  late final String fecha;
  late final String horai;
  late final String minToler;
  late final String latitud;
  late final String longitud;
  late final String estado;
  late final String evaluar;
  late final String userCreate;
  late final String mater;
  late final String validInsc;
  late final String asisSubact;
  late final String entsal;
  late final String offlinex;

  ActividadModeloFire({
    required this.id,
    required this.nombreActividad,
    required this.fecha,
    required this.horai,
    required this.minToler,
    required this.latitud,
    required this.longitud,
    required this.estado,
    required this.evaluar,
    required this.userCreate,
    required this.mater,
    required this.validInsc,
    required this.asisSubact,
    required this.entsal,
    required this.offlinex,
  });

  ActividadModeloFire.unlaunched();

  ActividadModeloFire.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    nombreActividad = json['nombreActividad'];
    fecha = json['fecha'];
    horai = json['horai'];
    minToler = json['minToler'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    estado = json['estado'];
    evaluar = json['evaluar'];
    userCreate = json['userCreate'];
    mater = json['mater'];
    validInsc = json['validInsc'];
    asisSubact = json['asisSubact'];
    entsal = json['entsal'];
    offlinex = json['offlinex'];
  }

  factory ActividadModeloFire.fromJsonModelo(Map<String, dynamic> json) {
    return ActividadModeloFire(
      id: json['id'] ?? "",
      nombreActividad: json['nombreActividad'],
      fecha: json['fecha'],
      horai: json['horai'],
      minToler: json['minToler'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      estado: json['estado'],
      evaluar: json['evaluar'],
      userCreate: json['userCreate'],
      mater: json['mater'],
      validInsc: json['validInsc'],
      asisSubact: json['asisSubact'],
      entsal: json['entsal'],
      offlinex: json['offlinex'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombreActividad'] = nombreActividad;
    data['fecha'] = fecha;
    data['horai'] = horai;
    data['minToler'] = minToler;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['estado'] = estado;
    data['evaluar'] = evaluar;
    data['userCreate'] = userCreate;
    data['mater'] = mater;
    data['validInsc'] = validInsc;
    data['asisSubact'] = asisSubact;
    data['entsal'] = entsal;
    data['offlinex'] = offlinex;

    return data;
  }

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['id'] = id;
    data['nombreActividad'] = nombreActividad;
    data['fecha'] = fecha;
    data['horai'] = horai;
    data['minToler'] = minToler;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['estado'] = estado;
    data['evaluar'] = evaluar;
    data['userCreate'] = userCreate;
    data['mater'] = mater;
    data['validInsc'] = validInsc;
    data['asisSubact'] = asisSubact;
    data['entsal'] = entsal;
    data['offlinex'] = offlinex;
    return data;
  }
}
