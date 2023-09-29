class Validators {
  static String? loginPasswordValidator(String? password) {
    if (password?.isEmpty != false) return "Không để trống mật khẩu";
    if (!RegExp("^[A-Za-z][A-Za-z0-9_]{7,29}").hasMatch(password!)) {
      return "Mật khẩu không đúng định dạng";
    }
    return null;
  }

  static String? loginUsernameValidator(String? username) {
    if (username?.isEmpty != false) return "Không để trống tài khoản";
    if (!RegExp("[a-z0-9]+@[a-z]+\.[a-z]{2,3}").hasMatch(username!)) {
      return "Tài khoản không đúng định dạng";
    }
    return null;
  }

  static String? signupFirstnameValidator(String? firstname) {
    if (firstname?.isEmpty != false) return "Không để trống tên";
    if (!RegExp("^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\$").hasMatch(firstname!)) {
      return "Tên không đúng định dạng";
    }
    return null;
  }

  static String? signupLastnameValidator(String? lastname) {
    if (lastname?.isEmpty != false) return "Không để trống họ";
    if (!RegExp("/^[a-zA-Z]+ [a-zA-Z]+\$/").hasMatch(lastname!)) {
      return "Họ không đúng định dạng";
    }
    return null;
  }
}
