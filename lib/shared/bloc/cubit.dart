import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/pages/chats/chats_screen.dart';
import 'package:social_app/pages/feeds/feeds_screen.dart';
import 'package:social_app/pages/new_post/new_post_screen.dart';
import 'package:social_app/pages/users/users_screen.dart';
import 'package:social_app/shared/bloc/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/user_model.dart';
import '../../pages/profile/profile_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

//method to return bloc object
  static SocialCubit get(context) => BlocProvider.of(context); //expression body

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];

//appBar titles
  List<String> titles = [
    'News Feed',
    'Chats',
    'Add Post',
    'Users',
    'Profile',
  ];

  void changeBottomIndex(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  //method to get user data in home layout
  UserModel? userModel;

  Future getUserData() async {
    emit(SocialGetUserLoadingState());
    //get method return -> Future<DocumentSnapShot>
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .snapshots()
        .listen((value) async {
          userModel = null;
      userModel = UserModel.fromJson(value.data());
      //userModel?.isEmailVerified =  await FirebaseAuth.instance.currentUser!.emailVerified;
      emit(SocialGetUserSuccessState());
    });
  }

 //verify Email --> send email verification
  void verifyEmail() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
      showToast(message: 'check your mail', state: ToastStates.SUCCESS);
      updateUser(
        name: userModel!.name,
        phone: userModel!.phone,
        bio: userModel!.bio,
        isEmailVerified: true,
      );
    }).catchError((error) {
      showToast(
          message: 'check your internet connection', state: ToastStates.NOTIFY);
    });
  }
  //update email
  void updateEmail(){}
 //delete account method (delete user using Firebase authentication) add it in settings
  void deleteAccount(){

  }
  //get profileImage from gallery for profile
  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      uploadProfileImage();
      //emit(SocialGetProfileImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialGetProfileImageErrorState());
    }
  }

  //upload pickedProfileImage file to firebase storage to store it
  String? profileImageUrl;

  Future<void> uploadProfileImage() async {
    FirebaseStorage.instance
        .ref()
        .child('usersPhotos/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  //get coverImage from gallery for profile
  File? coverImage;

  Future<void> getCoverImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      uploadCoverImage();
      //emit(SocialGetCoverImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialGetCoverImageErrorState());
    }
  }

  //upload pickedCoverImage file to firebase storage to store it
  String? coverImageUrl;

  Future<void> uploadCoverImage() async {
    FirebaseStorage.instance
        .ref()
        .child('usersPhotos/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  //update user data in fireStore which we get in the start of application on profile page
  Future<void> updateUser({
    required String name,
    required String phone,
    required String bio,
    required bool isEmailVerified,
  }) async {
    emit(SocialUpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      isEmailVerified: isEmailVerified,
      image: (profileImageUrl) ?? userModel!.image,
      coverImage: (coverImageUrl) ?? userModel!.coverImage,
      bio: bio,
      noOfPosts: userModel!.noOfPosts,
      noOfFollowers: userModel!.noOfFollowers,
      noOfFollowing: userModel!.noOfFollowing,
      noOfFriends: userModel!.noOfFriends,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      //getAllUsers();
      //emit(SocialUpdateUserDataSuccessState()); // we may delete that
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState());
    });
  }

  //get postImage from gallery for post
  File? postImage;

  Future<void> getPostImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      //uploadCoverImage();
      emit(SocialGetPostImageSuccessState());
    } else {
      print('No Image Selected');
      emit(SocialGetPostImageErrorState());
    }
  }

  //upload post image to firebase storage
  Future<void> uploadPostImage({
    required String text,
    required String dateTime,
  }) async {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('postsPhotos/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
        emit(SocialUploadPostImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  //remove post image
  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageSuccessState());
  }

  //create Post
  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: (profileImageUrl) ?? userModel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState()); // we may delete that
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  //Get posts
  List<PostModel> posts =[];
  List<String> postsIds = [];
  List<int> postsLikes = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((value) async {
          posts = [];
          postsLikes = [];
          postsIds = [];
      for (var element in value.docs) {
        if(await element.reference.collection('likes').snapshots().isEmpty){
          posts.add(PostModel.fromJson(element.data()));
          postsIds.add(element.id);
        }
        else {
          element.reference.collection('likes').snapshots().listen((value) {
            postsLikes.add(value.docs.length);
            posts.add(PostModel.fromJson(element.data()));
            postsIds.add(element.id);

          });
        }


      }
      emit(SocialGetPostsSuccessState());
    });
  }

//we need to update post data if the person who posts changes his name or profileImage
  void updatePost() {}

//delete post method
 void deletePost(){}

  //get all users
  List<UserModel> usersData = [];

  void getAllUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((value) {
      usersData = [];
      for (var element in value.docs) {
        if (element.id != userModel?.uId) {
          usersData.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUsersSuccessState());
    });
  }

//like post or dislike post
  Future<void> likePost(
      {required String postId,
      required int index,
      required String userID,
      }) async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .snapshots()
        .listen((value) {
      value.docs.forEach((element) {
        if (element.id == userID) {
          // disLikePost(postId: postId).then((value) {
          //  likeColor(postId: postId,userID: userID,isLike: false);
          // });
        } else {
          FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .collection('likes')
              .doc(userModel?.uId)
              .set({
            'like': true,
            'userName' : userModel?.name,
          }).then((value) {
           // likeColor(postId: postId, userID: userID, isLike: true);
            emit(SocialPostLikeSuccessState());
          }).catchError((error) {
            emit(SocialPostLikeErrorState());
          });
        }
      });
    });
  }

//disLike post
//   Future disLikePost({required String postId}) async{
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(postId)
//         .collection('likes')
//         .doc(userModel?.uId)
//         .set({
//       'like': false,
//     }).then((value) {
//
//       emit(SocialDisPostLikeSuccessState());
//     }).catchError((error) {
//       emit(SocialDisPostLikeErrorState());
//     });
//   }

  // Color likeColor(
  //     {required String postId, required String userID, bool? isLike}) {
  //   Color color = Colors.grey;
  //   if (isLike == null) {
  //     FirebaseFirestore.instance
  //         .collection('posts')
  //         .doc(postId)
  //         .collection('likes')
  //         .doc(userModel?.uId)
  //         .get()
  //         .then((value) {
  //       if (value.data()!.containsValue(true)) {
  //         color = Colors.red;
  //       } else {
  //         color = Colors.grey;
  //       }
  //     });
  //   } else {
  //     if (isLike) {
  //       color = Colors.red;
  //     } else {
  //       color = Colors.grey;
  //     }
  //   }
  //   return color;
  // }

//log out method
  void logOut({required BuildContext context, required Widget widget}) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value) {
        navigateAndRemove(context: context, widget: widget);
      });
      emit(SocialLogOutSuccessState());
    }).catchError((error) {
      emit(SocialLogOutErrorState());
    });
  }

// Send message
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );
    //send my chats to firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
    //send receiver chats to firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

//Get messages
  List<MessageModel> messages = [];

  //this method will be called after we enter chat details screen to chat with someone
  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = []; // every listen will duplicate data so, we should empty the list
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }
}
