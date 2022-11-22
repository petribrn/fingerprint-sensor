import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../data.dart';

class HttpFingerprintRepository implements FingerprintRepository {
  HttpClient httpClientAdapter;

  HttpFingerprintRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<Fingerprint?> fetchFingerprint(int fingerprintId) async {
    final url = makeApiUrl(path: 'users/$fingerprintId');

    try {
      final httpResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return httpResponse == null ? null : Fingerprint.fromMap(httpResponse);
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<Result> sendFingerprint(Fingerprint fingerprint) async {
    final url = makeApiUrl(path: 'users');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'post',
        body: fingerprint.toMap(),
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (e) {
      return Result.error('$e');
    }
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

  @override
  Future<List<Fingerprint>?> fetchAllFingerprints() async {
    final url = makeApiUrl(path: 'users');

    try {
      final fingerprintsResponse = await httpClientAdapter.requestAll(
        url: url.toString(),
      );

      if (fingerprintsResponse == null) return null;

      final fingerprints = fingerprintsResponse.map((fingerprintMap) => Fingerprint.fromMap(fingerprintMap)).toList();

      return fingerprints;
    } on Exception catch (_) {
      return null;
    }
  }
}
