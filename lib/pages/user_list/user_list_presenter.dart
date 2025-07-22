import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/user_services.dart';

abstract class UserListDelegate {
  void refreshView();
}

class UserListPresenter {
  UserListDelegate? delegate;
  final _userService = UserService();

  List<User> users = [];
  final TextEditingController searchController = TextEditingController();
  List<User> filteredUsers = [];
  bool isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  UserListPresenter();

  void init() {
    fetchUsers();
  }

  void dispose() {}

  Future<void> fetchUsers() async {
    if (isLoading || !_hasMore) return;

    isLoading = true;
    delegate?.refreshView();

    try {
      final newUsers = await _userService.fetchUsers(page: _currentPage);

      if (newUsers.isEmpty) {
        _hasMore = false;
      } else {
        users.addAll(newUsers);
        filteredUsers = users;
        _currentPage++;
      }
    } catch (_) {
      // gestion d’erreur
    } finally {
      isLoading = false;
      delegate?.refreshView();
    }
  }

  void search(String query) {
    filteredUsers =
        users
            .where(
              (user) =>
                  user.fullName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    delegate?.refreshView();
  }

  void clearSearch() {
    filteredUsers = users;
    delegate?.refreshView();
  }

  void onScrollEnd() async {
    await fetchUsers();
  }

  void goToUserAlgoPage({required BuildContext context}) {
    Navigator.pushNamed(context, '/algo');
  }

  void goToUserDetailPage({required BuildContext context, required User user}) {
    Navigator.pushNamed(context, '/user_detail', arguments: {'user': user});
  }
}
