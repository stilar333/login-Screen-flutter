import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'data_app.dart';

class QRCodeWidget extends StatefulWidget{
  const QRCodeWidget({super.key});
  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget>{
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "";

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller){
    AppState appState = Provider.of<AppState>(context, listen: false);
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
        //aqui se sube la informacion del qr al state
        appState.setQRCode(result);
      });
     });
  }

  @override
Widget build(BuildContext context){
  
  return Scaffold(
    appBar: AppBar(
      title: Text("QR Escaner"),
    ),
    body: Column(
      children: [
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              "Resultados: $result",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (result.isNotEmpty) {
                    Clipboard.setData(ClipboardData(text: result));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Copiado al Portapapeles")),
                    );
                  }
                },
                child: Text("Copy"),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (result.isNotEmpty) {
                    final Uri _url = Uri.parse(result);
                    await launchUrl(_url);
                  }
                },
                child: Text("Open"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}