import 'package:flutter/material.dart';
import 'package:todo_app/helper/helper_functions.dart';
import 'package:todo_app/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final void Function()? onTap;
  final void Function()? onLongPress;
  const NoteTile({
    super.key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 17),
        child: Column(
          children: [
            ListTile(
              title: Text(
                note.title,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              subtitle: Text(
                note.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Text(
                    formatNoteDate(note.dateTime),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 10,
                    ),
                  ),

                  SizedBox(width: 5),

                  Icon(
                    note.isPinned ? Icons.push_pin : null,
                    size: 15
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}