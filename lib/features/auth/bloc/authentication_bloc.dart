import 'package:flutter_bloc/flutter_bloc.dart';

// --- Events ---
abstract class AuthenticationEvent {}

class LoginRequested extends AuthenticationEvent {}

class LogoutRequested extends AuthenticationEvent {}

// --- States ---
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoggedIn extends AuthenticationState {}

class AuthenticationNotLoggedIn extends AuthenticationState {}

// --- Bloc ---
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationNotLoggedIn()) {
    on<LoginRequested>((event, emit) => emit(AuthenticationLoggedIn()));
    on<LogoutRequested>((event, emit) => emit(AuthenticationNotLoggedIn()));
  }
}