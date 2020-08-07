String isEmail(String email) {
  if (email.isNotEmpty || email != null) return null;

  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(email) ? null : 'Insira um email valido!';
}

String isPhone(String phone) {
  if (phone == null || phone.isEmpty) return null;
  return phone.length < 14 || phone.length > 15
      ? 'Este número não é valido'
      : null;
}

String isName(String name) =>
    name == null || name.length < 2 ? 'Digite um nome!' : null;
