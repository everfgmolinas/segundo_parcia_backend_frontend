part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class UserRegisterInitial extends RestaurantState {}

class VaccinationLoaded extends RestaurantState {
  final List<Restaurant>? userVaccination;
  VaccinationLoaded({this.userVaccination});
}

class Loading extends RestaurantState {}

class Failed extends RestaurantState {
  final response;
  Failed({required this.response});
}

class NavigateNextScreen extends RestaurantState {
  final String rounteName;
  NavigateNextScreen({required this.rounteName});
}

class Success extends RestaurantState {}


