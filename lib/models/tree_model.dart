import 'package:flutter/cupertino.dart';

class TreeModel {
  String title;
  ValueNotifier<bool> isCheck;
  ValueNotifier<bool> isExpanded;
  List<TreeModel> children;

  TreeModel({
    required this.title,
    required this.isCheck,
    required this.isExpanded,
    this.children = const <TreeModel>[],
  });

  @override
  String toString() {
    return title;
  }
}
