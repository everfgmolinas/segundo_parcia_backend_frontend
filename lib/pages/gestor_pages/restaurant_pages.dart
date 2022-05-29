import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/reservation_page.dart';

class Restaurants extends StatefulWidget {
  final String? restaurantName;
  final String? restaurantAddress;
  const Restaurants({Key? key, required this.restaurantName, required this.restaurantAddress}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateRestaurants();


}

class StateRestaurants extends State<Restaurants> {

  Map<String, bool> values = {
    '12:00 - 13:00': false,
    '13:00 - 14:00': false,
    '14:00 - 15:00': false,
    '15:00 - 16:00': false,
    '16:00 - 17:00': false,
    '17:00 - 18:00': false,
    '18:00 - 19:00': false,
    '19:00 - 20:00': false,
    '20:00 - 21:00': false,
    '21:00 - 22:00': false,
    '22:00 - 23:00': false,
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
        title: widget.restaurantName!=null
            ?Text('${widget.restaurantName}, ${widget.restaurantAddress}')
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
              children: values.keys.map((String key) {
                return new CheckboxListTile(
                  title: Text(key),
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Reservation(),
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

