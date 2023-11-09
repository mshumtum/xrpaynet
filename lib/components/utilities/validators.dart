class Validators {
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
  static final RegExp _passwordRegExp = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})"); //one lowercase letter, one uppercase letter, one digit, one special character, and a minimum length of 8 characters.
  static final RegExp _simplePasswordRegExp =
      RegExp(r"^(?=.*[a-zA-Z0-9]).{5,}$");
  static final RegExp _mobileRegExp =
      RegExp(r"^(?:\+27|0)[1-9](?:\d ?\d{3} ?\d{4}|[1-9]\d ?\d{3} ?\d{3})$");
  static final RegExp _otpRegExp = RegExp(r"^[0-9]{4,8}$");
  static final RegExp _saIDRegExp = RegExp(
      r"(((\d{2}((0[13578]|1[02])(0[1-9]|[12]\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\d|30)|02(0[1-9]|1\d|2[0-8])))|([02468][048]|[13579][26])0229))(( |-)(\d{4})( |-)(\d{3})|(\d{7}))");
  static final RegExp _isWebsite = RegExp(
      r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})',
      caseSensitive: false);
  static final RegExp _isHashTag = RegExp(r"^#[a-zA-Z0-9_]*$");
  static final RegExp _isUserName = RegExp(r"^@[a-zA-Z0-9_]*$");

  static bool isValidEmail(String email) {
    if (email != '') {
      return _emailRegExp.hasMatch(email);
    }

    return false;
  }

  static bool isValidPassword(String password, {bool simple = false}) {
    if (password != '') {
      if (simple) {
        return _simplePasswordRegExp.hasMatch(password);
      } else {
        return _passwordRegExp.hasMatch(password);
      }
    }

    return false;
  }

  static bool isValidPhone(String phone) {
    if (phone != '') {
      return _mobileRegExp.hasMatch(phone);
    }
    return false;
  }

  static bool isValidOTP(String otp, {num length = 6}) {
    if (otp != '') {
      return _otpRegExp.hasMatch(otp) && otp.length == length;
    }

    return false;
  }

  static bool isValidID(String id) {
    if (id != '') {
      return _saIDRegExp.hasMatch(id) && id.length == 13;
    }
    return false;
  }

  static bool isValidWebsite(String website) {
    if (website != '') {
      return _isWebsite.hasMatch(website);
    }
    return false;
  }

  static bool isValidHashTag(String hashtag) {
    if (hashtag != '') {
      return _isHashTag.hasMatch(hashtag);
    }

    return false;
  }

  static bool isValidUserName(String userName) {
    if (userName != '') {
      return _isUserName.hasMatch(userName);
    }

    return false;
  }

  static bool isNameValid(String name) {
    const pattern = r'^[a-z A-Z]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }

  static bool isValidCityName(String name) {
    const pattern = r'^[a-zA-Z]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }

  static bool isValidPostalCode(String name) {
    const pattern = r'^[a-zA-Z0-9]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }

  static bool isValidNumber(String name) {
    const pattern = r'^\d{8,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }

  static bool isValidCardNumber(String name) {
    const pattern = r'^\d{16,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(name.trim());
  }
}
