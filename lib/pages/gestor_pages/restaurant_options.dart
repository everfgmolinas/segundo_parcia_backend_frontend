import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcia_backend/constants.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/reservation_page.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/restaurant_pages.dart';

import 'mesas.dart';

class RestaurantOptions extends StatefulWidget {
  final Restaurant restaurants;
  const RestaurantOptions({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateRestaurantOptions();


}

class StateRestaurantOptions extends State<RestaurantOptions> {


  @override
  void initState() {
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
          const Text(''),
          const Center(
            child: Text(
              '¿Qué desea hacer?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton (
                onPressed: () async {
                  //await Navigator.pushNamed(context, '/manageRestaurant');
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TablesList(restaurants: widget.restaurants,))
                  );

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Ordenar'),

                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Constants.primaryColor300,
                ),
              ),
              ElevatedButton (
                onPressed: () async {
                  //await Navigator.pushNamed(context, '/manageRestaurant');
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Restaurants(restaurants: widget.restaurants,))
                  );

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Reservar'),

                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: Constants.primaryColor300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }



}

