import 'dart:async';

//import 'package:asistencia_app/apis/asistencia_api.dart';
//import 'package:asistencia_app/modelo/AsistenciapaxModelo.dart';
import 'package:asistenciaupeu_frontend/util/TokenUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import '../../modelo/ActividadModelo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyAppQR extends StatefulWidget {
  ActividadModelo modelA;
  MyAppQR({required this.modelA}):super();

  @override
  _MyAppState createState() => _MyAppState(modelA: modelA);
}

class _MyAppState extends State<MyAppQR> {

  ActividadModelo modelA;
  _MyAppState({required this.modelA}):super();
  String _scanBarcode = 'Unknown';
  Position? currentPosition;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  @override
  void initState() {
    super.initState();

  }

  void registrarAsistencia() async{
   /* DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);

    print('Fecha actual: $formattedDate');
    print('Hora actual: $formattedTime');
    var api= await Provider.of<AsistenciapaApi>(context, listen: false).getAsistenciapa(TokenUtil.TOKEN);
    print(api.success);
    print(modelA.id);
    AsistenciapaxModelo mp = new AsistenciapaxModelo.unlaunched();
    mp.actividad=modelA;
    mp.id=0;
    mp.fecha=formattedDate;
    mp.horaReg=formattedTime;
    mp.calificacion=5;
    mp.cui=_scanBarcode=="Unknown"?"200410564":_scanBarcode;
    mp.latituda=currentPosition!.latitude.toString();
    mp.longituda=currentPosition!.longitude.toString();
    mp.tipo="Est.";
    mp.tipoCui="DNI";

    print("A:${mp.actividad}, ID:${mp.id}, F:${mp.fecha}, "
        "H:${mp.horaReg} C:${mp.calificacion} CUI:${mp.cui} "
        "La: ${mp.latituda}, Lo:${mp.longituda} "
        );
    var apix = await Provider.of<AsistenciapaApi>(
        context,
        listen: false)
        .createAsistenciapa(TokenUtil.TOKEN,mp);
    if (apix.toJson()['success'] ==true) {
      Fluttertoast.showToast(
          msg: "Se registro correctamente",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Error al registrar ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
*/

  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) {
          _scanBarcode=barcode;
          print("Lecturado: $barcode");
          registrarAsistencia();
      /*if (!mounted) return;
      setState(() {
        _scanBarcode = barcode;
      });*/
    });
  }



  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      registrarAsistencia();
    });
  }


  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      registrarAsistencia();
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Registrar Asistencia'),
            centerTitle: true),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text('Start barcode scan')),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: Text('Start QR scan')),
                        ElevatedButton(
                            onPressed: () => startBarcodeScanStream(),
                            child: Text('Start barcode scan stream')),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }

  Future<bool> permiso() async{
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void>  getCurrentLocation() async {
    final hasPermission = await permiso();
    if (!hasPermission) {
      return;
    }
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        //getCurrentLocationAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }
}