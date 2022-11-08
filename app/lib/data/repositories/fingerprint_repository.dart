import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../models/models.dart';

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
  Future<bool> sendFingerprint(Fingerprint fingerprint) async {
    final url = makeApiUrl(path: 'users');

    try {
      final httpResponse = await httpClientAdapter.request(
        url: url,
        method: 'post',
        body: fingerprint.toMap(),
      );

      return httpResponse == null ? false : true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> updateFingerprint(Fingerprint fingerprint) async {
    final url = makeApiUrl(path: 'users/${fingerprint.fingerprintId}');

    try {
      final httpResponse = await httpClientAdapter.request(
        url: url,
        method: 'put',
        body: fingerprint.toMap(),
      );

      return httpResponse == null ? false : true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> deleteFingerprint(int fingerprintId) async {
    final url = makeApiUrl(path: 'users/$fingerprintId');

    try {
      final httpResponse = await httpClientAdapter.request(
        url: url,
        method: 'delete',
      );

      return httpResponse == null ? false : true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<List<Fingerprint>?> fetchAllFingerprints() async {
    final url = makeApiUrl(path: 'users');

    try {
      final httpResponse = await httpClientAdapter.requestAll(
        url: url.toString(),
      );

      if (httpResponse == null) return null;

      final fingerprints = httpResponse.map((fingerprintMap) => Fingerprint.fromMap(fingerprintMap)).toList();

      return fingerprints;
    } on Exception catch (_) {
      return null;
    }
  }
}
