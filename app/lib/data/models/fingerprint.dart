import 'package:equatable/equatable.dart';

import '../../core/core.dart';

class Fingerprint extends Equatable {
  final int fingerprintId;
  final String? name;
  final DateTime creationDate;

  Fingerprint({
    required this.fingerprintId,
    this.name,
    creationDate,
  }) : creationDate = creationDate ?? DateTime.now();

  factory Fingerprint.fromMap(Map<String, dynamic> json) {
    if (!json.containsKey('fingerprint_id')) throw Exception();

    return Fingerprint(
      fingerprintId: json['fingerprint_id'] as int,
      name: json['name'] as String,
      creationDate: (json['created_at'] as String).utcToDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': fingerprintId,
      'name': name,
      // 'created_at': creationDate.formattedDate,
    };
  }

  Fingerprint copyWith({
    int? fingerprintId,
    String? name,
    DateTime? creationDate,
  }) {
    return Fingerprint(
      fingerprintId: fingerprintId ?? this.fingerprintId,
      name: name ?? this.name,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  List<Object?> get props => [fingerprintId, name, creationDate];
}
