import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import 'package:social_app/edit_profile/edit_profile_screen.dart';
import 'package:social_app/pages/login/login_screen.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';
import '../../shared/bloc/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: model != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 220.0,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Container(
                            width: double.infinity,
                            height: 180.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  model!.coverImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: CircleAvatar(
                            radius: 61.0,
                            backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 58.0,
                              backgroundImage: NetworkImage(
                                model.image,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    model.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.0,
                      color: Colors.black,
                      fontFamily: 'Jannah',
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    model.bio, //use bodySmall instead of caption
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:  Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 10.0, end: 15.0, start: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '${model.noOfPosts}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '${model.noOfFollowers}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '${model.noOfFollowing}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  '${model.noOfFriends}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17.0,
                                  ),
                                ),
                                Text(
                                  'Friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 10.0, end: 15.0, start: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            child: Text(
                              'Add Photos',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            navigateTo(
                                context: context, widget: EditProfileScreen());
                          },
                          child: Icon(
                            IconBroken.Edit,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    child: Text(
                      'Edit Email',
                      style: TextStyle(
                        color: defaultColor,
                      ),
                    ),
                    onPressed: () {
                      // FirebaseAuth.instance.currentUser?.updateEmail('nourat536@gmail.com').then((value) {
                      //   print('updated sucessfully');
                      // });
                    },
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  /********      log out button    **********/
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 10.0, end: 15.0, start: 15.0),
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .logOut(context: context, widget: LoginScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Logout,
                              size: 24.0,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Log out',
                              style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
