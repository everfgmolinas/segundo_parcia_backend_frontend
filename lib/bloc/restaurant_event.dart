part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {}

class GetRestaurants extends RestaurantEvent {}

class DeleteRestaurant extends RestaurantEvent {
  final String? id;
  DeleteRestaurant({required this.id});
}

class SendUserPreliminaryProfilePressed extends RestaurantEvent {}

class ValidateUserPhonePressed extends RestaurantEvent {
  final code;
  ValidateUserPhonePressed({this.code});
}

