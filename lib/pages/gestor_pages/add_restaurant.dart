import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateAddRestaurant();

}

class StateAddRestaurant extends State<AddRestaurant> {

  @override
  Widget build(BuildContext contextxt) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar un nuevo restaurante'),
      ),
      body: Center(

      ),
    );
  }

}