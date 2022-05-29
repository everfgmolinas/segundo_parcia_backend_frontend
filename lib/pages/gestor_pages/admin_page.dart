import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcia_backend/bloc/restaurant_bloc.dart';
import 'package:segundo_parcia_backend/main.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/restaurant_pages.dart';
import 'package:segundo_parcia_backend/pages/home.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateAdminPage();


}

class StateAdminPage extends State<AdminPage> {

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
  Widget build(BuildContext context){
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
          title: const Text('Gestión'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.output),
              tooltip: 'Cerrar Sesión',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sesión Cerrada')));
                loggeado = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: 'Restaurant',)),
                );
              },
            ),
          ],
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
            child: restaurantList!=null
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

                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 115,
                            width: 115,
                            padding: EdgeInsets.all(5),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {

                                },
                                child: Text(
                                  'Modificar',
                                  style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10,
                                    color: Colors.black
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {

                                },
                                child: Text(
                                  'Eliminar',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10,
                                    color: Colors.black
                                  ),
                                ),
                              )
                            ],
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
      ),
    );
  }

}