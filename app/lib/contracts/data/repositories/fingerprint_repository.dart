import '../../../data/data.dart';

abstract class FingerprintRepository {
  Future<Fingerprint?> fetchFingerprint(int fingerprintId);

  Future<bool> sendFingerprint(Fingerprint fingerprint);

  Future<bool> updateFingerprint(Fingerprint fingerprint);

  Future<bool> deleteFingerprint(int fingerprintId);

  Future<List<Fingerprint>?> fetchAllFingerprints();
}
