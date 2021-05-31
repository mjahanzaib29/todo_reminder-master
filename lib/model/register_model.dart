class RegisterPOJO {
  final String userId;
  final String userName;
  final String userEmail;
  final String userPassword;

  RegisterPOJO({this.userId, this.userName, this.userEmail, this.userPassword});


  Map<String, dynamic> toMap() {
    return {
      'Id': userId,
      'User_Name': userName,
      'Email': userEmail,
      'Password': userPassword
    };
  }
}