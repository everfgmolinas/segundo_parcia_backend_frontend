import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class StateAddRestaurant extends State<AddRestaurant> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext contextxt) {
    return GestureDetector(
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
                        obscureText: true,
                        onChanged: (value) {
                          //controlador
                        },
                      ),
                      TextButton(
                        child: const Text('Agregar'),
                        onPressed: () async {
                          // Use a JSON encoded string to send
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                            //mandar datos para hacer el post
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
    );
  }

}