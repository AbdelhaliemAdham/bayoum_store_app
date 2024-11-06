import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SliderAction extends StatelessWidget {
  const SliderAction(
      {super.key, required this.child, required this.onDismissed});
  final Widget child;
  final Function onDismissed;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(
          color: Colors.grey.shade600,
        ),
        const BoxShadow(
          color: Colors.white,
        )
      ]),
      child: Slidable(
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(
            onDismissed: () => onDismissed(),
          ),

          // All actions are defined in the children parameter.
          children: const [
            // A SlidableAction can have an icon and/or a label.
            // SlidableAction(
            //   onPressed: onPressed(context),
            //   backgroundColor: const Color(0xFFFE4A49),
            //   foregroundColor: Colors.white,
            //   icon: Icons.cancel_outlined,
            //   label: 'Delete',
            // ),
          ],
        ),
        child: child,
      ),
    );
  }
}
