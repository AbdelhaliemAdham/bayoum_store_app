import 'package:flutter/material.dart';

class ChipWidget extends StatefulWidget {
  const ChipWidget({super.key});

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  bool men = false;
  bool women = false;
  bool all = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: InputChip(
            shadowColor: Colors.grey.shade300,
            elevation: 3,
            showCheckmark: false,
            selectedColor: Colors.redAccent,
            disabledColor: Colors.white,
            selected: all,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            side:
                all ? BorderSide.none : BorderSide(color: Colors.grey.shade200),
            onSelected: (value) {
              setState(() {
                all = value;
                men = false;
                women = false;
              });
            },
            label: Text(
              'All',
              style: TextStyle(
                color: all ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: InputChip(
            shadowColor: Colors.grey.shade300,
            elevation: 3,
            selectedColor: Colors.redAccent,
            showCheckmark: false,
            selected: men,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            side:
                men ? BorderSide.none : BorderSide(color: Colors.grey.shade200),
            onSelected: (value) {
              setState(() {
                men = value;
                all = false;
                women = false;
              });
            },
            label: Text(
              'men',
              style: TextStyle(
                color: men ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: InputChip(
            shadowColor: Colors.grey.shade300,
            elevation: 3,
            selectedColor: Colors.redAccent,
            showCheckmark: false,
            selected: women,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            side: women
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade200),
            onSelected: (value) {
              setState(() {
                women = value;
                men = false;
                all = false;
              });
            },
            label: Text(
              'Women',
              style: TextStyle(
                color: women ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
