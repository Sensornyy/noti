class ValidatorUtil {
  static String? validateEmpty(String? value) {
    return value == null || value.isEmpty ? '' : null;
  }

  static String? validatePinput(String? value) {
    String? validator = validateEmpty(value);
    if (validator != null) {
      return validator;
    } else if (int.parse(value!) > 2359) {
      return '';
    } else {
      return null;
    }
  }
}
