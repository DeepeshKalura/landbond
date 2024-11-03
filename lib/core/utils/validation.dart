class Validator {
  Validator._();
  // Validates the name (only alphabetic characters and spaces, at least 2 characters)
  static String? validateName(String? value) {
    final nameRegExp = RegExp(r'^[a-zA-Z ]{2,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!nameRegExp.hasMatch(value)) {
      return 'Name must be at least 2 characters and contain only letters and spaces';
    }
    return null;
  }

  // Validates the email format
  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validates the password (at least 8 characters, including letters and numbers)
  static String? validatePassword(String? value) {
    final passwordRegExp =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@_!#\$%\^&\*\(\)]{8,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, include a letter, a number, and a special character';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    } else if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
