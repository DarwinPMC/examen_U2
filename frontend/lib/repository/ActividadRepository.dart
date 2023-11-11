// ignore_for_file: unnecessary_new, avoid_function_literals_in_foreach_calls

import 'package:asistenciaupeu_frontend/apis/actividad_api.dart';
import 'package:asistenciaupeu_frontend/local/condb/conexionDB.dart';
import 'package:asistenciaupeu_frontend/modelo/ActividadModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/NetworConnection.dart';
import 'package:asistenciaupeu_frontend/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class ActividadRepository with ConexionDB {
  ActividadApi? actividadApi;
  ActividadRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    actividadApi = ActividadApi(_dio);
  }
//Aquí codigo

  Future<List<ActividadModelo>> getActividad() async {
    final actividaddDao = (await conetion()).actividadDao;
    if (await isConected()) {
//return await actividadApi!.getActividad(TokenUtil.TOKEN).then((value) => value.data);
      var dato = await actividadApi!
          .getActividad(TokenUtil.TOKEN)
          .then((value) => value);
      dato.forEach((el) async {
        await actividaddDao.insertActividad(new ActividadModelo(
          id: el.id,
          nombreActividad: el.nombreActividad,
          fecha: el.fecha,
          horai: el.horai,
          minToler: el.minToler,
          latitud: el.latitud,
          longitud: el.longitud,
          estado: el.estado,
          evaluar: el.evaluar,
          userCreate: el.userCreate,
          mater: el.mater,
          validInsc: el.validInsc,
          asisSubact: el.asisSubact,
          entsal: el.entsal,
          offlinex: el.offlinex
        ));
      });
//final result = await actividaddDao.findActividadById(18);
      return dato;
//return await actividaddDao.findAllActidad();
    } else {
      return await actividaddDao.findAllActidad();
    }
  }

  Future<GenericModelo> deleteActividad(int id) async {
    final actividaddDao = (await conetion()).actividadDao;
    if (await isConected()) {
      actividaddDao.deleteActividad(id);
      return await actividadApi!.deleteActividad(TokenUtil.TOKEN, id);
    } else {
      actividaddDao.deleteActividad(id);
      Map<String, dynamic> resultado = {'Eliminado': true};
      return Future.value(GenericModelo.fromJson(resultado));
    }
  }

  Future<ActividadModelo> updateActividad(
      int id, ActividadModelo actividad) async {
    final actividaddDao = (await conetion()).actividadDao;
    if (await isConected()) {
      return await actividadApi!
          .updateActividad(TokenUtil.TOKEN, id, actividad);
    } else {
      actividaddDao.updateActividad(actividad);
      return actividad;
    }
  }

  Future<ActividadModelo> createActividad(ActividadModelo actividad) async {
    final actividaddDao = (await conetion()).actividadDao;
    if (await isConected()) {
      return await actividadApi!.crearActividad(TokenUtil.TOKEN, actividad);
    } else {
      actividaddDao.insertActividad(actividad);
      return actividad;
    }
  }
}
