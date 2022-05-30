part of 'table_bloc.dart';

@immutable
abstract class TableEvent {}

class GetTable extends TableEvent {
  final String restaurant_id;
  final String date;
  final List<Hour> time;
  GetTable({required this.restaurant_id, required this.date, required this.time});
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

