import '../../contracts/contracts.dart';
import '../../factories/factories.dart';
import '../data.dart';

class HttpFingerprintRepository implements FingerprintRepository {
  HttpClient httpClientAdapter;

  HttpFingerprintRepository({
    required this.httpClientAdapter,
  });

  @override
  Future<Result> initSignUp(int fingerprintId) async {
    final url = makeApiUrl(path: 'arduino/init-sign-up/$fingerprintId');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
    }
  }

  @override
  Future<Result> executeFirstRead() async {
    final url = makeApiUrl(path: 'arduino/first-read');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
    }
  }

  @override
  Future<Result> executeSecondRead() async {
    final url = makeApiUrl(path: 'arduino/second-read');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
    }
  }

  @override
  Future<Result> verifyFingerprint() async {
    final url = makeApiUrl(path: 'arduino/check-fingerprint');

    try {
      final fingerprintResponse = await httpClientAdapter.request(
        url: url,
        method: 'get',
      );

      return fingerprintResponse == null ? Result.empty() : Result.data(fingerprintResponse);
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
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
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
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
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
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
    } on Exception catch (error) {
      if (error is AppException) {
        throw Result.error(error.message);
      }

      throw Result.error('$error');
    }
  }

  @override
  Future<List<Fingerprint>?> fetchAllFingerprints() async {
    final url = makeApiUrl(path: 'users');
    List? fingerprintsResponse;

    try {
      fingerprintsResponse = await httpClientAdapter.requestAll(url: url);
    } on Exception catch (error) {
      throw Result.error('$error');
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
}
