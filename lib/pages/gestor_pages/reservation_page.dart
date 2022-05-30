
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcia_backend/bloc/table_bloc.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/pages/home.dart';

class Reservation extends StatefulWidget {
  final Restaurant restaurants;
  final String? dateReservation;
  final List<Hour>? time;
  const Reservation({Key? key, required this.restaurants, required this.dateReservation, required this.time}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateReservation();


}

class StateReservation extends State<Reservation> {

  List<MyTable>? tableList;
  bool _isLoading = true;

  @override
  void initState() {
    BlocProvider.of<TableBloc>(context).add(
        GetTable(restaurant_id: widget.restaurants.id!, date: widget.dateReservation!, time: widget.time!)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableBloc, TableState>(
        listener: (context, state) {
          if (state is TableLoaded) {
            setState(() {
              tableList = state.tableList;
              _isLoading = false;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mesas disponibles'),
          ),
          body: _isLoading
          ?Center(
            child: Text(
              'Buscando mesas...',
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 24
              ),
            ),
          )
          :Center(
            child: tableList!=null
                ?GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 10 widgets that display their index in the List.
              children: List.generate(tableList!.length, (index) {
                return Center(
                  child: Card(
                    // a rectangular area of material that responds to touch
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      splashColor: Colors.blue,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Mesa reservada para ${tableList![index].capacidad} personas')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: 'Restaurant'))
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
                            '${tableList![index].capacidad}',
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // agregar localización
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