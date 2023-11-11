// ignore_for_file: library_private_types_in_public_api, avoid_types_as_parameter_names

import 'package:asistenciaupeu_frontend/theme/AppTheme.dart';
import 'package:asistenciaupeu_frontend/drawer/drawer_user_controller.dart';
import 'package:asistenciaupeu_frontend/drawer/home_drawer.dart';
import 'package:asistenciaupeu_frontend/ui/actividad/actividad_main.dart';
import 'package:asistenciaupeu_frontend/ui/actividadb/actividad_main.dart';
import 'package:asistenciaupeu_frontend/ui/asistenciax/asistenciax_page.dart';
import 'package:asistenciaupeu_frontend/ui/empresa/empresa_main.dart';
//import 'package:asistenciaupeu_frontend/ui/actividadb/actividad_main.dart';
//import 'package:asistenciaupeu_frontend/ui/actividadfire/actividad_main.dart';
import 'package:asistenciaupeu_frontend/ui/help_screen.dart';
import 'package:flutter/material.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = HelpScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppTheme.themeData.primaryColor,
        //appBar: CustomAppBar(accionx: accion as Function),
        body: DrawerUserController(
          screenIndex: drawerIndex!,
          drawerWidth: MediaQuery.of(context).size.width * 0.75,
          onDrawerCall: (DrawerIndex drawerIndexdata) {
            changeIndex(drawerIndexdata);
            //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
          },
          screenView: screenView!,
          drawerIsOpen: (bool) {},
          //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = HelpScreen(); //MainPersona()
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = MainActividad();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          screenView = const MainActividadB();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = const MainEmpresa();
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AsistenciaxPage();
        });
      } else {
        //do in your way......
      }
    }
  }
}
