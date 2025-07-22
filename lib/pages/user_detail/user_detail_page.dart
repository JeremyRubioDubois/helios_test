import 'package:flutter/material.dart';
import 'package:helios_test/pages/user_detail/user_detail_presenter.dart';

class UserDetailPage extends StatefulWidget {
  final UserDetailPresenter presenter;

  const UserDetailPage({super.key, required this.presenter});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage>
    implements UserDetailDelegate {
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
      appBar: AppBar(title: Text(widget.presenter.user.fullName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.presenter.user.pictureUrl),
            ),
            const SizedBox(height: 20),
            Text(
              widget.presenter.user.fullName,
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void refreshView() {
    if (mounted) setState(() {});
  }
}
