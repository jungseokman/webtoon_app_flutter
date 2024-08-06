import 'package:flutter/material.dart';
import 'package:webtoon_app_flutter/presentation/pages/home/home_page.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage(),
        theme: ThemeData(scaffoldBackgroundColor: Colors.white));
  }
}
