
import 'package:flutter/material.dart';
import '../../screens/modules/feeds/feeds_screen.dart';
import '../../screens/modules/new_post/new_post_screen.dart';
import '../../screens/modules/profile/profile_screen.dart';
import '../../screens/modules/users/users_screen.dart';
import 'app_strings.dart';

//appBar titles
List<String> screensTitles = [
  AppStrings.newsFeed,
  AppStrings.addPost,
  AppStrings.usersc,
  AppStrings.profile,
];

List<Widget> screens = [
  FeedsScreen(),
  NewPostScreen(),
  UsersScreen(),
  ProfileScreen(),
];



