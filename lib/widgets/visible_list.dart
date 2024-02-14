import 'package:flutter/material.dart';

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
    return const Column();
  }
}
