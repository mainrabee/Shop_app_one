class SocialUserModel
{
  String ? name;
  String ? email;
  String ? phone;
  String ? uId;
  String ? image;
  String ? cover;
  String ? bio;
  bool ? isEmailVrevied;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVrevied,
});
  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name  = json['name'];
    phone = json['phone'];
    uId   = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio   = json['bio'];
    isEmailVrevied   = json['isEmailVrevied'];
  }

  Map <String,dynamic> toMap()
  {
    return {
      'name' :name,
      'email':email,
      'phone':phone,
      'uId'  :uId,
      'image'  :image,
      'cover'  :cover,
      'bio'  :bio,
      'isEmailVrevied'  :isEmailVrevied,
    };
  }
}