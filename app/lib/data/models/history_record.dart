import 'package:equatable/equatable.dart';

import '../../core/core.dart';
import '../data.dart';

class HistoryRecord extends Equatable {
  final Fingerprint fingerprint;
  final DateTime readDate;

  HistoryRecord({
    required this.fingerprint,
    readDate,
  }) : readDate = readDate ?? DateTime.now();

  factory HistoryRecord.fromMap(Map<String, dynamic> json) {
    if (!json.containsKey('access_id')) throw const AppException('Fingerprint id not found');

    return HistoryRecord(
      fingerprint: Fingerprint(
        fingerprintId: json['access_id'] as int,
        name: json['fingerprint_name'] as String,
        creationDate: (json['created_at'] as String).toDateTime,
      ),
      readDate: (json['read_at'] as String).toDateTime,
    );
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
