import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailService {
  static bool vlidateEmail(String email) => EmailValidator.validate(email);

  static Future<void> launchEmailSubmission({
    required String toEmail,
    required String subject,
    String body = '',
    VoidCallback? errorCallback,
    VoidCallback? doneCallback,
  }) async {
    final mail = Email(
      subject: subject,
      recipients: [toEmail],
      body: body,
    );
    try {
      await FlutterEmailSender.send(mail);
      doneCallback?.call();
    } catch (e) {
      errorCallback?.call();
    }
  }
}
