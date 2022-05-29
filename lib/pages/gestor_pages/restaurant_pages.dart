import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          // Add your onPressed code here!
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Reservation(),
              )
          );
        },
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}