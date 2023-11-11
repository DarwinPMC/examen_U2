

import 'package:asistenciaupeu_frontend/modelo/UsuarioModelo.dart';
import 'package:asistenciaupeu_frontend/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'usuario_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class UsuarioApi {
  factory UsuarioApi(Dio dio, {String baseUrl}) = _UsuarioApi;

  static UsuarioApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return UsuarioApi(dio);
  }

  @POST("/asis/login") //davidmpx@upeu.edu.pe //D123456
  Future<RespUsuarioModelo> login(@Body() UsuarioModelo usuario);

  @POST("/asis/loginByCorreo") //davidmpx@upeu.edu.pe //D123456
  Future<RespUsuarioModelo> loginByEmail(@Body() UsuarioModelo usuario);

}