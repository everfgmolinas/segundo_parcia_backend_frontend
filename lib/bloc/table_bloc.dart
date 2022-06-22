import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';
import 'package:segundo_parcia_backend/models/consumo_model.dart';
import 'package:segundo_parcia_backend/models/detalle_model.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/producto_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
import 'package:segundo_parcia_backend/models/user_model.dart';
import 'package:segundo_parcia_backend/network/repository_helper.dart';
import 'package:segundo_parcia_backend/network/user_repository.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final UserRepository _userRepository = UserRepository();

  TableBloc(): super(TableInitial()) {
    on<TableEvent>((event, emit) async {
      if(event is GetTable){
        emit(TableLoading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.getListTable(event.restaurant_id, event.date, event.time)!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(TableFailed(response: response));
        } else {
          late List<MyTable> tables;
          _post.foldRight(
              MyTable, (a, previous) => tables = a);

          emit(TableLoaded(tableList: tables));
        }
      }else if(event is GetTableList){
        emit(TableLoading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.getListTables(event.restaurant_id)!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(TableFailed(response: response));
        } else {
          late List<MyTable> tables;
          _post.foldRight(
              MyTable, (a, previous) => tables = a);

          emit(TableLoaded(tableList: tables));
        }
      }else if(event is GetConsumes){
        emit(TableLoading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.getConsumes(event.mesa_id)!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(TableFailed(response: response));
        } else {
          late List<Consumes> consumes;
          _post.foldRight(
              Consumes, (a, previous) => consumes = a);
          emit(ConsumeLoaded(consumesList: consumes));
          await Task(() => _userRepository.getProducts()!)
              .attempt()
              .mapLeftToFailure()
              .run()
              .then((value) {
            _post = value;
          });
          var response;
          if (_post.isLeft()) {
            _post.leftMap((l) => response = l.message);
            emit(TableFailed(response: response));
          } else {
            late List<Producto> products;
            _post.foldRight(
                Producto, (a, previous) => products = a);
            emit(ProductLoaded(productList: products));
          }
        }
      }else if(event is GetClientes){
        emit(TableLoading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.getClientes()!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(TableFailed(response: response));
        } else {
          List<Cliente> clientes = [];
          _post.foldRight(
              Cliente, (a, previous) => clientes = a);
          emit(ClientesLoaded(clienteList: clientes));
        }
      }else if(event is GetDetails){
        emit(TableLoading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.getDetails(event.consume_id)!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(TableFailed(response: response));
        } else {
          List<Detalle> detalles = [];
          _post.foldRight(
              Detalle, (a, previous) => detalles = a);
          emit(DetailsLoaded(detalleList: detalles));
        }
      }
    });
  }

}