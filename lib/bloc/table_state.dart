part of 'table_bloc.dart';

@immutable
abstract class TableState {}

class TableInitial extends TableState {}

class TableLoaded extends TableState {
  final List<MyTable>? tableList;
  TableLoaded({this.tableList});
}

class TableLoading extends TableState {}

class TableFailed extends TableState {
  final response;
  TableFailed({required this.response});
}

class NavigateNextScreen extends TableState {
  final String rounteName;
  NavigateNextScreen({required this.rounteName});
}

class Success extends TableState {}