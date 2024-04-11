class ValidatorHelper {
  //
  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2, 4}$');
    if (value == null || value.isEmpty) {
      return "Email id is required.";
    } else if (!emailRegExp.hasMatch(value)) {
      return "Invalid Email Address.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }
    if (value.length < 6) {
      return "Password must be at least 6 character long.";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter.";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number.";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character.";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (value == null || value.isEmpty) {
      return "Phone number is required.";
    }
    if (!phoneRegExp.hasMatch(value)) {
      return "Invalid phone number format (10 digits required).";
    }
    return null;
  }

//
}