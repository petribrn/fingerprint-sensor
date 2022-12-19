import '../../../data/data.dart';

abstract class FingerprintRepository {
  Future<Result> initSignUp(int fingerprintId);

  Future<Result> executeFirstRead();

  Future<Result> executeSecondRead();

  Future<Result> verifyFingerprint();

  Future<Result> sendFingerprint(Fingerprint fingerprint);

  Future<Result> updateFingerprint(Fingerprint fingerprint);

  Future<Result> deleteFingerprint(int fingerprintId);

  Future<List<Fingerprint>?> fetchAllFingerprints();
}
