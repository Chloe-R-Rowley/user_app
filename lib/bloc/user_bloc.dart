import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

// Events
abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class RefreshUsers extends UserEvent {}

class AddUser extends UserEvent {
  final User user;
  AddUser(this.user);
}

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
    on<AddUser>(_onAddUser);
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

  Future<void> _onAddUser(AddUser event, Emitter<UserState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedUsers = prefs.getString('cached_users');
    List<User> users = [];

    if (cachedUsers != null) {
      final List<dynamic> data = json.decode(cachedUsers);
      users = data.map((json) => User.fromJson(json)).toList();
    }

    // Increment new user's id
    final newUser = event.user.copyWith(id: users.length + 1);
    users.add(newUser);

    // Save back to storage
    await prefs.setString(
      'cached_users',
      json.encode(users.map((u) => u.toJson()).toList()),
    );
    emit(UserLoaded(users));
  }

  Future<void> _fetchUsersFromApi(Emitter<UserState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if users are already stored
      final cachedUsers = prefs.getString('cached_users');
      List<User> existingUsers = [];

      if (cachedUsers != null) {
        final List<dynamic> data = json.decode(cachedUsers);
        existingUsers = data.map((json) => User.fromJson(json)).toList();
        emit(UserLoaded(existingUsers));
      } else {
        emit(UserLoading());
      }

      // Try fetching fresh data
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
        final apiUsers = data.map((json) => User.fromJson(json)).toList();

        // Merge API users with existing local users
        final mergedUsers = _mergeUsers(apiUsers, existingUsers);

        // Store merged data locally
        await prefs.setString(
          'cached_users',
          json.encode(mergedUsers.map((u) => u.toJson()).toList()),
        );
        emit(UserLoaded(mergedUsers));
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
        emit(UserError('Error loading users: $e'));
      }
    }
  }

  List<User> _mergeUsers(List<User> apiUsers, List<User> existingUsers) {
    // If no existing users, return API users
    if (existingUsers.isEmpty) {
      return apiUsers;
    }

    // Find the highest API user ID
    final maxApiId = apiUsers.isNotEmpty
        ? apiUsers.map((u) => u.id).reduce((a, b) => a > b ? a : b)
        : 0;

    // Separate API users from local users
    final localUsers = existingUsers
        .where((user) => user.id > maxApiId)
        .toList();

    // Merge API users with local users
    final mergedUsers = List<User>.from(apiUsers)..addAll(localUsers);

    return mergedUsers;
  }
}
