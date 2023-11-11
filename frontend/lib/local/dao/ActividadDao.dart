import 'package:asistenciaupeu_frontend/modelo/ActividadModelo.dart';
import 'package:floor/floor.dart';

@dao
abstract class ActividadDao {
  @Query('SELECT * FROM Actividad')
  Future<List<ActividadModelo>> findAllActidad();
  @Query('SELECT nombreActividad FROM Actividad')
  Stream<List<String>> findAllActivdadName();
  @Query('SELECT * FROM Actividad WHERE id = :id')
  Stream<ActividadModelo?> findActividadById(int id);
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertActividad(ActividadModelo actividad);
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllActividad(List<ActividadModelo> todo);
  @update
  Future<void> updateActividad(ActividadModelo actividad);
  @Query("delete from Actividad where id = :id")
  Future<void> deleteActividad(int id);
  @delete
  Future<void> deleteAll(List<ActividadModelo> list);
}
