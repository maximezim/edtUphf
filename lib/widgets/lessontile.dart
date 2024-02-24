import 'package:flutter/material.dart';
import 'package:edt/data/models/lecon.dart';

class LessonTile extends StatelessWidget {
  final Lecon lesson;

  const LessonTile(this.lesson, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
          horizontal: 8, vertical: 4), // Add margin for spacing between cards
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              10)), // Smaller borderRadius for subtler curves
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 10.0), // Adjust padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.titre ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 18), // Smaller font size
              overflow: TextOverflow.ellipsis, // Prevents overflow
            ),
            const SizedBox(height: 4), // Reduced space
            Text(
              lesson.type?.toUpperCase() ?? "",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Divider(
                color: Colors.grey[300],
                thickness: 1,
                height: 20), // Adds a divider line
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // Wrap with Expanded for proper space allocation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.salle ?? "",
                        style: Theme.of(context).textTheme.bodyLarge,
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                      const SizedBox(height: 2), // Reduced space
                      Text(
                        lesson.prof ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                    ],
                  ),
                ),
                Text(
                  lesson.horaire ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
