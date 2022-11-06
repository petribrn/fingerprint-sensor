import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fingerprint_sensor/core/core.dart';

import '../../contracts/contracts.dart';

class UserSessionStorageImpl implements UserSessionStorage {
  FlutterSecureStorage secureStorage;

  UserSessionStorageImpl({
    required this.secureStorage,
  });

  @override
  Future<bool> isFirstAppUse() async {
    final isFirstAppUse = await secureStorage.read(key: isFirstAppUseKey);
    return isFirstAppUse != 'false';
  }

  @override
  Future<void> writeFirstAppUse() async {
    await secureStorage.write(key: isFirstAppUseKey, value: 'false');
  }

  @override
  Future<int?> getAcessoSelectedId() async {
    final idAcesso = await secureStorage.read(key: acessoSelectedKey);
    return idAcesso == null ? null : int.parse(idAcesso);
  }

  @override
  Future<void> writeAcessoSelectedId(int idAcesso) async {
    await secureStorage.write(key: acessoSelectedKey, value: '$idAcesso');
  }
}
