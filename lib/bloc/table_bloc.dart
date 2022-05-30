import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';
import 'package:segundo_parcia_backend/models/hour_model.dart';
import 'package:segundo_parcia_backend/models/table_model.dart';
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
      }
    });
  }

}