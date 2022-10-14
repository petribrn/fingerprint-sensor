abstract class UserSessionStorageUtils {
  Future<bool> isFirstAppUse();
  Future<void> writeFirstAppUse();

  Future<int?> getAcessoSelectedId();
  Future<void> writeAcessoSelectedId(int idAcesso);
}
