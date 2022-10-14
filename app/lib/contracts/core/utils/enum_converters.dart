import '../../../data/data.dart';

AccessMode getAccessModeById(int? idAcesso) {
  switch (idAcesso) {
    case 0:
      return AccessMode.cadastro_biometria;
    case 1:
      return AccessMode.verificar_biometria;
    default:
      return AccessMode.none;
  }
}
