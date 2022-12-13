import '../../../data/data.dart';

abstract class FingerprintRepository {
  Future<Fingerprint?> fetchFingerprint(int fingerprintId);

  Future<Result> sendFingerprintId(int fingerprintId);

  Future<Result> executeFirstRead();

  Future<Result> executeSecondRead();

  Future<Result> verifyFingerprint();

  Future<Result> updateFingerprint(Fingerprint fingerprint);

  Future<Result> deleteFingerprint(int fingerprintId);

  Future<List<Fingerprint>?> fetchAllFingerprints();
}
