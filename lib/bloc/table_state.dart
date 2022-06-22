part of 'table_bloc.dart';

@immutable
abstract class TableState {}

class TableInitial extends TableState {}

class TableLoaded extends TableState {
  final List<MyTable>? tableList;
  TableLoaded({this.tableList});
}

class ConsumeLoaded extends TableState {
  final List<Consumes>? consumesList;
  ConsumeLoaded({this.consumesList});
}

class ProductLoaded extends TableState {
  final List<Producto> productList;
  ProductLoaded({required this.productList});
}

class ClientesLoaded extends TableState {
  final List<Cliente> clienteList;
  ClientesLoaded({required this.clienteList});
}

class DetailsLoaded extends TableState {
  final List<Detalle> detalleList;
  DetailsLoaded({required this.detalleList});
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