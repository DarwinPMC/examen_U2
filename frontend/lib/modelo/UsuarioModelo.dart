import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModelo {
  UserModelo({
    required this.correo,
  });

  UserModelo.loginGoogle(this.correo);

  late final String correo;

  factory UserModelo.fromJson(Map<String, dynamic> json) {
    return UserModelo(correo: json['correo']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['correo'] = correo;

    return data;
  }
}

class UsuarioModelo {
  UsuarioModelo({
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.password,
    required this.token,
    required this.dni,
    required this.perfilPrin,
    required this.estado,
    required this.offlinex,
  });

  UsuarioModelo.unlaunched();

  UsuarioModelo.loginByEmail(this.correo)
      : password = "",
        nombres = "",
        apellidos = "",
        token = "",
        dni = "",
        perfilPrin = "",
        estado = "",
        offlinex = "";
  UsuarioModelo.login(this.correo, this.password)
      : nombres = "",
        apellidos = "",
        token = "",
        dni = "",
        perfilPrin = "",
        estado = "",
        offlinex = "";
  UsuarioModelo.loginDos(this.correo, this.password)
      : nombres = "",
        apellidos = "";

  late final String nombres;
  late final String apellidos;
  late final String correo;
  late final String password;
  late final String token;
  late final String dni;
  late final String perfilPrin;
  late final String estado;
  late final String offlinex;

  factory UsuarioModelo.fromJson(Map<String, dynamic> json) {
    return UsuarioModelo(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      correo: json['correo'],
      password: json['password'],
      token: json['token'],
      dni: json['dni'],
      perfilPrin: json['perfilPrin'],
      estado: json['estado'],
      offlinex: json['offlinex'],
    );
  }

  factory UsuarioModelo.fromJsonModelo(Map<String, dynamic> json) {
    return UsuarioModelo(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      correo: json['correo'],
      password: json['password'],
      token: json['token'],
      dni: json['dni'],
      perfilPrin: json['perfilPrin'],
      estado: json['estado'],
      offlinex: json['offlinex'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nombres'] = nombres;
    data['apellidos'] = apellidos;
    data['correo'] = correo;
    data['password'] = password;
    data['token'] = token;
    data['dni'] = dni;
    data['perfilPrin'] = perfilPrin;
    data['estado'] = estado;
    data['offlinex'] = offlinex;
    return data;
  }
}

class RespUsuarioModelo {
  RespUsuarioModelo({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.token,
    required this.dni,
    required this.perfilPrin,
    required this.estado,
    required this.offlinex,
  });
  late final int id;
  late final String nombres;
  late final String apellidos;
  late final String correo;
  late final String token;
  late final String dni;
  late final String perfilPrin;
  late final String estado;
  late final String offlinex;

  factory RespUsuarioModelo.fromJson(Map<String, dynamic> json) {
    return RespUsuarioModelo(
      id: json['id'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      correo: json['correo'],
      token: json['token'],
      dni: json['dni'],
      perfilPrin: json['perfilPrin'],
      estado: json['estado'],
      offlinex: json['offlinex'],
    );
  }

  get password => null;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombres'] = nombres;
    data['apellidos'] = apellidos;
    data['correo'] = correo;
    data['token'] = token;
    data['dni'] = dni;
    data['perfilPrin'] = perfilPrin;
    data['estado'] = estado;
    data['offlinex'] = offlinex;
    return data;
  }
}
