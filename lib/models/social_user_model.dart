class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.image,
    this.bio,
    this.cover,
    this.isEmailVerified,
    this.uId,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified']=='true'?true:false;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': '$name',
      'email': '$email',
      'phone': '$phone',
      'uId': '$uId',
      'image': '$image',
      'bio': '$bio',
      'cover': '$cover',
      'isEmailVerified': '$isEmailVerified',
    };
  }
}
