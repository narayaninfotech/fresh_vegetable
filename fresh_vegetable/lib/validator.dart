import 'dart:async';

mixin Validator {

  var fullnameValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (fullname, sink) {
    Pattern patternFullname = r'[A-Za-z][" "][A-Za-z][" "][A-Za-z]';
    RegExp regex = new RegExp(patternFullname);
    if (regex.hasMatch(fullname)) {
      sink.add(fullname);
    } else
      sink.addError("Example - Dhimant M Desai");
  });

  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern patternEmail = r'[\w-]+@([\w-]+\.)+[\w-]+';
    RegExp regex = new RegExp(patternEmail);
    if (regex.hasMatch(email)) {
      sink.add(email);
    } else
      sink.addError("Email is not valid");
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    Pattern patternPassword = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$';
    RegExp regex = new RegExp(patternPassword);
    if (regex.hasMatch(password)) {
      sink.add(password);
    } else
      sink.addError(
          "Password msut contain:\n - one upper case letter\n - one lower case letter\n - one numeric digit\n - at least 4 characters");
  });

  var otpValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (otp, sink) {
    Pattern patternOtp = r'[0-9]{4}';
    RegExp regex = new RegExp(patternOtp);
    if (regex.hasMatch(otp)) {
      sink.add(otp);
    } else
      sink.addError("Enter valid OTP");
  });
}
