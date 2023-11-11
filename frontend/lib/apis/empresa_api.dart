
import 'package:asistenciaupeu_frontend/modelo/EmpresaModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'empresa_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class EmpresaApi {
  factory EmpresaApi(Dio dio, {String baseUrl}) = _EmpresaApi;

  static EmpresaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return EmpresaApi(dio);
  }

  @GET("/api/empresa/list")
  Future<List<EmpresaModelo>> getEmpresa(@Header("Authorization") String token);

  @POST("/api/empresa/crear")
  Future<EmpresaModelo> crearEmpresa(@Header("Authorization") String token, @Body() EmpresaModelo empresa);

  @GET("/api/empresa/buscar/{id}")
  Future<EmpresaModelo> findEmpresa(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/api/empresa/eliminar/{id}")
  Future<GenericModelo> deleteEmpresa(@Header("Authorization") String token, @Path("id") int id);

  @PUT("/api/empresa/editar/{id}")
  Future<EmpresaModelo> updateEmpresa(@Header("Authorization") String token, @Path("id") int id , @Body() EmpresaModelo empresa);
}