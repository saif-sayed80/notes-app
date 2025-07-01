import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/components/note_tile.dart';
import 'package:todo_app/database/note_database.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/pages/edit_note_page.dart';
import 'package:todo_app/pages/note_page.dart';
import 'package:todo_app/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    Provider.of<NoteDatabase>(context, listen: false).readNotes();
  }

  void addNote() async {
    final noteDatabase = context.read<NoteDatabase>();

    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => NotePage(),)
    );

    if (newNote != null && newNote is Note) {
      noteDatabase.addNote(newNote);
    }
  }


  void editNote(int index) async {
    final noteDatabase = context.read<NoteDatabase>();
    final notes = noteDatabase.currentNote;

    final editNote = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder:(context) => EditNotePage(note: notes[index]),
      )
    );

    if (editNote != null && editNote is Note) {
      noteDatabase.editNote(notes[index].id, editNote);
    }
  }


  void deleteNote(int index) {
    final noteDatabase = context.read<NoteDatabase>();
    final notes = noteDatabase.currentNote;

    Navigator.pop(context);

    noteDatabase.deletNotes(notes[index].id);
  }


  void togglePin(int index) async {
    final noteDatabase = context.read<NoteDatabase>();
    final note = noteDatabase.currentNote[index];

    Navigator.pop(context);
    
    await noteDatabase.togglePin(note);
  }


  void showBottomBar(int index) {
    final noteDatabase = context.read<NoteDatabase>();
    final note = noteDatabase.currentNote;
    showModalBottomSheet(
      context: context, 
      builder:(context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.vertical(top: Radius.zero),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => togglePin(index), 
                icon: Icon(
                  note[index].isPinned
                  ? Icons.push_pin
                  : Icons.push_pin_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                )
              ),

              IconButton(
                onPressed: () => deleteNote(index), 
                icon: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          )
        );
      }
    );
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        toolbarHeight: 40,
        actionsPadding: EdgeInsets.all(5),
        actions: [
          IconButton(
            onPressed:() => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => SettingPage(),)
            ), 
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.tertiary,
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: CircleBorder(),
        onPressed: addNote,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      body: Consumer<NoteDatabase>(
        builder:(context, value, child) {
          final notes = value.currentNote;
          
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder:(context, index) => NoteTile(
              note: notes[index],
              onTap: () => editNote(index),
              onLongPress:() => showBottomBar(index),
            ),
          );
        },
      )
    );
  }
}