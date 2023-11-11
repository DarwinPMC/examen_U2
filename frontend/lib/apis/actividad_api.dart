
import 'package:asistenciaupeu_frontend/modelo/ActividadModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'actividad_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class ActividadApi {
  factory ActividadApi(Dio dio, {String baseUrl}) = _ActividadApi;

  static ActividadApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ActividadApi(dio);
  }

  @GET("/asis/actividad/list")
  Future<List<ActividadModelo>> getActividad(@Header("Authorization") String token);

  @POST("/asis/actividad/crear")
  Future<ActividadModelo> crearActividad(@Header("Authorization") String token, @Body() ActividadModelo actividad);

  @GET("/asis/actividad/buscar/{id}")
  Future<ActividadModelo> findActividad(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/asis/actividad/eliminar/{id}")
  Future<GenericModelo> deleteActividad(@Header("Authorization") String token, @Path("id") int id);

  @PUT("/asis/actividad/editar/{id}")
  Future<ActividadModelo> updateActividad(@Header("Authorization") String token, @Path("id") int id , @Body() ActividadModelo actividad);
}