import 'package:equatable/equatable.dart';

class Fingerprint extends Equatable {
  final int fingerprintId;
  final String? name;

  const Fingerprint({
    required this.fingerprintId,
    this.name,
  });

  factory Fingerprint.fromMap(Map<String, dynamic> json) {
    if (!json.containsKey('fingerprint_id')) throw Exception();

    return Fingerprint(
      fingerprintId: json['fingerprint_id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fingerprint_id': fingerprintId,
      'name': name,
    };
  }

  Fingerprint copyWith({
    int? fingerprintId,
    String? name,
  }) {
    return Fingerprint(
      fingerprintId: fingerprintId ?? this.fingerprintId,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [fingerprintId, name];
}
