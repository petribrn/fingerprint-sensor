enum AccessMode {
  cadastro_biometria,
  verificar_biometria,
  none,
}

extension AccessModeData on AccessMode {
  String get name {
    switch (this) {
      case AccessMode.cadastro_biometria:
        return 'Cadastrar biometrias';
      case AccessMode.verificar_biometria:
        return 'Verificar biometria';
      default:
        return 'Nenhum';
    }
  }
}
