import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../../data/data.dart';

class HistoryRecord extends Equatable {
  final Fingerprint fingerprint;
  final DateTime readDate;

  const HistoryRecord({
    required this.fingerprint,
    required this.readDate,
  });

  factory HistoryRecord.fromMap(Map<String, dynamic> json) {
    if (!json.containsKey('fingerprint_id')) throw Exception();

    return HistoryRecord(
      fingerprint: Fingerprint(
        fingerprintId: json['fingerprint_id'] as int,
        name: json['name'] as String,
        creationDate: (json['creation_date'] as String).toDateTime,
      ),
      readDate: (json['read_date'] as String).toDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fingerprint_id': fingerprint.fingerprintId,
      'name': fingerprint.name,
      'creation_date': fingerprint.creationDate.formattedDate,
      'read_date': readDate,
    };
  }

  HistoryRecord copyWith({
    Fingerprint? fingerprint,
    DateTime? readDate,
  }) {
    return HistoryRecord(
      fingerprint: fingerprint ?? this.fingerprint,
      readDate: readDate ?? this.readDate,
    );
  }

  @override
  List<Object?> get props => [fingerprint, readDate];
}
