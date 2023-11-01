import 'package:flutter/material.dart';
import 'package:flutter_login_layout/picturescreen.dart';
import 'package:flutter_login_layout/qr_scanner.dart';

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
               onPressed: (){_showScrenCamera(context);},
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){_showQrScanner(context);},
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
          ],
        ),
      ),
    );
  }
  
  void _showQrScanner(BuildContext context) {
      final route = MaterialPageRoute(builder: (BuildContext context){
      return QRCodeWidget();
    });
    Navigator.of(context).push(route);
  }
  
  void _showScrenCamera(BuildContext context) {
      final route = MaterialPageRoute(builder: (BuildContext context){
      return PictureScreen();
    });
    Navigator.of(context).push(route);
  }
}
