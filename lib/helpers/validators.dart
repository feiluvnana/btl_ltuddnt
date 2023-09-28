class Validators {
  static String? loginPasswordValidator(String? password) {
    if (password == null) return "Không để trống mật khẩu";
    if (password.isEmpty) return "Không để trống mật khẩu";
    if (RegExp("").hasMatch(password)) return "Tài khoản không đúng định dạng";
    return null;
  }

  static String? loginUsernameValidator(String? username) {
    if (username == null) return "Không để trống tài khoản";
    if (username.isEmpty) return "Không để trống tài khoản";
    if (RegExp("").hasMatch(username)) return "Tài khoản không đúng định dạng";
    return null;
  }
}
