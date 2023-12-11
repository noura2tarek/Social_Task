import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/managers/app_strings.dart';
import '../../core/controllers/bloc/cubit.dart';
import '../../core/controllers/visit_profile_bloc/visit_profile_cubit.dart';
import '../../core/managers/values.dart';
import '../../core/styles/colors.dart';
import '../../core/styles/icon_broken.dart';
import '../../models/post_model.dart';

import '../modules/visit_profile/visit_profile_screen.dart';
import 'components.dart';

Widget buildPostItem({
  required PostModel model,
  required BuildContext context,
  required int index,
}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  VisitCubit.get(context)
                      .getUserVisitData(userId: model.uId)
                      .then((value) {
                    navigateTo(context: context, widget: VisitProfileScreen());
                  });
                },
                child: CircleAvatar(
                  radius: 22.0,
                  child: ClipOval(
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: model.image,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        model.name,
                        style: TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                          color: isDark
                              ? Colors.white
                              : Colors
                                  .black, // change color here according to theme mode.
                        ),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.defaultColor,
                        size: 16.0,
                      ),
                    ],
                  ),
                  Text(
                    model.dateTime,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          //change color here according to theme
                          height: 1.5,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz_sharp,
                  size: 22.0,
                  color: isDark
                      ? Colors.grey[350]
                      : Colors
                          .black, // change color here according to theme mode
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: Text(
              model.text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          //the tags below

          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsetsDirectional.only(top: 5.0, bottom: 10.0),
          //   child: Wrap(
          //     children: [
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#software'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#flutter'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#mobile_development'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //       Container(
          //         child: MaterialButton(
          //           onPressed: () {},
          //           minWidth: 1.2,
          //           textColor: Colors.blue,
          //           padding: EdgeInsets.zero,
          //           child: Text('#software_development'),
          //         ),
          //         height: 25.0,
          //         padding: EdgeInsetsDirectional.only(end: 5.0),
          //       ),
          //     ],
          //   ),
          // ), //wrap of hashtags
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(5.0)),
                ),
                child: CachedNetworkImage(
                  imageUrl: model.postImage,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[300]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          const SizedBox(
            height: 15.0,
          ),
          //image of post
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                            size: 18.0,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              '${SocialCubit.get(context).postsLikes[index]}',
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ), // caption style replaced by bodySmall
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 18.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '0 comments',
                          style: Theme.of(context).textTheme.bodySmall,
                        ), // caption style replaced by bodySmall
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: CircleAvatar(
                            radius: 1.6,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Text(
                          '0 shares',
                          style: Theme.of(context).textTheme.bodySmall,
                        ), // caption style replaced by bodySmall
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // InkWell of Row of likes, comments, and shares
          Divider(
            color: Theme.of(context).dividerTheme.color,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 16.0,
                          child: ClipOval(
                            child: Container(
                              child: CachedNetworkImage(
                                imageUrl: model.image,
                                placeholder: (context, url) =>
                                    Container(color: Colors.grey[300]),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'Write a comment...',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(context).likePost(
                      postId: SocialCubit.get(context).postsIds[index],
                      index: index,
                      userID: SocialCubit.get(context).userModel!.uId!);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                        size: 18.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        AppStrings.like,
                        style: Theme.of(context).textTheme.bodySmall,
                      ), // caption style replaced by bodySmall
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 17.0,
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Upload,
                        color: Colors.green,
                        size: 18.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Share',
                        style: Theme.of(context).textTheme.bodySmall,
                      ), // caption style replaced by bodySmall
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
