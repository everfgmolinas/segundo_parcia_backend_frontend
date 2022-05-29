import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';


class SignUpBasicInfo extends StatefulWidget {
  const SignUpBasicInfo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateSignUpBasicInfo();


}

class StateSignUpBasicInfo extends State<SignUpBasicInfo> {

  // flag for password field
  bool _obscureText1 = true;
  String? identifier, password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(hintText: "Usuario"),
                          onChanged: (value){
                            identifier = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Ingrese un usuario";
                            }else if(identifier != "admin"){
                              return "Usuairo no valido";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: GestureDetector(
                                onTap: _toggle,
                                child: const Icon(Icons.password),
                              ),
                            ),
                          ),
                          obscureText: _obscureText1,
                          onChanged: (value){
                            password = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Ingrese la contraseña";
                            }else if(password != 'admin'){
                              return "Contraseña incorrecta";
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

                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('siguiente'),
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
                ),
              ),
            ]
        )

    );
  }

  // function for password field
  void _toggle() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

}