import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../data.dart';

class HttpFingerprintRepository implements FingerprintRepository {
  HttpClient httpClientAdapter;

  HttpFingerprintRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<Result> sendFingerprintId(int fingerprintId) async {
    final url = makeApiUrl(path: 'users/init-sign-up/$fingerprintId');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result> executeFirstRead() async {
    final url = makeApiUrl(path: 'users/first-read');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result> executeSecondRead() async {
    final url = makeApiUrl(path: 'users/second-read');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result> verifyFingerprint() async {
    final url = makeApiUrl(path: 'users/check-fingerprint');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<List<Fingerprint>?> fetchAllFingerprints() async {
    final url = makeApiUrl(path: 'users');
    List? fingerprintsResponse;

    try {
      fingerprintsResponse = await httpClientAdapter.requestAll(url: url);
    } on Exception catch (_) {
      return null;
    }

    if (fingerprintsResponse == null) return null;

    final fingerprintsRaw = fingerprintsResponse.map((fingerprintMap) {
      try {
        return Fingerprint.fromMap(fingerprintMap);
      } on AppException {
        return Fingerprint(fingerprintId: -1);
      }
    });

    final fingerprints = fingerprintsRaw.where((fingerprint) => fingerprint.fingerprintId != -1).toList();

    return fingerprints;
  }

  @override
  Future<Result> updateFingerprint(Fingerprint fingerprint) async {
    final url = makeApiUrl(path: 'users/${fingerprint.fingerprintId}');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'put',
        body: fingerprint.toMap(),
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result> deleteFingerprint(int fingerprintId) async {
    final url = makeApiUrl(path: 'users/$fingerprintId');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'delete',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
  }
}
