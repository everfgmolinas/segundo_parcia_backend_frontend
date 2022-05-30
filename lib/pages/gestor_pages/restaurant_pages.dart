import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/reservation_page.dart';

class Restaurants extends StatefulWidget {
  final Restaurant restaurants;
  const Restaurants({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateRestaurants();


}

class StateRestaurants extends State<Restaurants> {

  Map<Hour, bool> values = {
    Hour(hora_inicio: "12", hora_fin: "13"): false,
    Hour(hora_inicio: "13", hora_fin: "14"): false,
    Hour(hora_inicio: "14", hora_fin: "15"): false,
    Hour(hora_inicio: "15", hora_fin: "16"): false,
    Hour(hora_inicio: "16", hora_fin: "17"): false,
    Hour(hora_inicio: "17", hora_fin: "18"): false,
    Hour(hora_inicio: "18", hora_fin: "19"): false,
    Hour(hora_inicio: "19", hora_fin: "20"): false,
    Hour(hora_inicio: "20", hora_fin: "21"): false,
    Hour(hora_inicio: "21", hora_fin: "22"): false,
    Hour(hora_inicio: "22", hora_fin: "23"): false,
  };
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.restaurants.name!=null
            ?Text('${widget.restaurants.name}, ${widget.restaurants.address}')
            : Text('Restaurante'),
      ),
      body: Column(
        children: [
          Text(''),
          Center(
            child: Text(
              '¿En qué fecha desea reservar?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.all(15),
              height:150,
              child:Center(
                  child:TextField(
                    controller: dateinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Seleccione una fecha" //label text of field
                    ),
                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text = formattedDate; //set output date to TextField value.
                        });
                      }else{
                        print("Debe seleccionar una fecha");
                      }
                    },
                  )
              )
          ),
          Center(
            child: Text(
              '¿En qué horario desea reservar?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Text(''),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: values.keys.map((Hour key) {
                return new CheckboxListTile(
                  title: Text('${key.hora_inicio}:00 - ${key.hora_fin}:00'),
                  value: values[key],
                  onChanged: (value) {
                    setState(() {
                      values[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(values.containsValue(true) && (dateinput.text != "")) {
            List<Hour> reservations = [];
            values.forEach((key, value) {
              reservations.add(key);
            });
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reservation(
                    restaurants: widget.restaurants,
                    dateReservation: dateinput.text,
                    time: reservations),
                )
            );
          }
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }



}

