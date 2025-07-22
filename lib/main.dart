import 'package:flutter/material.dart';
import 'package:helios_test/pages/algo/algo_page.dart';
import 'package:helios_test/pages/algo/algo_presenter.dart';
import 'package:helios_test/pages/user_detail/user_detail_page.dart';
import 'package:helios_test/pages/user_detail/user_detail_presenter.dart';
import 'package:helios_test/pages/user_list/user_list_page.dart';
import 'package:helios_test/pages/user_list/user_list_presenter.dart';

void main() {
  runApp(const HeliosTestApp(initialRoute: '/users'));
}

class HeliosTestApp extends StatelessWidget {
  final String initialRoute;

  const HeliosTestApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helios Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      routes: {
        '/users': (context) => UserListPage(presenter: UserListPresenter()),
        '/user_detail': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return UserDetailPage(
            presenter: UserDetailPresenter(user: args['user']),
          );
        },
        '/algo': (context) => AlgoPage(presenter: AlgoPresenter()),
      },
    );
  }
}
