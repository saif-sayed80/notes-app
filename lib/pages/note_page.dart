import 'package:flutter/material.dart';
import 'package:todo_app/helper/helper_functions.dart';
import 'package:todo_app/models/note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key,});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  late TextEditingController titleController;
  late TextEditingController subtitleController;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController();
    subtitleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    subtitleController.dispose();
  }

  void passControllersData() {
    if (titleController.text.trim().isNotEmpty || subtitleController.text.trim().isNotEmpty) {
      Navigator.pop(
        context,
        Note(
          title: titleController.text,
          subtitle: subtitleController.text, 
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: passControllersData, 
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          )
        ),
        actions: [
          IconButton(
            onPressed: passControllersData,
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
                onChanged:(value) => setState(() {}),
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 21
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
                controller: subtitleController,
                textAlign: TextAlign.start,
                textDirection: getTextDirection(subtitleController.text),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged:(value) => setState(() {}),
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary
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