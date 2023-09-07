class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String coverImage;
  late String bio;
  late bool isEmailVerified;
  late int noOfPosts;
  late int noOfFollowers;
  late int noOfFollowing;
  late int noOfFriends;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.coverImage,
    required this.bio,
    required this.isEmailVerified,
    required this.noOfPosts,
    required this.noOfFollowers,
    required this.noOfFollowing,
    required this.noOfFriends,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    uId = json?['uId'];
    image = json?['image'];
    coverImage = json?['coverImage'];
    bio = json?['bio'];
    isEmailVerified = json?['isEmailVerified'];
    noOfPosts = json?['noOfPosts'];
    noOfFollowers = json?['noOfFollowers'];
    noOfFollowing = json?['noOfFollowing'];
    noOfFriends = json?['noOfFriends'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
      'uId' : uId,
      'image' : image,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
      'noOfPosts': noOfPosts,
      'noOfFollowers': noOfFollowers,
      'noOfFollowing': noOfFollowing,
      'noOfFriends': noOfFriends,

    };
  }
}
