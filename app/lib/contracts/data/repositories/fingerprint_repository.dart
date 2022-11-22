import '../../../data/data.dart';

abstract class FingerprintRepository {
  Future<Fingerprint?> fetchFingerprint(int fingerprintId);

  Future<Result> sendFingerprint(Fingerprint fingerprint);

  Future<Result> updateFingerprint(Fingerprint fingerprint);

  Future<Result> deleteFingerprint(int fingerprintId);

  Future<List<Fingerprint>?> fetchAllFingerprints();
}
