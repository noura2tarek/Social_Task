import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/controllers/bloc/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../models/user_model.dart';
import '../../../screens/widgets/components.dart';
import '../../managers/app_strings.dart';
import '../../managers/values.dart';
import '../../network/local/cache_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

//method to return bloc object
  static SocialCubit get(context) => BlocProvider.of(context); //expression body

//use saved current index from constants
  void changeBottomIndex(int index) {
    if (index == 1) {
      emit(SocialAddPostState());
    } else {
      savedCurrentIndex = index;
    }
    CacheHelper.savaData(
            key: AppStrings.savedCurrentIndexKey, value: savedCurrentIndex)
        .then((value) {
      emit(SocialChangeBottomNavState());
    });
  }

  //change mode
  void changeMode() {
    isDark = !isDark;
    CacheHelper.putBoolean(key: AppStrings.isDarkKey, value: isDark)
        .then((value) {
      emit(SocialChangeModeState());
    });
  }

  //set mode
  //method to get shared pref data to see the latest mode and apply it
  void setMode({required bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(SocialSetModeState());
    } else {
      CacheHelper.putBoolean(key: AppStrings.isDarkKey, value: isDark)
          .then((value) {
        emit(SocialSetModeState());
      });
    }
  }

  //method to get user data in home layout
  UserModel? userModel;

  Future getUserData({String? userId}) async {
    emit(SocialGetUserLoadingState());
    //get method return -> Future<DocumentSnapShot>
    FirebaseFirestore.instance
        .collection(AppStrings.users)
        .doc(userId)
        .snapshots()
        .listen((value) async {
      userModel = null;
      userModel = UserModel.fromJson(value.data());

      //userModel?.isEmailVerified =  await FirebaseAuth.instance.currentUser!.emailVerified;
      emit(SocialGetUserSuccessState());
    });
  }

  //get all users
  List<UserModel> usersData = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance
        .collection(AppStrings.users)
        .snapshots()
        .listen((value) {
      usersData = [];
      for (var element in value.docs) {
        if (element.id != userModel?.uId) {
          usersData.add(UserModel.fromJson(element.data()));
        }
      }
      emit(SocialGetAllUsersSuccessState());
    });
  }

  //verify Email --> send email verification
  void verifyEmail() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
      showToast(message: AppStrings.checkMail, state: ToastStates.SUCCESS);
      updateUser(
        name: userModel!.name!,
        phone: userModel!.phone!,
        bio: userModel!.bio!,
        isEmailVerified: true,
      );
    }).catchError((error) {
      showToast(message: AppStrings.checkInternet, state: ToastStates.NOTIFY);
    });
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
      showToast(
        message: AppStrings.noImageSelected,
        state: ToastStates.ERROR,
      );
      emit(SocialGetProfileImageErrorState());
    }
  }

  //upload pickedProfileImage file to firebase storage to store it
  String? profileImageUrl;

  Future<void> uploadProfileImage() async {
    FirebaseStorage.instance
        .ref()
        .child(
            '${AppStrings.usersPhotos}/${Uri.file(profileImage!.path).pathSegments.last}')
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
      showToast(
        message: AppStrings.noImageSelected,
        state: ToastStates.ERROR,
      );
      emit(SocialGetCoverImageErrorState());
    }
  }

  //upload pickedCoverImage file to firebase storage to store it
  String? coverImageUrl;

  Future<void> uploadCoverImage() async {
    FirebaseStorage.instance
        .ref()
        .child(
            '${AppStrings.usersPhotos}/${Uri.file(coverImage!.path).pathSegments.last}')
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
    String? email,
  }) async {
    emit(SocialUpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name,
      email: email,
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
        .collection(AppStrings.users)
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      emit(SocialUpdateUserDataSuccessState()); // we may delete that
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
      showToast(
        message: AppStrings.noImageSelected,
        state: ToastStates.ERROR,
      );
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
        .child(
            '${AppStrings.postsPhotos}/${Uri.file(postImage!.path).pathSegments.last}')
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
  Future createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) async {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name!,
      uId: userModel!.uId!,
      image: (profileImageUrl) ?? userModel!.image!,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    return await FirebaseFirestore.instance
        .collection(AppStrings
            .posts) // make post id same as user id to delete it using id.
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState()); // we may delete that
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  //Get posts
  List<PostModel> posts = [];
  List<PostModel> userPosts = [];
  List<String> postsIds = [];
  List<int> postsLikes = [];
  var list = [];

  Future getPosts() async {
    emit(SocialGetPostsLoadingState());
    return FirebaseFirestore.instance
        .collection(AppStrings.posts)
        .orderBy(AppStrings.dateTime)
        .snapshots()
        .listen((value) async {
      posts = [];
      postsLikes = [];
      postsIds = [];
      userPosts = [];
      for (var element in value.docs) {
        element.reference
            .collection(AppStrings.likes)
            .snapshots()
            .listen((value) {
          postsLikes.add(value.docs.length);

          if (!posts.contains(PostModel.fromJson(element.data()))) {
            posts.add(PostModel.fromJson(element.data()));
          }

          if (!postsIds.contains(element.id)) {
            postsIds.add(element.id);
          }

          if (element.data().containsValue(userModel?.uId)) {
            userPosts.add(PostModel.fromJson(element.data()));
          }
          userModel?.noOfPosts = userPosts.length;
        });
      }
      emit(SocialGetPostsSuccessState());
    });
  }

//we need to update post data if the person who posts changes his name or profileImage
  void updatePost({
    required String postId,
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialUpdatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name!,
      uId: userModel!.uId!,
      image: (profileImageUrl) ?? userModel!.image!,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection(AppStrings.posts)
        .doc(postId)
        .update(model.toMap())
        .then((value) {
      emit(SocialUpdatePostSuccessState());
    }).catchError((error) {
      emit(SocialUpdatePostErrorState());
    });
  }

//delete post method
  void deletePost({required String postId}) {
    FirebaseFirestore.instance
        .collection(AppStrings.posts)
        .doc(postId)
        .delete()
        .then((value) {
          
      emit(SocialDeletePostSuccessState());
    }).catchError((error) {
      emit(SocialDeletePostErrorState());
    });
  }

//like post
  Future<void> likePost({
    required String postId,
    required int index,
    required String userID,
  }) async {
    FirebaseFirestore.instance
        .collection(AppStrings.posts)
        .doc(postId)
        .collection(AppStrings.likes)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.id == userID) {
          FirebaseFirestore.instance
              .collection(AppStrings.posts)
              .doc(postId)
              .collection(AppStrings.likes)
              .doc(userID)
              .delete();
        } else {
          FirebaseFirestore.instance
              .collection(AppStrings.posts)
              .doc(postId)
              .collection(AppStrings.likes)
              .doc(userID)
              .set({
            AppStrings.like: true,
            AppStrings.userName: userModel?.name,
          }).then((value) {
            emit(SocialPostLikeSuccessState());
          }).catchError((error) {
            emit(SocialPostLikeErrorState());
          });
        }
      }
    });
  }

  Color likeColor(
      {required String postId, required String userID, required bool isLike}) {
    Color color = Colors.grey;
    bool? like;
    if (isLike) {
      color = Colors.red;
    } else {
      FirebaseFirestore.instance
          .collection(AppStrings.posts)
          .doc(postId)
          .collection(AppStrings.likes)
          .doc(userID)
          .snapshots()
          .listen((value) {
        like = value.data()?[AppStrings.like];
        if (like != null) {
          if (like!) {
            color = Colors.red;
          } else {
            color = Colors.grey;
          }
        }
      });
    }

    return color;
  }

//log out method
  void logOut({required BuildContext context, required Widget widget}) {
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: AppStrings.userIdKey).then((value) {
        navigateAndRemove(context: context, widget: widget);
      });
      emit(SocialLogOutSuccessState());
    }).catchError((error) {
      emit(SocialLogOutErrorState());
    });
  }
}
