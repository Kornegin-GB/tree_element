import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:tree_elements/pages/tree_widget/tree_widget.dart';

@RoutePage()
class TreeElementScreen extends StatelessWidget {
  const TreeElementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          title: Text("Tree elements"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,
          child: TreeWidget(),
        ),
      ),
    );
  }
}
