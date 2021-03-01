class Validators {
  static const String EMAIL_REGEX =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
  static const String PASSWORD_REGEX =
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$";

  static String isNotEmpty(text) {
    return (text?.isEmpty ?? true) ? "This field can't be empty." : null;
  }

  static String emailValidator(String value) {
    return !checkRegex(EMAIL_REGEX, value) ? "Invalid email address." : null;
  }

  static String passwordValidator(String value) {
    return !checkRegex(PASSWORD_REGEX, value)
        ? "Password must be minimum six characters, at least one letter and one number"
        : null;
  }

  static bool checkRegex(String regex, String value) {
    final regExp = RegExp(regex);
    return regExp.hasMatch(value);
  }
}
