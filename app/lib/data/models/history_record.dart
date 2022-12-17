import 'package:equatable/equatable.dart';

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
      ),
      readDate: json['read_at'] as String,
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
