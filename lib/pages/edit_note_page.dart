import 'package:flutter/material.dart';
import 'package:todo_app/helper/helper_functions.dart';
import 'package:todo_app/models/note.dart';

class EditNotePage extends StatefulWidget {
  final Note note;
  const EditNotePage({
    super.key,
    required this.note,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {

  late TextEditingController titleController;
  late TextEditingController subtitleController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.note.title);
    subtitleController = TextEditingController(text: widget.note.subtitle);
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    subtitleController.dispose();
  }


  void titleAndSubtitleHasEdited() {
    final editedTitle = titleController.text.trim();
    final editedSubtitle = subtitleController.text.trim();

    final originalTitle = widget.note.title.trim();
    final originalSubtitle = widget.note.subtitle.trim();

    final hasEdited = editedTitle != originalTitle || editedSubtitle != originalSubtitle;
    final isNotEmptyNote = editedTitle.trim().isNotEmpty || editedSubtitle.trim().isNotEmpty;

    if (hasEdited && isNotEmptyNote) {
      Navigator.pop(
        context,
        Note(
          title: editedTitle, 
          subtitle: editedSubtitle,
          isPinned: false,
          dateTime: DateTime.now(),
        )
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () => titleAndSubtitleHasEdited(), 
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          )
        ),
        actions: [
          IconButton(
            onPressed: () => titleAndSubtitleHasEdited(), 
            icon: Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.start,
                textDirection: getTextDirection(titleController.text),
                keyboardType: TextInputType.multiline,
                onChanged: (value) => setState(() {}),
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                controller: subtitleController,
                textAlign: TextAlign.start,
                textDirection: getTextDirection(subtitleController.text),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) => setState(() {}),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Start typing...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}