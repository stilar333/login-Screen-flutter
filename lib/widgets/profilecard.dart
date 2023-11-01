import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  

  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      color: Color.fromARGB(71, 18, 93, 207),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('Informacion Suscripcion'),
            textColor: Colors.white,
            subtitle: Text(
              'Informacion de suscripcion del usuario.'
            ),
            leading: Icon(Icons.supervised_user_circle_rounded),iconColor: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
           //     margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(120.0),
                  border: TableBorder.all(
                    color: Colors.purple,
                    style: BorderStyle.solid,
                    width: 1
                  ),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('Usuario: ',style: TextStyle(color: Colors.white),)]),
                      Column(children: [Text(' ')],),
                      
                    ]),
                    TableRow(children: [
                        Column(children: [Text('Estado: ',style: TextStyle(color: Colors.white))]),
                      Column(children: [Text(' ')],),
                    ]),
                    TableRow(children: [
                        Column(children: [Text('Expiracion Activa: ',style: TextStyle(color: Colors.white))]),
                      Column(children: [Text(' ')],),
                    ]),
                    TableRow(children: [
                        Column(children: [Text('Pruebas: ',style: TextStyle(color: Colors.white))]),
                      Column(children: [Text(' ')],),
                    ]),
                     TableRow(children: [
                        Column(children: [Text('Conexion: ',textAlign: TextAlign.left  ,style: TextStyle(color: Colors.white))]),
                      Column(children: [Text(' ')],),
                    ])
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }
}