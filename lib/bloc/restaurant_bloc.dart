import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:meta/meta.dart';
import 'package:segundo_parcia_backend/models/restaurant_model.dart';
import 'package:segundo_parcia_backend/network/repository_helper.dart';
import 'package:segundo_parcia_backend/network/user_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final UserRepository _userRepository = UserRepository();
  RestaurantBloc() : super(UserRegisterInitial()) {
    on<RestaurantEvent>((event, emit) async {
      if (event is GetRestaurants) {
        emit(Loading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.getListRestaurant()!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(Failed(response: response));
        } else {
          late List<Restaurant> restaurants;
          _post.foldRight(
              Restaurant, (a, previous) => restaurants = a);

          emit(RestaurantLoaded(restaurantList: restaurants));
        }
      } else if (event is DeleteRestaurant) {
        emit(Loading());
        await Future.delayed(const Duration(seconds: 2));
        var _post;
        await Task(() => _userRepository.deleteRestaurant(event.id!)!)
            .attempt()
            .mapLeftToFailure()
            .run()
            .then((value) {
          _post = value;
        });
        var response;
        if (_post.isLeft()) {
          _post.leftMap((l) => response = l.message);
          emit(Failed(response: response));
        } else {
          late List<Restaurant> restaurants;
          _post.foldRight(
              Restaurant, (a, previous) => restaurants = a);

          emit(RestaurantLoaded(restaurantList: restaurants));
        }
      }
    });
  }
}