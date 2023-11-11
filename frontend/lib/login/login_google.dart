// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_if_null_operators, unnecessary_null_comparison

import 'package:asistenciaupeu_frontend/apis/usuario_api.dart';
import 'package:asistenciaupeu_frontend/comp/Button.dart';
import 'package:asistenciaupeu_frontend/drawer/navigation_home_screen.dart';

import 'package:asistenciaupeu_frontend/login/sign_in.dart';
import 'package:asistenciaupeu_frontend/modelo/UsuarioModelo.dart';
import 'package:asistenciaupeu_frontend/util/TokenUtil.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLogin extends StatelessWidget {
  const MainLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<UsuarioApi>(
      create: (_) => UsuarioApi.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool modLocal = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  var tokenx;
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                    image: AssetImage("assets/imagen/logo_upeu.png"),
                    height: 180.0),
                const SizedBox(height: 20),
                _buildForm(),
                const SizedBox(height: 20),
                /*checkbox(
                    title: "Fire:",
                    initValue: modLocal,
                    onChanged: (sts) => setState(() => modLocal = sts)) ,
                SizedBox(height: 20),*/
                _signInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkbox(
      {required String title,
      required bool initValue,
      required Function(bool boolValue) onChanged}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              Checkbox(value: initValue, onChanged: (b) => onChanged(b!))
            ],
          )
        ]);
  }

  Form _buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Usuario",
                  labelText: "Usuario",
                  helperText: "Coloque un correo",
                  helperStyle: TextStyle(color: Colors.green),
                  alignLabelWithHint: false,
                  filled: true,
                ),
                controller: controllerUser,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  hintText: "Password",
                  labelText: "Password",
                  helperText:
                      "La contraseña debe contener un carácter especial",
                  helperStyle: const TextStyle(color: Colors.green),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  alignLabelWithHint: false,
                  filled: true,
                ),
                controller: controllerPass,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 24,
              ),
              Button(
                label: 'Ingresar',
                onTap: () async {
                  print("Holassss");
                  //fireInitial();
                  if (_formKey.currentState!.validate() &&
                      controllerUser.text != "") {
                    print(
                        "Usuario: ${controllerUser.text}  clave:${controllerPass.text}");

                    final prefs = await SharedPreferences.getInstance();

                    final api = Provider.of<UsuarioApi>(context, listen: false);
                    final user = UsuarioModelo.login(
                        controllerUser.text, controllerPass.text);
                    bool ingreso = false;
                    api.login(user).then((value) {
                      tokenx = "Bearer ${value.token}";
                      prefs.setString("token", tokenx);
                      TokenUtil.TOKEN = tokenx;
                      ingreso = true;
                      if (ingreso == true) {
                        prefs.setString("usernameLogin", controllerUser.text);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return NavigationHomeScreen();
                            },
                          ),
                        );
                      }
                    }).catchError((onError) {
                      print(onError.toString());
                    });
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget _signInButton() {
    return OutlinedButton(
      onPressed: () async {
        signInWithGoogle().then((result) async {
          try {
            print('Mi correo es : $email');

            final prefs = await SharedPreferences.getInstance();
            final api = Provider.of<UsuarioApi>(context, listen: false);

            // Podrías usar estos datos para iniciar sesión en tu sistema
            final user = UsuarioModelo.loginByEmail(email!);
            api.loginByEmail(user).then((value) {
              String tokenx = "Bearer ${value.token}";
              prefs.setString("token", tokenx);
              TokenUtil.TOKEN = tokenx;
              prefs.setString("usernameLogin", email ?? "");
            }).catchError((onError) {
              print(onError.toString());
            });

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NavigationHomeScreen();
                },
              ),
            );
          } catch (err) {
            print("Error!!");
            Visibility(
              visible: error.isNotEmpty,
              child: MaterialBanner(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: SelectableText(error),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        error = '';
                      });
                    },
                    child: const Text(
                      'dismiss',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
                contentTextStyle: const TextStyle(color: Colors.white),
                padding: const EdgeInsets.all(10),
              ),
            );
            print("Error al iniciar sesión automáticamente con Google: $err");
            // Manejar el error si ocurre algún problema durante el proceso de inicio de sesión automático
          }
        });
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/imagen/man-icon.png"),
              height: 35.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Ingresar Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
