import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }
  

  List<Note> currentNote = [];

  Future<void> addNote(Note note) async {
    await isar.writeTxn(() => isar.notes.put(note));

    readNotes();
  }

  Future<void> readNotes() async {
    List<Note> featchedNote = await isar.notes.where().sortByIsPinnedDesc().thenByDateTimeDesc().findAll();

    currentNote.clear();
    currentNote.addAll(featchedNote);

    notifyListeners();
  }

  Future<void> editNote(int id, Note updatedNote) async {
    updatedNote.id = id;

    await isar.writeTxn(() => isar.notes.put(updatedNote));

    readNotes();
  }

  Future<void> deletNotes(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));

    readNotes();
  }

  Future<void> togglePin(Note note) async {
    note.isPinned = !note.isPinned;

    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });

    readNotes();
  }
}