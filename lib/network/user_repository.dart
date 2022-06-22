import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:segundo_parcia_backend/constants.dart';
import 'package:segundo_parcia_backend/models/consumo_model.dart';
import 'package:segundo_parcia_backend/models/detalle_model.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/producto_model.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/models/user_model.dart';
import 'package:segundo_parcia_backend/network/repository_helper.dart';
import 'package:open_file/open_file.dart' as open;

import 'http.dart';

class UserRepository {

  Future<List<Restaurant>> postRestaurant(String name, String direccion) async {
    try {
      print('add restaurant');
      Response response = await dio.post('/restaurante/', data: {'nombre':name, 'direccion':direccion});
      if(response.statusCode == 200) {
        print('Add restaurant satisfactorily');
      } else if (response.statusCode == 400) {
        print('not found');
      }
      throw Failure(genericError);
    } on DioError catch(e) {
      throw Failure(genericError);
    }
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

  Future<List<MyTable>>? getListTable(String restaurant_id, String date, List<Hour> time) async {
    try {
      List<MyTable> tables = [];
      print('get table');
      print(time.map((e) => e.toJson()).toList());
      Response response =
      await dio.post("/reserva/mesasLibres/", data: {'restaurante_id':restaurant_id ,'fecha':date, "horas":time.map((e) => e.toJson()).toList()});
      if (response.statusCode == 200) {
        print('table geted');
        response.data = response.data.where((e) => e['count'] == "0").toList();
        final listTable = tableFromJson(response.data);
        return listTable;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existe el ciudadano con los datos proveidos en la BD de vacunación");
      }
      throw Failure(genericError);
      // } catch (e) {
      //   print(e);
      //   throw Failure(genericError);
      // }
    } catch(e) {
      print(e);
      throw Failure(genericError);
    }

  }

  Future<List<MyTable>>? getListTables(String restaurant_id) async {
    try {
      List<MyTable> tables = [];
      print('get table');
      Response response =
      await dio.get("/mesa/restid/$restaurant_id");
      if (response.statusCode == 200) {
        print('table geted');
        final listTable = tableFromJson(response.data);
        return listTable;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existe el ciudadano con los datos proveidos en la BD de vacunación");
      }
      throw Failure(genericError);
      // } catch (e) {
      //   print(e);
      //   throw Failure(genericError);
      // }
    } catch(e) {
      print(e);
      throw Failure(genericError);
    }

  }

  Future<List<Consumes>>? getConsumes(String mesa_id) async {
    try {
      print('get table');
      Response response =
      await dio.get("/consumo");
      if (response.statusCode == 200) {
        print('consumes geted');
        response.data = response.data.where((e) => e['estado'] == 'Abierto').toList();
        response.data = response.data.where((e) => e['id_mesa'].toString() == mesa_id.toString()).toList();
        final consumes = consumesFromJson(response.data);
        return consumes;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existen consumes");
      }
      throw Failure(genericError);
      // } catch (e) {
      //   print(e);
      //   throw Failure(genericError);
      // }
    } catch(e) {
      print(e);
      throw Failure(genericError);
    }

  }

  Future<List<Producto>>? getProducts() async {
    try {
      print('get product');
      Response response =
      await dio.get("/producto");
      if (response.statusCode == 200) {
        print('products geted');
        final producto = productFromJson(response.data);
        return producto;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existen consumes");
      }
      throw Failure(genericError);
      // } catch (e) {
      //   print(e);
      //   throw Failure(genericError);
      // }
    } catch(e) {
      print(e);
      throw Failure(genericError);
    }

  }

  Future<List<Detalle>>? getDetails(String consumo_id) async {
    try {
      print('get details');
      Response response =
      await dio.get("/detalle/$consumo_id");
      if (response.statusCode == 200) {
        print('products geted');
        final detalles = detailFromJson(response.data);
        return detalles;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existen detalles");
      }
      throw Failure(genericError);
      // } catch (e) {
      //   print(e);
      //   throw Failure(genericError);
      // }
    } catch(e) {
      print(e);
      throw Failure(genericError);
    }

  }

  Future<List<Cliente>>? getClientes() async {
    try {
      print('get clients');
      Response response =
      await dio.get("/cliente");
      if (response.statusCode == 200) {
        print('clients geted');
        final clientes = clientesFromJson(response.data);
        return clientes;
      } else if (response.statusCode == 404) {
        throw Failure(
            "No existen clientes");
      }
      throw Failure(genericError);
      // } catch (e) {
      //   print(e);
      //   throw Failure(genericError);
      // }
    } catch(e) {
      print(e);
      throw Failure(genericError);
    }

  }

  Future<None>? downloadPdf(String consume_id) async {
    try {
      print('get user downloadVacinnationPdf');
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/ticket${consume_id}.pdf');
      final response = await dioDownloader
          .get('/consumo/$consume_id/factura');
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      open.OpenFile.open(file.path);
      return None();
    } catch (e) {
      throw Failure(genericError);
    }
  }

}
