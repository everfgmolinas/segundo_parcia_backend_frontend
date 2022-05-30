import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:segundo_parcia_backend/constants.dart';
import 'package:segundo_parcia_backend/main.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/network/http.dart';
import 'package:segundo_parcia_backend/pages/home.dart';

class UserRegister extends StatefulWidget{

  final MyTable table;
  final String dateReservation;
  final List<Hour> time;

  UserRegister({required this.table, required this.dateReservation, required this.time});

  @override
  State<StatefulWidget> createState() => StateUserRegister();

}

class StateUserRegister extends State<UserRegister>{

  String? id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? identifier, nombre, apellido;

  Widget build(BuildContext context) {

    return Material(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Número de cédula"),
                          onChanged: (value){
                            identifier = value;
                          },
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return "Ingrese su numero de cedula";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Nombre",
                          ),
                          onChanged: (value){
                            nombre = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Ingrese un nombre";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: "Apellido",
                          ),
                          onChanged: (value){
                            apellido = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Ingrese un apellido";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton (
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                //await Navigator.pushNamed(context, '/manageRestaurant');
                                  try {
                                    print('user register');
                                    Response response = await dio.get('/cliente/ci/${identifier}');
                                    if(response.statusCode == 204) {
                                      print('get user ok');
                                      Response user = await dio.post('/cliente', data: {"cedula":identifier, "nombre":nombre, "apellido":apellido});
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Bienvenido ${nombre}')));
                                      id = user.data.id;
                                    } else if(response.statusCode == 200) {
                                      print(response.data);
                                      id = response.data[0]['id'];
                                    }
                                    await dio.post('/reserva/', data: {
                                      "restaurante_id": widget.table.restaurante_id,
                                      "cliente_id": id,
                                      "mesa_id": widget.table.id,
                                      "horas": widget.time,
                                      "fecha": widget.dateReservation,
                                      "cantidad": widget.table.capacidad
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Se han reservado ${widget.table.capacidad} asientos de la ${widget.table.nombre}')));
                                } catch(e) {
                                    print(e);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(genericError)));
                                }
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Restaurant')),
                                    (route) => false
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('siguiente'),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.arrow_forward),
                                )
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Constants.primaryColor300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
        )

    );

  }

}