abstract class UserSessionStorage {
  Future<bool> isFirstAppUse();
  Future<void> writeNotFirstAppUse();

  Future<int?> getAccessSelectedId();
  Future<void> writeAccessSelectedId(int idAcesso);
}
