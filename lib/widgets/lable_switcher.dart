import 'package:flutter/material.dart';

class LableSwitcher extends StatefulWidget {
  final String lable;
  const LableSwitcher({super.key, required this.lable});

  @override
  State<LableSwitcher> createState() => _LableSwitcherState();
}

class _LableSwitcherState extends State<LableSwitcher> {
  bool isSelected = false;

  void toggleSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.lable),
      trailing: Switch(
          thumbIcon: thumbIcon, value: isSelected, onChanged: toggleSwitch),
    );
  }
}
