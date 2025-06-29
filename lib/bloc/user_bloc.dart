import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';

// Events
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class RefreshUsers extends UserEvent {}

// States
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    await _fetchUsersFromApi(emit);
  }

  Future<void> _onRefreshUsers(
    RefreshUsers event,
    Emitter<UserState> emit,
  ) async {
    await _fetchUsersFromApi(emit);
  }

  Future<void> _fetchUsersFromApi(Emitter<UserState> emit) async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'Flutter-UserApp/1.0',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final users = data.map((json) => User.fromJson(json)).toList();
        emit(UserLoaded(users));
      } else if (response.statusCode == 403) {
        emit(
          UserError(
            'Access forbidden. The API may be rate-limited or blocked. Please try again later.',
          ),
        );
      } else {
        emit(UserError('Failed to load users: HTTP ${response.statusCode}'));
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        emit(
          UserError(
            'No internet connection. Please check your network and try again.',
          ),
        );
      } else {
        emit(UserError('Failed to load users: $e'));
      }
    }
  }
}
