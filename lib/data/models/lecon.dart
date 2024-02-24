import 'package:edt/data/utils/datehelper.dart';

class Lecon {
  final String? titre;
  final String? salle;
  final String? horaire;
  final String? prof;
  final String? type;
  final String? infos;
  DateTime? date;

  Lecon({
    this.titre,
    this.salle,
    this.horaire,
    this.prof,
    this.type,
    this.infos,
    this.date,
  });

  toMap() {
    return {
      'titre': titre,
      'salle': salle,
      'horaire': horaire,
      'type': type,
      'prof': prof,
      'infos': infos,
      'date': DateHelper.convertDateTimeToSQLFormat(date!),
    };
  }

  factory Lecon.fromMap(Map<String, dynamic> map) {
    return Lecon(
      titre: map['titre'],
      salle: map['salle'],
      horaire: map['horaire'],
      type: map['type'],
      prof: map['prof'],
      infos: map['infos'],
      date: DateHelper.convertSQLDateFormatToDateTime(map['date']),
    );
  }
}
