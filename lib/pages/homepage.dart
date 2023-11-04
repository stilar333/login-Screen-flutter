import 'dart:io';
import 'dart:math';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_layout/pages/picturescreen.dart';
import 'package:flutter_login_layout/qr_scanner.dart';
import 'package:dio/dio.dart';
import '../data_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login_layout/components/codegen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Principal"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showScrenCamera(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: Colors.blue,
              ),
              child: Text(
                "Tomar Foto",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showQrScanner(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: Colors.blue,
              ),
              child: Text(
                "Escanear QR",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 6),
            ElevatedButton(
              onPressed: () {
                _subirInfoBackup(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: Colors.blue,
              ),
              child: Text(
                "Guardar Informacion",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQrScanner(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return QRCodeWidget();
    });
    Navigator.of(context).push(route);
  }

  void _showScrenCamera(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return PictureScreen();
    });
    Navigator.of(context).push(route);
  }

  Future _subirInfoBackup(BuildContext context) async {
    AppState appState = Provider.of<AppState>(context, listen: false);
    String photoName = appState.photoName;
    String qrCode = appState.qrCode;
    if (photoName.isEmpty || qrCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Por favor, asegúrate de tener cargada una imagen y un código QR.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      Dio dio = Dio();
      dio.options.baseUrl = 'https://srv426423.hstgr.cloud:3000';
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Accept'] = 'application/json';
      dio.options.validateStatus = (status) => true;
      // Deshabilitar la verificación de certificados SSL
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      Response res = await dio.post('/accounts/sinube', data: {
        'code': CodeGen().getCode(),
        'details': qrCode,
        'period': 'pendiente',
        'image': photoName
      });
      if(res.statusCode == 404){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hubo un error al subir la Informacion. Por favor, inténtalo de nuevo.'),
          backgroundColor: Colors.red,
        ),
      );

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La informacion se ha subido exitosamente.'),
          backgroundColor: Colors.green,
        ),
      );

      }
      print(res);
      return res;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Hubo un error al subir la Informacion. Por favor, inténtalo de nuevo.'),
          backgroundColor: Colors.red,
        ),
      );
    }
    print(photoName);
    print(qrCode);
    /* 
    print(res); */
  }
}
