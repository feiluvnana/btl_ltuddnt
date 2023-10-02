import 'package:btl_lap_trinh_ung_dung_da_nen_tang/values/enum.dart';

class Validators {
  ///Xác thực tài khoản khi đăng nhập.
  static String? loginUsernameValidator(String? username) {
    if (username?.isEmpty != false) return "Không để trống tài khoản";
    if (!RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}").hasMatch(username!)) {
      return "Tài khoản không đúng định dạng";
    }
    return null;
  }

  ///Xác thực mật khẩu khi đăng nhập.
  static String? loginPasswordValidator(String? password) {
    if (password?.isEmpty != false) return "Không để trống mật khẩu";
    if (!RegExp(r"^[A-Za-z][A-Za-z0-9_]{7,29}").hasMatch(password!)) {
      return "Mật khẩu không đúng định dạng";
    }
    return null;
  }

  ///Xác thực tên khi đăng ký.
  static String? signupFirstnameValidator(String? firstname) {
    if (firstname?.isEmpty != false) return "Không để trống tên";
    // if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{,8}$")
    //     .hasMatch(firstname!)) {
    //   return "Tên không đúng định dạng";
    // }
    return null;
  }

  ///Xác thực họ khi đăng ký.
  static String? signupLastnameValidator(String? lastname) {
    if (lastname?.isEmpty != false) return "Không để trống họ";
    // if (!RegExp(r"^[a-zA-Z]+ [a-zA-Z]+$").hasMatch(lastname!)) {
    //   return "Họ không đúng định dạng";
    // }
    return null;
  }

  ///Xác thực tuổi khi đăng ký.
  static String? signupDobValidator(String? dob) {
    //dob có dạng "00/00/0000", sẽ có giá trị lớn nhất là ngày hôm nay, và nhỏ nhất là 01/01 của 100 năm trước.
    if (dob?.isEmpty != false) return "Không để trống ngày sinh";
    DateTime date = DateTime(int.parse(dob!.substring(6)),
        int.parse(dob.substring(3, 5)), int.parse(dob.substring(0, 2)));
    DateTime now = DateTime.now();
    //Số năm, tháng và ngày mà hiện tại sai khác so với ngày sinh.
    int years = now.year - date.year,
        months = now.month - date.month,
        days = now.day - date.day;

    //Thêm điều kiện tuổi theo yêu cầu vào đây (vd kia là trên 18 tuổi)
    if (years < 18 ||
        years >= 18 && months < 0 ||
        years >= 18 && months >= 0 && days < 0) {
      return r'Không đủ tuổi bạn eie <(")';
    }

    return null;
  }

  ///Xác thực email khi đăng ký.
  static String? signupEmailValidator(String? email) {
    if (email?.isEmpty != false) return "Không để trống email";
    if (!RegExp(r"[a-z0-9]+@[a-z]+\.[a-z]{2,3}").hasMatch(email!)) {
      return "Email không đúng định dạng";
    }
    return null;
  }

  ///Xác thực mật khẩu khi đăng ký.
  static String? signupPasswordValidator(String? password) {
    if (password?.isEmpty != false) return "Không để trống mật khẩu";
    if (!RegExp(r"^[A-Za-z][A-Za-z0-9_]{7,29}").hasMatch(password!)) {
      return "Mật khẩu không đúng định dạng";
    }
    return null;
  }
}
