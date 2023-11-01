import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login_layout/widgets/profilecard.dart';
import 'package:image_picker/image_picker.dart';


class PictureScreen extends StatefulWidget {
  const PictureScreen({key});
  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

Future getImage(ImageSource media) async {
  var img = await picker.pickImage(source: media);
setState(() {
  image = img;

});

}
void myAlert() {
  showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      shape: 
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text('Please choose media to select'),
      content: Container(
        height: MediaQuery.of(context).size.height / 6,
        child: Column(
          children: [
            ElevatedButton(onPressed: () {Navigator.pop(context);
            getImage(ImageSource.gallery);
            }, child: Row(
              children: [
                Icon(Icons.image),
                Text('From Gallery'),
              ],
            )
            
            ),
            ElevatedButton(onPressed: () {
              Navigator.pop(context);
              getImage(ImageSource.camera);
            }, child: Row(children: [
              Icon(Icons.camera),
              Text('From Camera'),
            ],))
          ],
        )
      ),
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(child: _screen());
  }

  Widget _screen() {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 18, 93, 207),
        shadowColor: Colors.white,
          leading: Icon(Icons.account_circle_rounded,color: Colors.white, ),
        title: Text('Gestion Imagenes'),
        elevation: 12,
      ),
      body: SizedBox(
        width: screensize.width * 1,
        height: screensize.height * 1,
       child: DecoratedBox(
        decoration: const BoxDecoration(),
          child:  ListView(
                padding: const EdgeInsets.fromLTRB(25.0, 185.0, 25.0, 0.0),
            children: <Widget>[
            ElevatedButton(onPressed: (){myAlert();}, child: Text('Seleccionar Foto'),),
            SizedBox(height: 10,),
            image != null
                ? Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
                ),)
                : Text("No Image", style: TextStyle(fontSize: 20),)
            /*   ElevatedButton.icon(onPressed: () {
                print("elevated push.....");
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(71, 223, 9, 180)),
              ),
               icon: Icon(Icons.tv, size: 50), label: Text('TV')),
 */,
  const SizedBox(height: 10.0,),
                     TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                      decoration: InputDecoration(
                          filled: true,
                        fillColor: Color.fromARGB(255, 208, 208, 210),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                        labelText: 'Descripcion del Producto',
                        hintText: 'Ingrese la descripcion del producto',
                        
                  //      hintStyle: TextStyle(color:Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la descripcion del producto !!!';
                        }
                        return null;
                      },
                     ),
                     const SizedBox(height: 10.0,),
                     TextFormField(
                      style: TextStyle(color: Color.fromARGB(255, 43, 40, 123)),
                      decoration: InputDecoration(
                          filled: true,
                        fillColor: Color.fromARGB(255, 208, 208, 210),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(10,10,10,0),
                        labelText: 'Puntos del Producto',
                        hintText: 'Ingrese el monto en puntos',
                        
                  //      hintStyle: TextStyle(color:Colors.white),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el monto en puntos !!!';
                        }
                        return null;
                      },
                     ),
                     const SizedBox(height: 10.0,),
                  ElevatedButton(onPressed: (){}, child: Text('Guardar Producto'),),
            ],
            )
          ),),
    );
  }
}