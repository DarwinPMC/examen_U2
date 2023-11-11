// ignore_for_file: unnecessary_new, prefer_final_fields, no_logic_in_create_state, must_be_immutable
import 'package:asistenciaupeu_frontend/bloc/empresa/empresa_bloc.dart';
import 'package:asistenciaupeu_frontend/comp/DropDownFormField.dart';
import 'package:asistenciaupeu_frontend/modelo/EmpresaModelo.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyFormEdit extends StatefulWidget {
  EmpresaModelo modelA;

  CompanyFormEdit({super.key, required this.modelA});

  @override
  EmpresaFormEditState createState() => EmpresaFormEditState(modelA: modelA);
}

class EmpresaFormEditState extends State<CompanyFormEdit> {
  EmpresaModelo modelA;
  EmpresaFormEditState({required this.modelA}) : super();

  late String nombre = "";
  late String nombreCorto = "";
  late String direccion = "";
  late String ruc = "";
  late String ubigeo = "";
  late String userId = "";

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  void capturaNombreEmpr(valor) {
    nombre = valor;
  }

  void capturaNombreCortoEmpr(valor) {
    nombreCorto = valor;
  }

  void capturaDirecccion(valor) {
    direccion = valor;
  }

  void capturaRuc(valor) {
    ruc = valor;
  }

  void capturaUbigeo(valor) {
    ubigeo = valor;
  }

  void capturaUsuario(valor) {
    userId = valor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Empresa B"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(24),
              //color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDatoCadena(
                        capturaNombreEmpr, modelA.nombre, "Nombre Empresa:"),
                    _buildDatoCadena(capturaNombreCortoEmpr, modelA.nombreCorto,
                        "Nombre Corto:"),
                    _buildDatoCadena(
                        capturaDirecccion, modelA.direccion, "Dirección:"),
                    _buildDatoCadena(capturaRuc, modelA.ruc, "RUC:"),
                    _buildDatoCadena(capturaUbigeo, modelA.ubigeo, "Ubigeo:"),
                    //_buildDatoCadena(capturaUsuario, modelA.userId as String, "Usuario:"),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState!.save();
                                EmpresaModelo mp = EmpresaModelo.unlaunched();
                                mp.nombre = nombre;
                                mp.nombreCorto = nombreCorto;
                                mp.direccion = direccion;
                                mp.ruc = ruc;
                                mp.ubigeo = ubigeo;
                                //mp.userId = userId as UserId;
                                mp.id = modelA.id;

                                /*var api = await Provider.of<EmpresaApi>(
                                    context,
                                    listen: false)
                                    .updateEmpresa(TokenUtil.TOKEN,modelA.id.toInt(), mp);
                                print("ver: ${api.toJson()}");
                                if (api.toJson()!=null) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }*/
                                BlocProvider.of<EmpresaBloc>(context)
                                    .add(UpdateEmpresaEvent(mp));
                                Navigator.pop(context, () {
                                  //setState(() {});
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }

  Widget _buildDatoEntero(Function obtValor, String dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: dato,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(int.parse(value!));
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String dato, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: dato,
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor(value!);
      },
    );
  }

  Widget buildDatoLista(
      Function obtValor, dato, String label, List<dynamic> listaDato) {
    return DropDownFormField(
      titleText: label,
      hintText: 'Seleccione',
      value: dato,
      onSaved: (value) {
        setState(() {
          obtValor(value);
        });
      },
      onChanged: (value) {
        setState(() {
          obtValor(value);
        });
      },
      dataSource: listaDato,
      textField: 'display',
      valueField: 'value',
    );
  }
}
