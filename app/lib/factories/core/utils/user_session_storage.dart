import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../contracts/contracts.dart';
import '../../../core/core.dart';

UserSessionStorageUtils makeUserSessionStorageUtils() {
  return UserSessionStorageUtilsImpl(
    secureStorage: const FlutterSecureStorage(),
  );
}
