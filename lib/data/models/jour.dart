import 'package:edt/data/models/lecon.dart';

class SchoolDay {
  final DateTime date;
  final List<Lecon> lessons;

  SchoolDay(this.date, this.lessons);
}
