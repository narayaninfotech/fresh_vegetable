import 'dart:async';

class Validators {
  static final validateFullName =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (fullName, sink) {
    if (fullName.trim().contains(' ')) {
      sink.add(fullName);
    } else {
      sink.addError('Enter a valid full name');
    }
  });

  static final validateCommunityName =
  StreamTransformer<String, String>.fromHandlers(
      handleData: (communityName, sink) {
        if (communityName
            .trim()
            .length > 0) {
          sink.add(communityName);
        } else {
          sink.addError('Enter a valid community name');
        }
      });

  static bool isValidFullName(String fullName) {
    return (fullName.trim().contains(' '));
  }

  static final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  static final validatePhone =
  StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (phone
        .trim()
        .length > 5) {
      sink.add(phone);
    } else {
      sink.addError('Enter a valid phone');
    }
  });

  static final validateName =
  StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name
        .trim()
        .length > 0) {
      sink.add(name);
    } else {
      sink.addError('Enter a valid name');
    }
  });

  static bool isValidEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(pattern).hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    if (phone
        .trim()
        .length > 5) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidConfirmPassword(String newPassword,String confirmPassword) {
    if (confirmPassword==newPassword) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidOtp(String otp) {
    if (otp.length ==6) {
      return true;
    } else {
      return false;
    }
  }

  static bool isMatchingOtp(String otp,var created_otp) {
    print(otp);
    print(created_otp);
    if (otp==created_otp) {
      return true;
    } else {
      return false;
    }
  }


  static bool isValidName(String name) {
    if (name
        .trim()
        .length > 0) {
      return true;
    } else {
      return false;
    }
  }

  static final validatePassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('Password must be 8 characters long');
    }
  });

  static bool isValidPassword(String password) {
    return (password.length > 7);
  }
}
