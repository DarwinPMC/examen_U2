import 'package:asistenciaupeu_frontend/apis/empresa_api.dart';
import 'package:asistenciaupeu_frontend/modelo/EmpresaModelo.dart';
import 'package:asistenciaupeu_frontend/modelo/GenericModelo.dart';
import 'package:asistenciaupeu_frontend/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class EmpresaRepository {
  EmpresaApi? empresaApi;

  EmpresaRepository() {
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    empresaApi = EmpresaApi(dio);
  }

  Future<List<EmpresaModelo>> getEmpresa() async {
    print("llega:"+TokenUtil.TOKEN);
    var resultant =
        await empresaApi!.getEmpresa(TokenUtil.TOKEN).then((value) => value);

    return resultant;
  }

  Future<GenericModelo> deleteEmpresa(int id) async {
    return await empresaApi!.deleteEmpresa(TokenUtil.TOKEN, id);
  }

  Future<EmpresaModelo> updateEmpresa(int id, EmpresaModelo empresa) async {
    return await empresaApi!.updateEmpresa(TokenUtil.TOKEN, id, empresa);
  }

  Future<EmpresaModelo> createEmpresa(EmpresaModelo empresa) async {
    return await empresaApi!.crearEmpresa(TokenUtil.TOKEN, empresa);
  }
}
