class AuthValidator {
  static String? emailValidator(String? val) {
    if (val!.isEmpty) {
      return 'Please enter email address';
    } else if (!emailRegexValidator(val)) {
      return "This doesn't look like an email address";
    } else if (val.length > 50) {
      return 'Email must not exceed more than 50 characters';
    }
    return null;
  }

  static String? passwordValidator(String? val) {
    if (val!.isEmpty) {
      return "Please enter password";
    }
    if (val.length < 8) {
      return "Password must be greater than 8 characters";
    }
    return null;
  }

  static emailRegexValidator(email) {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
    ).hasMatch(email);
    if (emailValid) {
      return true;
    } else {
      return false;
    }
  }
}
