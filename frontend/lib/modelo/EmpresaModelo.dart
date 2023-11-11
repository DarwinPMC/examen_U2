import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class EmpresaModelo {
  EmpresaModelo({
    required this.id,
    required this.nombre,
    required this.nombreCorto,
    required this.direccion,
    required this.ruc,
    required this.ubigeo,
    required this.userId,
  });

  EmpresaModelo.unlaunched();

  late int id = 0;
  late final String nombre;
  late final String nombreCorto;
  late final String direccion;
  late final String ruc;
  late final String ubigeo;
  late final UsuarioXModelo userId;

  EmpresaModelo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    nombreCorto = json['nombreCorto'];
    direccion = json['direccion'];
    ruc = json['ruc'];
    ubigeo = json['ubigeo'];
    userId = UsuarioXModelo.fromJson(json['userId']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['nombreCorto'] = nombreCorto;
    _data['direccion'] = direccion;
    _data['ruc'] = ruc;
    _data['ubigeo'] = ubigeo;
    _data['userId'] = userId.toJson();
    return _data;
  }
}

class UsuarioXModelo {
  UsuarioXModelo({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.password,
    required this.dni,
    required this.perfilPrin,
    required this.estado,
    required this.offlinex,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    required this.roles,
  });
  late final int id;
  late final String nombres;
  late final String apellidos;
  late final String correo;
  late final String password;
  late final String dni;
  late final String perfilPrin;
  late final String estado;
  late final String offlinex;
  late final List<int> fechaCreacion;
  late final List<int> fechaActualizacion;
  late final List<Roles> roles;

  UsuarioXModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    correo = json['correo'];
    password = json['password'];
    dni = json['dni'];
    perfilPrin = json['perfilPrin'];
    estado = json['estado'];
    offlinex = json['offlinex'];
    fechaCreacion = List.castFrom<dynamic, int>(json['fechaCreacion']);
    fechaActualizacion = List.castFrom<dynamic, int>(json['fechaActualizacion']);
    roles = List.from(json['roles']).map((e)=>Roles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombres'] = nombres;
    _data['apellidos'] = apellidos;
    _data['correo'] = correo;
    _data['password'] = password;
    _data['dni'] = dni;
    _data['perfilPrin'] = perfilPrin;
    _data['estado'] = estado;
    _data['offlinex'] = offlinex;
    _data['fechaCreacion'] = fechaCreacion;
    _data['fechaActualizacion'] = fechaActualizacion;
    _data['roles'] = roles.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Roles {
  Roles({
    required this.id,
    required this.rolNombre,
  });
  late final int id;
  late final String rolNombre;

  Roles.fromJson(Map<String, dynamic> json){
    id = json['id'];
    rolNombre = json['rolNombre'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['rolNombre'] = rolNombre;
    return _data;
  }
}
