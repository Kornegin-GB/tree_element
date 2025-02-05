import 'package:flutter/material.dart';
import 'package:tree_elements/models/tree_model.dart';

class ServerApi {
  static final ServerApi _serverApi = ServerApi._internal();

  ServerApi._internal();

  factory ServerApi.instance() {
    return _serverApi;
  }

  ///[_testDataTree] список элементов для тестирования
  final List<TreeModel> _testDataTree = [
    TreeModel(
      title: "Root 1",
      isCheck: ValueNotifier(false),
      isExpanded: ValueNotifier(false),
      children: [
        TreeModel(
            title: "Root 1 Child 1",
            isCheck: ValueNotifier(false),
            isExpanded: ValueNotifier(false)),
        TreeModel(
            title: "Root 1 Child 2",
            isCheck: ValueNotifier(false),
            isExpanded: ValueNotifier(false)),
        TreeModel(
            title: "Root 1 Child 3",
            isCheck: ValueNotifier(false),
            isExpanded: ValueNotifier(false)),
      ],
    ),
    TreeModel(
      title: "Root 2",
      isCheck: ValueNotifier(false),
      isExpanded: ValueNotifier(false),
      children: [
        TreeModel(
            title: "Root 2 Child 1",
            isCheck: ValueNotifier(false),
            isExpanded: ValueNotifier(false)),
        TreeModel(
          title: "Root 2 Child 2",
          isCheck: ValueNotifier(false),
          isExpanded: ValueNotifier(false),
          children: [
            TreeModel(
                title: "Root 2 Child 2 Child 1",
                isCheck: ValueNotifier(false),
                isExpanded: ValueNotifier(false)),
            TreeModel(
              title: "Root 2 Child 2 Child 2",
              isCheck: ValueNotifier(false),
              isExpanded: ValueNotifier(false),
              children: [
                TreeModel(
                    title: "Root 2 Child 2 Child 2 Child 1",
                    isCheck: ValueNotifier(false),
                    isExpanded: ValueNotifier(false)),
              ],
            ),
            TreeModel(
                title: "Root 2 Child 2 Child 3",
                isCheck: ValueNotifier(false),
                isExpanded: ValueNotifier(false)),
          ],
        ),
        TreeModel(
            title: "Root 2 Child 3",
            isCheck: ValueNotifier(false),
            isExpanded: ValueNotifier(false)),
      ],
    ),
  ];

  List<TreeSliverNode<TreeModel>> listNode = [];

  ///Метод получает список node из списка элементов пришедших с сервера
  List<TreeSliverNode<TreeModel>> getListNode() {
    listNode = [];
    _generateNode(_testDataTree);
    return listNode;
  }

  ///Метод создаёт список нод
  TreeSliverNode? _generateNode(List<TreeModel> elementChild) {
    TreeSliverNode<TreeModel>? nodeNew;
    for (TreeModel element in elementChild) {
      nodeNew = TreeSliverNode(element);
      if (element.children.isNotEmpty) {
        _generateNodeChild(element.children, nodeNew);
      }
      listNode.add(nodeNew);
    }
    return null;
  }

  ///Метод добавляет к родительским нодам дочернии
  TreeSliverNode? _generateNodeChild(
      List<TreeModel> elementChild, TreeSliverNode nodeParent) {
    TreeSliverNode<TreeModel>? nodeNew;
    for (TreeModel element in elementChild) {
      nodeNew = TreeSliverNode(element);
      if (element.children.isNotEmpty) {
        _generateNodeChild(element.children, nodeNew);
      }
      nodeParent.children.add(nodeNew);
    }
    return null;
  }

  ///Метод удаления вложенной ноды
  void removeChild(
      List<TreeSliverNode> nodeListChild, TreeSliverNode currentNode) {
    nodeListChild.removeWhere(
      (element) {
        if (element == currentNode) return true;
        removeChild(element.children, currentNode);
        return false;
      },
    );
  }

  ///Метод удаления конкретной ноды
  void removeNode(TreeSliverNode<TreeModel> currentNode) {
    listNode.removeWhere(
      (element) {
        if (element == currentNode) return true;
        removeChild(element.children, currentNode);
        return false;
      },
    );
  }

  ///Метод добавления ноды
  void addNode(TreeSliverNode<TreeModel> currentNode) {
    currentNode.children.add(TreeSliverNode<TreeModel>(TreeModel(
      isCheck: ValueNotifier(false),
      isExpanded: ValueNotifier(false),
      title: "Напишите свой текст",
    )));
  }
}
