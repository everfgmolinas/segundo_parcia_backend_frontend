import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Restaurants extends StatefulWidget {
  final String? restaurantName;
  final String? restaurantAddress;
  const Restaurants({Key? key, required this.restaurantName, required this.restaurantAddress}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateRestaurants();


}

class StateRestaurants extends State<Restaurants> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.restaurantName!=null
            ?Text('${widget.restaurantName}')
            : Text('Restaurante'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}