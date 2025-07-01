import 'package:isar/isar.dart';


part 'note.g.dart';

@collection
class Note {
  Id id  = Isar.autoIncrement;
  late String title;
  late String subtitle;
  
  @Index()
  bool isPinned;

  @Index()
  DateTime dateTime;

  Note({
    required this.title,
    required this.subtitle,
    required this.isPinned,
    required this.dateTime,
  });
}