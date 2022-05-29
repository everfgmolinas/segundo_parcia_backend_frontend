import 'package:dio/dio.dart';
import 'package:segundo_parcia_backend/constants.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/network/repository_helper.dart';

import 'http.dart';

class UserRepository {

  Future postRestaurant() async {

  }

  Future<List<Restaurant>>? deleteRestaurant(String id) async {
    try {
      print('delete restaurant');
      Response response = await dio.delete('/restaurante/${id}');
      if(response.statusCode == 200) {
        print('delete satisfactorily');
      } else if(response.statusCode == 400){
        print('Not found');
      }
      throw Failure(genericError);
    } on DioError catch(e) {
      throw Failure(genericError);
    }
  }

  Future<List<Restaurant>>? getListRestaurant() async {
    try {
      print('get restaurants');
      Response response =
          await dio.get("/restaurante/");
      if (response.statusCode == 200) {
        print('vaccinate geted');
        final userVaccination = userVaccinationFromJson(response.data);
        return userVaccination;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existe el ciudadano con los datos proveidos en la BD de vacunación");
      }
      throw Failure(genericError);
    // } catch (e) {
    //   print(e);
    //   throw Failure(genericError);
    // }
    } on DioError  catch (ex) {
      if (ex.type == DioErrorType.connectTimeout || ex.type == DioErrorType.receiveTimeout) {
        throw Failure("Ups, parece que tienes conexión a internet muy lenta");
      }else {
        throw Failure(genericError);
      }
    }
  }

}
