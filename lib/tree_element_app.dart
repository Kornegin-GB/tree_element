import 'package:flutter/material.dart';
import 'package:tree_elements/router/router.dart';
import 'package:tree_elements/themes/theme.dart';

class TreeElementApp extends StatelessWidget {
  const TreeElementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      routerConfig: AppRouter().config(),
    );
  }
}
