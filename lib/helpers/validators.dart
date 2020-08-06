String isEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);

  return email.isNotEmpty && regExp.hasMatch(email)
      ? 'Insira um email valido!'
      : null;
}

String isPhone(String phone) {
  if (phone == null || phone.isEmpty) return null;
  return phone.length < 14 || phone.length > 15
      ? 'Este número não é valido'
      : null;
}
