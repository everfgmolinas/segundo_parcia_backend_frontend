part of 'table_bloc.dart';

@immutable
abstract class TableEvent {}

class GetTable extends TableEvent {
  final String restaurant_id;
  final String date;
  final List<Hour> time;
  GetTable({required this.restaurant_id, required this.date, required this.time});
}

class GetTableList extends TableEvent {
  final String restaurant_id;
  GetTableList({required this.restaurant_id,});
}

class GetConsumes extends TableEvent {
  final String mesa_id;
  GetConsumes({required this.mesa_id,});
}

class GetClientes extends TableEvent {}

class GetDetails extends TableEvent {
  final String consume_id;
  GetDetails({required this.consume_id,});
}

class PostTable extends TableEvent {
  final String? name;
  final String? direccion;
  PostTable({required this.name, required this.direccion});

}

class DeleteTable extends TableEvent {
  final String? id;
  DeleteTable({required this.id});
}

