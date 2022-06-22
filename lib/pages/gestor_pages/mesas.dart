
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcia_backend/bloc/table_bloc.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/user_register.dart';

import 'detalles_pages.dart';

class TablesList extends StatefulWidget {
  final Restaurant restaurants;
  const TablesList({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateTablesList();


}

class StateTablesList extends State<TablesList> {

  List<MyTable>? tableList;
  bool _isLoading = true;

  @override
  void initState() {
    BlocProvider.of<TableBloc>(context).add(
        GetTableList(restaurant_id: widget.restaurants.id!)
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
          title: const Text('Mesas'),
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
          child: tableList!.isNotEmpty
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
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Detalles(table:tableList![index]))
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
                          '${tableList![index].nombre}',
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          'Capacidad: ${tableList![index].capacidad} personas',
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
            'No hay mesas disponibles',
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