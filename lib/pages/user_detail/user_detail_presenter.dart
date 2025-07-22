import 'package:helios_test/models/user_model.dart';

abstract class UserDetailDelegate {
  void refreshView();
}

class UserDetailPresenter {
  final User user;
  UserDetailDelegate? delegate;

  UserDetailPresenter({required this.user});

  void init() {}

  void dispose() {}
}
