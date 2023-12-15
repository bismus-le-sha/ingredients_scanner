import 'package:flutter/material.dart';
import 'package:ingredients_scanner/widgets/lable_switcher.dart';

class VisibleList extends StatefulWidget {
  final String lable;
  const VisibleList({super.key, required this.lable});

  @override
  State<VisibleList> createState() => _VisibleListState();
}

class _VisibleListState extends State<VisibleList> {
  bool isVisible = false;

  void vilibleState() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {
              vilibleState();
            },
            child: Text(widget.lable)),
        Visibility(visible: isVisible, child: LableSwitcher(lable: 'milk'))
      ],
    );
  }
}
