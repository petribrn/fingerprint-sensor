abstract class UserSessionStorage {
  Future<bool> isFirstAppUse();
  Future<void> writeFirstAppUse();

  Future<int?> getAcessoSelectedId();
  Future<void> writeAcessoSelectedId(int idAcesso);
}
