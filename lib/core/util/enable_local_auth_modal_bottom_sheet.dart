import 'package:flutter/material.dart';

class EnableLocalAuthModalBottomSheet extends StatelessWidget {
  final void Function() actionOnYes;
  final void Function() actionOnNo;

  const EnableLocalAuthModalBottomSheet(
      {super.key, required this.actionOnYes, required this.actionOnNo});

  static const Color primaryColor = Color(0xFF13B5A2);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.fingerprint_outlined,
            size: 100,
            color: primaryColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Do you want to enable fingerprint login?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
              'The next time you log in, you will not be prompted for your login credentials.',
              textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              actionOnYes();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            child: const Text("Yes, cool!"),
          ),
          ElevatedButton(
              onPressed: () {
                actionOnNo();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                "No, thanks!",
                style: TextStyle(color: Colors.black54),
              ))
        ],
      ),
    );
  }
}
