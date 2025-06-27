import 'package:flutter/material.dart';
import 'package:infotainment/src/ui/home/home.dart';
import 'package:infotainment/src/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: theme,
      darkTheme: darkTheme,
      home: HomeScreen(),
    );
  }
}
