part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {}

class GetRestaurants extends RestaurantEvent {}

class SendUserPreliminaryProfilePressed extends RestaurantEvent {}

class ValidateUserPhonePressed extends RestaurantEvent {
  final code;
  ValidateUserPhonePressed({this.code});
}

