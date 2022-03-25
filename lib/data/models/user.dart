class Users {
  String? email;
  String? password;
  String? phone;
  String? uId;
  String? userName;
  String? image;
  String? bio;
  String? coverImage;
  Users(
      {this.email,
      this.password,
      this.phone,
      this.uId,
      this.userName,
      this.coverImage,
      this.image,
      this.bio = 'Enter Your Bio...'});

  Users.FromJSON({required Map<String, dynamic> json}) {
    this.email = json["email"];
    this.password = json["password"];
    this.phone = json["phone"];
    this.uId = json["uId"];
    this.userName = json["userName"];
    this.image = json["image"];
    this.bio = json["bio"];
    this.coverImage = json["coverImage"];
  }

  static Map<String, dynamic> toMap({required Users user}) {
    return {
      'email': user.email,
      'password': user.password,
      'phone': user.phone,
      'uId': user.uId,
      'userName': user.userName,
      'image': user.image,
      'bio': user.bio,
      'coverImage': user.coverImage,
    };
  }
}
