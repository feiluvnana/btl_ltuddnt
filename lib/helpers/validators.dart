class Validators {
  static String? loginPasswordValidator(String? password) {
    if (password == null) return "Không để trống mật khẩu";
    if (password.isEmpty) return "Không để trống mật khẩu";
    return null;
  }

  static String? loginUsernameValidator(String? username) {
    if (username == null) return "Không để trống tài khoản";
    if (username.isEmpty) return "Không để trống tài khoản";
    return null;
  }
}
