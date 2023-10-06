import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import 'package:social_app/pages/new_post/new_post_screen.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';
import '../../shared/bloc/states.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, this.userVisitId}) : super(key: key);
  final String? userVisitId;

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
                                  model!.coverImage!,
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
                                model.image!,
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
                    model.name!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    model.bio!, //use bodySmall instead of caption
                    style: Theme.of(context).textTheme.bodySmall,
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
                                      .titleSmall,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: SocialCubit.get(context).isDark? Colors.grey :Colors.black87.withOpacity(0.7),
                                        //change color here according to theme mode
                                        fontSize: 15.0,
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
                                      .titleSmall,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: SocialCubit.get(context).isDark? Colors.grey :Colors.black87.withOpacity(0.7),
                                        fontSize: 15.0,
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
                                      .titleSmall,
                                ),
                                Text(
                                  'Following',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: SocialCubit.get(context).isDark? Colors.grey :Colors.black87.withOpacity(0.7),
                                        fontSize: 15.0,
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
                                      .titleSmall,
                                ),
                                Text(
                                  'Friends',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: SocialCubit.get(context).isDark? Colors.grey :Colors.black87.withOpacity(0.7),
                                        fontSize: 15.0,
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
                        bottom: 8.0, end: 15.0, start: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            child: Text(
                              'Add Photo / Post',
                              style: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                            onPressed: () {
                              navigateTo(
                                  context: context, widget: NewPostScreen());
                            },
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
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context: context, widget: SettingsScreen());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Setting),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text('Settings'),
                      ],
                    ),
                  ),
                  if (SocialCubit.get(context).userPosts.isNotEmpty)
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Posts',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 20.0,
                                  ),
                        ),
                      ),
                    ),
                  if (SocialCubit.get(context).userPosts.isNotEmpty)
                    const SizedBox(
                      height: 10.0,
                    ),
                  if (SocialCubit.get(context).userPosts.isNotEmpty)
                    ListView.separated(
                      itemCount: SocialCubit.get(context).userPosts.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildPostItem(
                          context: context,
                          model: SocialCubit.get(context).userPosts[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 8.0,
                      ),
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
