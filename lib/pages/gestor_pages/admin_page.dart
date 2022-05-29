import 'package:flutter/material.dart';
import 'package:segundo_parcia_backend/main.dart';
import 'package:segundo_parcia_backend/pages/home.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateAdminPage();


}

class StateAdminPage extends State<AdminPage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
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
    );
  }

}