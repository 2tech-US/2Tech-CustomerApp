class AuthenticationLogic {
  static String? checkName(String phoneNumber) {
    if (phoneNumber.isEmpty) return "Bạn phải nhập tên";
    return null;
  }

  static String? checkPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return "Bạn phải nhập số điện thoại";
    return null;
  }

  static String? checkPassword(String password) {
    if (password.isEmpty) return "Bạn phải nhập mật khẩu";
    if (password.length < 8) {
      return "Mật khẩu phải từ 8 ký tự";
    }
    return null;
  }

  static String? checkMatchPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return "Mật khẩu không trùng khớp";
    }
    return null;
  }
}
