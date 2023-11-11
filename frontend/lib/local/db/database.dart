import 'dart:async';
import 'package:asistenciaupeu_frontend/local/dao/ActividadDao.dart';
import 'package:asistenciaupeu_frontend/modelo/ActividadModelo.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

//https://github.com/pinchbv/floor
//flutter packages pub run build_runner build
//flutter packages pub run build_runner watch
@Database(version: 2, entities: [ActividadModelo])
abstract class AppDatabase extends FloorDatabase {
  ActividadDao get actividadDao;
}
