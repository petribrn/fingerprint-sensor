import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../contracts/contracts.dart';
import '../../../infra/infra.dart';

UserSessionStorage makeUserSessionStorage() {
  return UserSessionStorageImpl(
    secureStorage: const FlutterSecureStorage(),
  );
}
