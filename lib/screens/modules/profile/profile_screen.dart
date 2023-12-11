import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/bloc/states.dart';
import '../../../core/managers/app_strings.dart';
import '../../../core/managers/values.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/icon_broken.dart';
import '../../widgets/build_post_item.dart';
import '../../widgets/components.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../new_post/new_post_screen.dart';
import '../settings/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, this.userVisitId}) : super(key: key);
  final String? userVisitId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? model = SocialCubit.get(context).userModel;
        if (state is SocialGetUserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
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
                        decoration: BoxDecoration(),
                        child: CachedNetworkImage(
                          imageUrl: model!.coverImage!,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
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
                            child: ClipOval(
                              child: Container(
                                child: CachedNetworkImage(
                                  imageUrl: model.image!,
                                  placeholder: (context, url) =>
                                      Container(color: Colors.grey[300]),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                model.name! ?? '',
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
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              AppStrings.posts,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey
                                        : Colors.black87.withOpacity(0.7),
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
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey
                                        : Colors.black87.withOpacity(0.7),
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
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey
                                        : Colors.black87.withOpacity(0.7),
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
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              'Friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.grey
                                        : Colors.black87.withOpacity(0.7),
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
                        child: const Text(
                          'Add Photo / Post',
                          style: TextStyle(
                            color: AppColors.defaultColor,
                          ),
                        ),
                        onPressed: () {
                          navigateTo(context: context, widget: NewPostScreen());
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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconBroken.Setting),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(AppStrings.settings),
                  ],
                ),
              ),
              if (SocialCubit.get(context).userPosts.isNotEmpty)
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Posts",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
    );
  }
}
