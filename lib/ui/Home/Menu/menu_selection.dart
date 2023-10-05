import 'package:flutter/material.dart';

class MenuSelection extends StatelessWidget {
  const MenuSelection({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.all(10)),
        onPressed: data["action"],
        child: Row(
          children: [
            Icon(data["icon"]),
            const SizedBox(width: 10),
            Text(data["label"]),
          ],
        ),
      ),
    );
  }
}
