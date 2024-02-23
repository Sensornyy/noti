import 'package:noti/core/utils/date_util.dart';

class ValidatorUtil {
  static String? validateEmpty(String? value) {
    return value == null || value.isEmpty ? '' : null;
  }

  static String? validatePinput(String? value) {
    String? validator = validateEmpty(value);
    if (validator != null) {
      return validator;
    } else if (int.parse(value!.substring(0, 2)) > 23 || int.parse(value.substring(2, 4)) > 59) {
      return 'Invalid time';
    } else if (int.parse(DateUtil.toStringFromDateTimeNow()) >= int.parse(value)) {
      return 'Too late. Choose another time';
    } else {
      return null;
    }
  }
}
