import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcia_backend/bloc/restaurant_bloc.dart';
import 'package:segundo_parcia_backend/pages/gestor_pages/admin_page.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateAddRestaurant();

}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _directionController = TextEditingController();

@override
void dispose() {
  _nameController.dispose();
  _directionController.dispose();
}

String? nombre;
String? direccion;

class StateAddRestaurant extends State<AddRestaurant> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext contextxt) {
    return BlocListener<RestaurantBloc, RestaurantState>(
      listener: (context, state) {

      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Agregar un nuevo restaurante'),
          ),
          body: Center(
            child: Form(
              key: _formKey,
              child: Scrollbar(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ...[
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Ingrese el nombre del restaurante',
                            labelText: 'Nombre',
                          ),
                          validator: (value){
                            if(value == null || value == "" || value.isEmpty){
                              return "Debe ingresar el nombre del restaurante";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            //agregar controlador
                            nombre = value;
                          },
                        ),
                        TextFormField(
                          controller: _directionController,
                          decoration: const InputDecoration(
                            filled: true,
                            labelText: 'Direccion',
                            hintText: 'Ingresar la direccion del restaurante',
                          ),
                          validator: (value){
                            if(value == null || value == "" || value.isEmpty){
                              return "Debe ingresar la direccion del restaurante";
                            }
                            return null;
                          },
                          obscureText: false,
                          onChanged: (value) {
                            //controlador
                            direccion = value;
                          },
                        ),
                        TextButton(
                          child: const Text('Agregar'),
                          onPressed: () async {
                            // Use a JSON encoded string to send
                            if (_formKey.currentState!.validate()) {
                              // Process data.
                              //mandar datos para hacer el post
                              BlocProvider.of<RestaurantBloc>(context).add(
                                PostRestaurant(name: nombre, direccion: direccion)
                              );
                              _nameController.clear();
                              _directionController.clear();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => AdminPage()));
                            }
                          },
                        ),
                      ].expand(
                            (widget) => [
                          widget,
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}