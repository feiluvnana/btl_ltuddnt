class Validators {
  static String? loginPasswordValidator(String? password) {
    if (password?.isEmpty != false) return "Không để trống mật khẩu";
    if (RegExp("<Đợi Việt>").hasMatch(password!)) {
      return "Mật khẩu không đúng định dạng";
    }
    return null;
  }

  static String? loginUsernameValidator(String? username) {
    if (username?.isEmpty != false) return "Không để trống tài khoản";
    if (RegExp("<Đợi Việt>").hasMatch(username!)) {
      return "Tài khoản không đúng định dạng";
    }
    return null;
  }
}
