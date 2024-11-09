import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "package:landbond/locator/injector.dart" as di;

import '../../../service/firebase/authenticate_service.dart';
import '../../auth/data/model/users.dart';
import '../data/model/cities.dart';
import '../data/model/locality.dart';
import '../data/model/property.dart';
import '../data/model/types.dart';
import '../domain/home_repo_impl.dart';

@immutable
sealed class HomeEvent {}

@immutable
sealed class HomeState {}

// Intial State
class InitialState extends HomeState {}

//  Search Event
class BuyEvent extends HomeEvent {}

class PlotEvent extends HomeEvent {}

class RentEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String search;
  final DealType type;

  SearchEvent({required this.search, required this.type});
}

// Search State

class BuyState extends HomeState {}

class PlotState extends HomeState {}

class RentState extends HomeState {}

class SearchLoadingState extends HomeState {}

class SearchSuccessState extends HomeState {
  SearchSuccessState();
}

class SearchErrorState extends HomeState {
  final String errorMessage;

  SearchErrorState({
    required this.errorMessage,
  });
}

// Notification Event
class NotificationButtonPressedEvent extends HomeEvent {}

// Notification State
class NotificationButtonPressedState extends HomeState {}

// Menu Event
class MenuAuthenticationEvent extends HomeEvent {}

class MenuLoginEvent extends HomeEvent {}

// Menu State

class GuestMenuState extends HomeState {}

class UserMenuState extends HomeState {
  final Users user;

  UserMenuState({required this.user});
}

class UserMenuLoadingSate extends HomeState {}

class UserMenuErrorState extends HomeState {
  final String errorMessage;

  UserMenuErrorState({required this.errorMessage});
}

class MenuLoginState extends HomeState {}

// Popular Properties Event

class LoadPopularPropertiesEvent extends HomeEvent {}

// state properties

class LoadPopularLoadingState extends HomeState {}

class LoadPopularSuccessState extends HomeState {
  LoadPopularSuccessState();
}

class LoadPopularErrorState extends HomeState {
  final String errorMessage;

  LoadPopularErrorState({required this.errorMessage});
}

// Locality Event

class LoadLocalityEvent extends HomeEvent {}

// Locality State

class LoadLocalityLoadingState extends HomeState {}

class LoadLocalitySuccessState extends HomeState {
  LoadLocalitySuccessState();
}

class LoadLocalityErrorState extends HomeState {
  final String errorMessage;

  LoadLocalityErrorState({required this.errorMessage});
}

// Event Show more properties

class ShowMorePropertiesEvent extends HomeEvent {}

// state for the more properties

class ShowMorePropertiesState extends HomeState {}

//  Event show more localities
class ShowMoreLocalitiesEvent extends HomeEvent {}

class ShowMoreLocalitiesState extends HomeState {}

// Property Selecting Event

class PropertySelectedEvent extends HomeEvent {
  final Property property;

  PropertySelectedEvent({required this.property});
}

// Property Selecting State

class PropertySelectedState extends HomeState {
  final Property property;

  PropertySelectedState({required this.property});
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // It is a dependency injection
  final _homeRepoImpl = HomeRepoImpl(di.injector.get<FirebaseService>());

  // for managing search event
  bool isRent = false;
  bool isPlot = false;
  bool isBuy = false;
  String search = "";
  List<Property>? searchProperty;

  // Popular propteries

  List<Property>? popularProperty;

  // Popular Locality
  List<Locality>? locality;
  List<Cities>? cities;

  HomeBloc() : super(InitialState()) {
    on<BuyEvent>(_searchBuy);
    on<PlotEvent>(_searchPlot);
    on<RentEvent>(_searchRent);
    on<SearchEvent>(_search);
    on<NotificationButtonPressedEvent>(_notificationButton);

    on<MenuAuthenticationEvent>(_menu);

    on<MenuLoginEvent>(_menuLogin);

    on<LoadPopularPropertiesEvent>(_loadPopularProperties);

    on<LoadLocalityEvent>(_loadLocality);

    on<ShowMorePropertiesEvent>(_showMoreProperties);

    on<ShowMoreLocalitiesEvent>(_showMoreLocalities);

    on<PropertySelectedEvent>(_propertySelected);
  }

  void _propertySelected(PropertySelectedEvent event, Emitter<HomeState> emit) {
    emit(PropertySelectedState(property: event.property));
  }

  void _showMoreProperties(
      ShowMorePropertiesEvent event, Emitter<HomeState> emit) {
    emit(ShowMorePropertiesState());
  }

  void _showMoreLocalities(
      ShowMoreLocalitiesEvent event, Emitter<HomeState> emit) {
    emit(ShowMoreLocalitiesState());
  }

  void _searchBuy(BuyEvent event, Emitter<HomeState> emit) {
    isBuy = true;
    isRent = false;
    isPlot = false;
    emit(BuyState());
  }

  void _searchPlot(PlotEvent event, Emitter<HomeState> emit) {
    isBuy = false;
    isRent = false;
    isPlot = true;
    emit(PlotState());
  }

  void _searchRent(RentEvent event, Emitter<HomeState> emit) {
    isBuy = false;
    isPlot = false;
    isRent = true;
    emit(RentState());
  }

  void _search(SearchEvent event, Emitter<HomeState> emit) async {
    emit(SearchLoadingState());

    try {
      searchProperty = await _homeRepoImpl.searchProperty(
        event.search,
        event.type,
      );

      search = event.search;

      if (searchProperty == null) {
        emit(SearchErrorState(errorMessage: "No data found"));
        return;
      }

      for (var i in searchProperty!) {
        log(i.name);
        log(i.price.toString());
      }

      emit(SearchSuccessState());
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }

  void _notificationButton(
      NotificationButtonPressedEvent event, Emitter<HomeState> emit) {
    emit(NotificationButtonPressedState());
  }

  Future<void> _menu(
      MenuAuthenticationEvent event, Emitter<HomeState> emit) async {
    emit(UserMenuLoadingSate());
    try {
      var user = await _homeRepoImpl.fs.getUser();

      if (user == null) {
        emit(GuestMenuState());
        return;
      }

      emit(UserMenuState(user: user));
    } catch (e) {
      emit((UserMenuErrorState(errorMessage: e.toString())));
    }
  }

  void _menuLogin(MenuLoginEvent event, Emitter<HomeState> emit) {
    emit(MenuLoginState());
  }

  Future<void> _loadPopularProperties(
      LoadPopularPropertiesEvent event, Emitter<HomeState> emit) async {
    emit(LoadPopularLoadingState());
    try {
      popularProperty = await _homeRepoImpl.getProperties();
      emit(LoadPopularSuccessState());
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(
        LoadPopularErrorState(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadLocality(
      LoadLocalityEvent event, Emitter<HomeState> emit) async {
    emit(LoadLocalityLoadingState());

    try {
      locality = await _homeRepoImpl.getLocalitie();
      cities = await _homeRepoImpl.getCities();

      log(cities.toString());
      if (locality == null || cities == null) {
        emit(LoadLocalityErrorState(errorMessage: "No data found"));
        return;
      }
      emit(
        LoadLocalitySuccessState(),
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(LoadLocalityErrorState(errorMessage: e.toString()));
    }
  }
}
