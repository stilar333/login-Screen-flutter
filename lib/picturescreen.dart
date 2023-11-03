import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class PictureScreen extends StatefulWidget {
  
  const PictureScreen({key});
  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController puntosController = TextEditingController();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text('Please choose media to select'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _screen());
  }

  Widget _screen() {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 93, 207),
        shadowColor: Colors.white,
        leading: Icon(
          Icons.account_circle_rounded,
          color: Colors.white,
        ),
        title: Text('Gestion Imagenes'),
        elevation: 12,
      ),
      body: SizedBox(
        width: screensize.width * 1,
        height: screensize.height * 1,
        child: DecoratedBox(
          decoration: const BoxDecoration(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(25.0, 185.0, 25.0, 0.0),
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  myAlert();
                },
                child: Text('Seleccionar Foto'),
              ),
              SizedBox(
                height: 10,
              ),
              image != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                      ),
                    )
                  : Text(
                      "No Image",
                      style: TextStyle(fontSize: 20),
                    ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: descripcionController,
                style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 208, 208, 210),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  labelText: 'Descripcion del Producto',
                  hintText: 'Ingrese la descripcion del producto',
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: puntosController,
                style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 208, 208, 210),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  labelText: 'Puntos del Producto',
                  hintText: 'Ingrese el monto en puntos',
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () {
                  guardarProducto();
                },
                child: Text('Guardar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  Future<void> guardarProducto() async {
    if (image != null) {
      // Validar que ambos campos no estén vacíos

      await uploadFile(image);
      //lo comente porque me daba problema al subir la imagen
     /*  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Por favor, complete todos los campos antes de guardar el producto.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      ); */
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'Por favor, seleccione una imagen antes de guardar el producto.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

Future<Response> uploadFile(XFile? data) async {
  try {
    Dio dio = Dio();
    dio.options.baseUrl = 'https://srv426423.hstgr.cloud:3000';
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['Accept'] = 'application/json';
    dio.options.validateStatus = (status) => true;

    // Deshabilitar la verificación de certificados SSL
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    FormData formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(data!.path,
          filename: data.path.split('/').last),
    });

     Response response = await dio.post('/photos/upload', data: formData);
    print('La imagen se subió con éxito');
    print('Código de estado HTTP: ${response.statusCode}');
    print('Respuesta del servidor: ${response.data}');

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('La imagen se ha subido exitosamente.'),
        backgroundColor: Colors.green,
      ),
    );

    return response;
  } catch (error) {
    print('Error al subir la imagen: $error');
    
    // Mostrar mensaje de error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hubo un error al subir la imagen. Por favor, inténtalo de nuevo.'),
        backgroundColor: Colors.red,
      ),
    );

    throw error;
  }
}


}
