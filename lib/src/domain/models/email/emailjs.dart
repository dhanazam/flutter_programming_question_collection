class EmailJS {
  static String serviceId = 'interview_helper';
  static String templateId = 'template_bejm6ia';
}

class Message {
  final String email;
  final String message;
  Message({required this.email, required this.message});

  Map<String, dynamic> toJson() {
    return {'from_name': email.trim(), 'message': message.trim()};
  }
}
