import 'package:flutter/material.dart';
import 'package:edt/config/fonctions.dart';
import 'package:edt/widgets/datepick.dart';

class DemoBottomAppBar extends StatelessWidget {
  final void Function() onNextDay;
  final void Function() onPreviousDay;
  const DemoBottomAppBar({
    super.key,
    required this.isElevated,
    required this.isVisible,
    required this.onNextDay,
    required this.onPreviousDay,
  });

  final bool isElevated;
  final bool isVisible;
  final DatePicker datePicker = const DatePicker(
    restorationId: 'example_restoration_id',
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 80.0 : 0,
      child: BottomAppBar(
        elevation: isElevated ? null : 0.0,
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Gauche',
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                onPreviousDay;
              },
            ),
            IconButton(
              tooltip: 'Droite',
              icon: const Icon(Icons.arrow_right),
              onPressed: () {
                onNextDay;
              },
            ),
            const Expanded(child: SizedBox()),
            FloatingActionButton(
              tooltip: 'Choisir une date',
              child: const Icon(Icons.calendar_month),
              onPressed: () {
                route(context, datePicker);
              },
            ),
          ],
        ),
      ),
    );
  }
}
