// ignore_for_file: file_names, must_be_immutable, prefer_collection_literals
import 'package:asistenciaupeu_frontend/modelo/ActividadModeloFire.dart';
import 'package:flutter/material.dart';

@immutable
class AsistenciaxModeloFire {
  late String id = "";
  late final String fecha;
  late final String horaReg;
  late final String latituda;
  late final String longituda;
  late final String tipo;
  late final int calificacion;
  late final String cui;
  late final String tipoCui;
  late final String entsal;
  late final int subactasisId;
  late final String offlinex;
  late final ActividadModeloFire actividadId;

  AsistenciaxModeloFire({
    required this.id,
    required this.fecha,
    required this.horaReg,
    required this.latituda,
    required this.longituda,
    required this.tipo,
    required this.calificacion,
    required this.cui,
    required this.tipoCui,
    required this.entsal,
    required this.subactasisId,
    required this.offlinex,
    required this.actividadId,
  });
  AsistenciaxModeloFire.unlaunched();

  AsistenciaxModeloFire.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fecha = json['fecha'];
    horaReg = json['horaReg'];
    latituda = json['latituda'];
    longituda = json['longituda'];
    tipo = json['tipo'];
    calificacion = json['calificacion'];
    cui = json['cui'];
    tipoCui = json['tipoCui'];
    entsal = json['entsal'];
    subactasisId = json['subactasisId'];
    offlinex = json['offlinex'];
    actividadId = json['actividadId'] != null
        ? ActividadModeloFire.fromJsonModelo(json['actividadId'])
        : ActividadModeloFire.unlaunched();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fecha'] = fecha;
    data['horaReg'] = horaReg;
    data['latituda'] = latituda;
    data['longituda'] = longituda;
    data['tipo'] = tipo;
    data['calificacion'] = calificacion;
    data['cui'] = cui;
    data['tipoCui'] = tipoCui;
    data['entsal'] = entsal;
    data['subactasisId'] = subactasisId;
    data['offlinex'] = offlinex;
    //data['actividadId'] = actividadId;
    data['actividadId'] = actividadId.id;
    return data;
  }

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['id'] = id;
    data['fecha'] = fecha;
    data['horaReg'] = horaReg;
    data['latituda'] = latituda;
    data['longituda'] = longituda;
    data['tipo'] = tipo;
    data['calificacion'] = calificacion;
    data['cui'] = cui;
    data['tipoCui'] = tipoCui;
    //data['actividad'] = this.actividad;
    data['actividadId'] = actividadId.id;
    return data;
  }
}
