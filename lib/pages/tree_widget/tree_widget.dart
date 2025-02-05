import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tree_elements/models/tree_model.dart';
import 'package:tree_elements/services/server_api.dart';

class TreeWidget extends StatefulWidget {
  const TreeWidget({super.key, this.padding = 20});

  final double padding;

  @override
  State<TreeWidget> createState() => _BuildTreeState();
}

class _BuildTreeState extends State<TreeWidget> {
  ServerApi serverApi = ServerApi.instance();

  @override
  void initState() {
    serverApi.getListNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        _getTree(),
      ],
    );
  }

  Widget _treeNodeBuilder(
    BuildContext context,
    TreeSliverNode<dynamic> node,
    AnimationStyle toggleAnimationStyle,
  ) {
    final bool isParentNode = node.children.isNotEmpty;
    TextEditingController _controller = TextEditingController();
    _controller.text = node.content!.title;
    node.content.isExpanded.value = node.isExpanded;
    return TreeSliver.wrapChildToToggleNode(
      node: node,
      child: Padding(
        padding: EdgeInsets.only(left: widget.padding * node.depth!),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Visibility(
              visible: isParentNode,
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              child: Icon(
                node.isExpanded ? Icons.remove : Icons.add,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) => node.content.title = value,
              ),
            ),
            // Spacer(),
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: node.content.isCheck as ValueNotifier<bool>,
                  builder: (context, value, child) => Checkbox(
                    value: value,
                    onChanged: (value) {
                      node.content.isCheck.value = value;
                      TreeSliverNode currentNode = node;
                      for (int i = node.depth!; i > 0; i--) {
                        if (currentNode.parent != null) {
                          currentNode = currentNode.parent!;
                          currentNode.content.isCheck.value = value;
                        }
                      }
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      serverApi.addNode(node as TreeSliverNode<TreeModel>);
                    });
                  },
                  child: Icon(Icons.add),
                ),
                Visibility(
                  visible: node.parent != null,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        serverApi.removeNode(node as TreeSliverNode<TreeModel>);
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTree() {
    return TreeSliver<TreeModel>(
      controller: TreeSliverController(),
      tree: serverApi.listNode,
      treeNodeBuilder: _treeNodeBuilder,
      indentation: TreeSliverIndentationType.none,
    );
  }
}
