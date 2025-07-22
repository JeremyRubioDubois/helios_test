import 'package:flutter/material.dart';
import 'package:helios_test/pages/user_list/user_list_presenter.dart';

class UserListPage extends StatefulWidget {
  final UserListPresenter presenter;

  const UserListPage({super.key, required this.presenter});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    implements UserListDelegate {
  @override
  void initState() {
    super.initState();
    widget.presenter.delegate = this;
    widget.presenter.init();
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Utilisateurs')),
      body: ListView.builder(
        itemCount: widget.presenter.users.length,
        itemBuilder: (context, index) {
          final user = widget.presenter.users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.pictureUrl),
            ),
            title: Text(user.fullName),
            onTap: () {
              widget.presenter.goToUserDetailPage(context: context, user: user);
            },
          );
        },
      ),
    );
  }

  @override
  void refreshView() {
    if (mounted) setState(() {});
  }
}
