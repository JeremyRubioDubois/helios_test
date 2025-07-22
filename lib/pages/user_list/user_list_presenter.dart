import 'package:flutter/material.dart';
import 'package:helios_test/models/user_model.dart';
import 'package:helios_test/services/user_services.dart';

abstract class UserListDelegate {
  void refreshView();
}

class UserListPresenter {
  UserListDelegate? delegate;

  List<User> users = [];
  int _currentPage = 1;
  bool _isLoading = false;

  UserListPresenter();

  void init() async {
    await fetchUsers();
    delegate?.refreshView();
  }

  void dispose() {}

  Future<void> fetchUsers() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final newUsers = await UserService().fetchUsers(page: _currentPage);
      users.addAll(newUsers);
      _currentPage++;
    } catch (e) {
      print('Erreur lors du chargement des utilisateurs: $e');
    } finally {
      _isLoading = false;
      delegate?.refreshView();
    }
  }

  void goToUserDetailPage({required BuildContext context, required User user}) {
    Navigator.pushNamed(context, '/user_detail', arguments: {'user': user});
  }
}
