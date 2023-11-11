// ignore_for_file: library_private_types_in_public_api

import 'package:asistenciaupeu_frontend/bloc/empresa/empresa_bloc.dart';
import 'package:asistenciaupeu_frontend/modelo/EmpresaModelo.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmpresaForm extends StatefulWidget {
  const EmpresaForm({super.key});

  @override
  _EmpresaFormState createState() => _EmpresaFormState();
}

class _EmpresaFormState extends State<EmpresaForm> {
  late String nombre = "";
  late String nombreCorto = "";
  late String direccion = "";
  late String ruc = "";
  late String ubigeo = "";
  late UsuarioXModelo userId;

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

  void capturaUsuario(UsuarioXModelo valor) {
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
                    _buildDatoCadena(capturaNombreEmpr, "Nombre Empresa:"),
                    _buildDatoCadena(capturaNombreCortoEmpr, "Nombre Corto:"),
                    _buildDatoCadena(capturaDirecccion, "Dirección:"),
                    _buildDatoCadena(capturaRuc, "RUC:"),
                    _buildDatoCadena(capturaUbigeo, "Ubigeo:"),
                    _buildDatoEntero(capturaUsuario, "Usuario:"),
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
                                mp.userId = userId;
                                print("NA:$nombre"
                                    "F:$direccion HI:$nombreCorto "
                                    "La: $ruc, Lo:$ubigeo "
                                    "EV:$userId");
                                BlocProvider.of<EmpresaBloc>(context)
                                    .add(CreateEmpresaEvent(mp));
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

  Widget _buildDatoEntero(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Id es campo Requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        obtValor([value!]);
      },
    );
  }

  Widget _buildDatoCadena(Function obtValor, String label) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
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
}
