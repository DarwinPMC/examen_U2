
import 'package:asistenciaupeu_frontend/modelo/AsistenciaxModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/UrlApi.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'asistenciax_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class AsistenciaxApi {
  factory AsistenciaxApi(Dio dio, {String baseUrl}) = _AsistenciaxApi;
  static AsistenciaxApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return AsistenciaxApi(dio);
  }

  @GET("/asis/asistenciax/list")
  Future<List<AsistenciaxRespModelo>> getAsistenciapa(@Header("Authorization") String token);

  @POST("/asis/asistenciax/crear")
  Future<AsistenciaxModelo> createAsistenciapa(@Header("Authorization") String
  token,@Body() AsistenciaxModelo asistenciapa);

  @DELETE("/asis/asistenciax/eliminar/{id}")
  Future<GenericModelo> deleteAsistenciapa(@Header("Authorization") String token,
      @Path("id") int id);

  @PATCH("/asis/asistenciax/editar/{id}")
  Future<AsistenciaxModelo> updateAsistenciapa(@Header("Authorization") String
  token,@Path("id") int id, @Body() AsistenciaxModelo asistenciapa);

}