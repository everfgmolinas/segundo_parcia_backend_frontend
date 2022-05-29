import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  final String? restaurantName;
  final String? dateReservation;
  final List<String>? reservations;
  const Reservation({Key? key, required this.restaurantName, required this.dateReservation, required this.reservations}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateReservation();


}

class StateReservation extends State<Reservation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesas disponibles'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}