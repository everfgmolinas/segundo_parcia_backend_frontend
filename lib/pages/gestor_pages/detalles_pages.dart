import 'package:dartz/dartz_unsafe.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcia_backend/bloc/table_bloc.dart';
import 'package:segundo_parcia_backend/constants.dart';
import 'package:segundo_parcia_backend/models/consumo_model.dart';
import 'package:segundo_parcia_backend/models/detalle_model.dart';
import 'package:segundo_parcia_backend/models/producto_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/models/user_model.dart';
import 'package:segundo_parcia_backend/network/http.dart';
import 'package:segundo_parcia_backend/network/user_repository.dart';

class Detalles extends StatefulWidget {
  final MyTable table;
  const Detalles({Key? key, required this.table}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateDetalles();


}

class StateDetalles extends State<Detalles> {

  List<bool> values = [];
  List<int> cantidades = [];
  TextEditingController dateinput = TextEditingController();
  Consumes? consume;
  Cliente? cliente;
  List<Cliente> clientes = [];
  List<Producto> productos = [];
  List<Detalle> detalles = [];
  bool _isLoading = true;
  int total = 0;

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    BlocProvider.of<TableBloc>(context).add(
        GetConsumes(mesa_id: widget.table.id!)
    );
    BlocProvider.of<TableBloc>(context).add(
        GetClientes()
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TableBloc, TableState>(
        listener: (context, state) {
      if (state is ConsumeLoaded) {
        setState(() {
          if(state.consumesList!=null && state.consumesList!.length>0) {
            consume = state.consumesList?.last;
          }
          if(consume!= null){
            BlocProvider.of<TableBloc>(context).add(
                GetDetails(consume_id: consume!.id!)
            );
          }
        });
      }
      if (state is ClientesLoaded) {
        setState(() {
          clientes = state.clienteList;
          try {
            cliente = clientes.firstWhere((element) => element.id ==
                consume?.id_cliente.toString());
          }catch (e){
          }
        });
      }
      if (state is ProductLoaded) {
        setState(() {
          productos = state.productList;
          cantidades = productos.map((e) => 0).toList();
          values = productos.map((e) => false).toList();
        });
      }
      if (state is DetailsLoaded) {
        setState(() {
          detalles = state.detalleList;
          total = 0;
          for(int i = 0 ; i < values.length ; i++){
            detalles.forEach((element) {
              if(element.producto?.id == productos[i].id){
                values[i] = true;
                cantidades[i] = element.cantidad?? 0;
                total+=(productos[i].precio?? 0) * (element.cantidad?? 0);
              }
            });
          }
        });
      }
    },
    child:Scaffold(
      appBar: AppBar(
        title: widget.table.nombre!=null
            ?Text('${widget.table.nombre}, Total: $total Gs.')
            : Text('Mesa'),
      ),
      body: Column(
        children: [
          Text(''),
          const Center(
            child: Text(
              '¿Qué productos desea ordenar?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: EdgeInsets.all(15),
                  height:150,
                  child:Center(
                    child:DropdownButton<Cliente>(
                      value: cliente,
                      hint: Text(
                        "Seleccione el cliente",
                      ),
                      onChanged: (value) => setState(() {
                        cliente = value!;
                      }),
                      items: clientes
                          .map((relationship) => DropdownMenuItem<Cliente>(
                        child: Text(relationship.givenName!),
                        value: relationship,
                      )).toList(),

                    ),
                  )
              ),
              FloatingActionButton(
                onPressed: () async {
                  await _showMessageBox();
                  BlocProvider.of<TableBloc>(context).add(
                      GetClientes()
                  );
                },
                heroTag: "btn2",
                elevation: 0,
                child: const Icon(Icons.account_circle),
              ),
            ],
          ),
          Center(
            child: Text(
              'Seleccione los productos',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Text(''),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (context, index) {
                return Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CheckboxListTile(
                        title: Text('${productos[index].nombre} - ${productos[index].precio}Gs.'),
                        value: values[index],
                        onChanged: (value) {
                          setState(() {
                            values[index] = value!;
                            if(values[index]==true){
                              total+=productos[index].precio?? 0;
                              cantidades[index]=1;
                            }else{
                              total-=(productos[index].precio?? 0) * (cantidades[index]);
                              cantidades[index] = 0;
                            }
                          });
                        },
                      ),
                      Row(
                        children: [
                          Text("Cantidad: ${cantidades[index]}"),
                          GestureDetector(
                            onTap: () {
                              if(cantidades[index] > 1){
                                setState(() {
                                  cantidades[index]--;
                                  total-= productos[index].precio?? 0;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.blue.withOpacity(.8),
                              child: const Icon(Icons.remove),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if(cantidades[index] > 0) {
                                setState(() {
                                  cantidades[index]++;
                                  total += productos[index].precio ?? 0;
                                });
                              }
                            },
                            child: Container(
                              color: Colors.blue.withOpacity(.8),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  if(values.contains(true) && (cliente != null)) {

                    await _showConfirmBox();
                  }
                },
                backgroundColor: Colors.lightBlue,
                child: const Icon(Icons.navigate_next),
              ),
              FloatingActionButton(
                onPressed: () async {
                  if(values.contains(true) && (cliente != null) && consume!=null) {
                    await dio.put("/consumo/${consume!.id!}", data: {
                      'estado': "Cerrado",
                      "horafecha_creacion":"2022-06-21"
                    });
                    await UserRepository().downloadPdf(consume!.id!);
                    Navigator.pop(context);
                  }
                },
                heroTag: 'buton6',
                backgroundColor: Colors.lightBlue,
                child: const Icon(Icons.payments_outlined),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  _showMessageBox(){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              String? identifier, nombre, apellido, id;
              final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
              return AlertDialog(
                contentPadding: const EdgeInsetsDirectional.all(0),
                scrollable: true,
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                content: Container(
                  padding: const EdgeInsetsDirectional.all(16),
                  width: 253,
                  child: Stack(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: const Text(
                                "Agregar cliente",
                              ),
                            ),
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(hintText: "Número de cédula"),
                                      onChanged: (value){
                                        identifier = value;
                                      },
                                      validator: (value) {
                                        if(value == null || value.isEmpty){
                                          return "Ingrese su numero de cedula";
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Nombre",
                                      ),
                                      onChanged: (value){
                                        nombre = value;
                                      },
                                      validator: (value){
                                        if(value == null || value.isEmpty){
                                          return "Ingrese un nombre";
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Apellido",
                                      ),
                                      onChanged: (value){
                                        apellido = value;
                                      },
                                      validator: (value){
                                        if(value == null || value.isEmpty){
                                          return "Ingrese un apellido";
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton (
                                        onPressed: () async {
                                          if(_formKey.currentState!.validate()){
                                            //await Navigator.pushNamed(context, '/manageRestaurant');
                                            try {
                                              print('user register');
                                              Response response = await dio.get('/cliente/ci/${identifier}');
                                              if(response.statusCode == 204) {
                                                print('get user ok');
                                                Response user = await dio.post('/cliente', data: {"cedula":identifier, "nombre":nombre, "apellido":apellido});
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('Bienvenido ${nombre}')));
                                                id = user.data['id'];
                                              } else if(response.statusCode == 200) {
                                                print(response.data);
                                                id = response.data['id'];
                                              }
                                            } catch(e) {
                                              print(e);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(genericError)));
                                            }
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text('crear'),
                                            Padding(
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: Icon(Icons.arrow_forward),
                                            )
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          primary: Constants.primaryColor300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  _showConfirmBox(){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
              return AlertDialog(
                contentPadding: const EdgeInsetsDirectional.all(0),
                scrollable: true,
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                content: Container(
                  padding: const EdgeInsetsDirectional.all(16),
                  width: 253,
                  child: ElevatedButton (
                    onPressed: () async {
                      if(consume!= null){
                        detalles.forEach((element) async {
                          await dio.delete("/detalle/${element.id}");
                        });
                      }else{
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        Response response = await dio.post("/consumo", data: {
                          "id_cliente": int.parse(cliente!.id!),
                          "id_mesa": int.parse(widget.table.id!),
                          "estado":"Abierto",
                          "total":total.toString(),
                          "horafecha_creacion": formatter.format(DateTime.now().toLocal())
                        });
                        consume = Consumes.fromJson(response.data);
                      }
                      for(int i = 0 ; i < cantidades.length ; i++){
                        if(cantidades[i]>0){
                          dio.post("/detalle", data: {
                            "id_cabecera": int.parse(consume!.id!),
                            "id_producto": int.parse(productos[i].id!),
                            "cantidad": cantidades[i]
                          });
                        }
                      }
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      Response response = await dio.put("/consumo/${consume!.id!}", data: {
                        "id_cliente": int.parse(cliente!.id!),
                        "id_mesa": int.parse(widget.table.id!),
                        "total":total.toString(),
                      });
                      BlocProvider.of<TableBloc>(context).add(
                          GetConsumes(mesa_id: widget.table.id!)
                      );
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Confirmar cambios'),

                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Constants.primaryColor300,
                    ),
                  ),
                ),
              );
            },
          );
        }
    );
  }

}

