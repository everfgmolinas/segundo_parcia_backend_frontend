import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcia_backend/bloc/restaurant_bloc.dart';
import 'package:segundo_parcia_backend/main.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/models/user_model.dart';
import 'package:segundo_parcia_backend/network/user_repository.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/login_pages.dart';
import 'package:dio/dio.dart';

import 'gestor_pages/admin_page.dart';
import 'gestor_pages/restaurant_options.dart';
import 'gestor_pages/restaurant_pages.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Restaurant>? restaurantList;
  bool _isLoading = true;

  @override
  void initState() {
    BlocProvider.of<RestaurantBloc>(context).add(
        GetRestaurants()
    );
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantBloc, RestaurantState>(
        listener: (context, state) {

          if (state is RestaurantLoaded) {
            setState(() {
              restaurantList = state.restaurantList;
              _isLoading = false;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
              title: Row(
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      if(loggeado == false){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpBasicInfo()
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminPage()
                          ),
                        );
                      }
                    },
                    elevation: 0,
                    child: const Icon(Icons.account_circle),
                  ),
                  Text(widget.title),
                ],
              )
          ),
          body: _isLoading
              ?Center(
                child: Text(
                    'Buscando restaurantes...',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 24
                    ),
                ),
              )
              :Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: restaurantList!.isNotEmpty
                  ?GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 10 widgets that display their index in the List.
                    children: List.generate(restaurantList!.length, (index) {
                      return Center(
                        child: Card(
                          // a rectangular area of material that responds to touch
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            splashColor: Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RestaurantOptions(restaurants: restaurantList![index])
                                )
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Image.network('https://media-cdn.tripadvisor.com/media/photo-w/18/1e/24/8d/photo6jpg.jpg'),
                                ),
                                // agregar el nombre del restaurante
                                Text(
                                  '${restaurantList![index].name}',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                // agregar localización
                                Text(
                                  '${restaurantList![index].address}',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                )
                    :Text(
                      'No hay restaurantes disponibles',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 24
                      ),
                    ),
              ),
        )
    );
  }
}