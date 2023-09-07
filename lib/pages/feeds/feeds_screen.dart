import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/bloc/states.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
   FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if(!(model!.isEmailVerified))  Container(
                      height: 45.0,
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        //borderRadius: const BorderRadiusDirectional.all(Radius.circular(7.0)),
                      ),

                      child: Row(
                        children: [
                          const Icon(IconBroken.Info_Circle),
                          const SizedBox(width: 12.0),
                          Expanded(child: Text('Please Verify Your Email', style: Theme.of(context).textTheme.titleMedium,)),
                          defaultTextButton(
                            text: 'verify email',
                            function: (){
                              cubit.verifyEmail();
                            },
                          ),
                        ],
                      ),
                    ),

                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsetsDirectional.only(bottom: 8.0,top: 1.0),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          width: double.infinity,
                          height: 180.0,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),  // same style as subtitle1
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(context: context, model: cubit.posts[index], index: index);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) =>  const Center(child: CircularProgressIndicator()),

        );

      },
    );
  }

  Widget buildPostItem({required PostModel model, required BuildContext context, required int index}) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4.0,
        margin: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.0,
                    backgroundImage: NetworkImage(
                      model.image
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
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              height: 1.6,
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
                    ),
                  ),
                ],
              ),
              //  Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 3.0),
              //   child: Divider(color: Colors.grey[350],),
              // ),
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
              if(model.postImage != '')
               Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadiusDirectional.all(Radius.circular(5.0)),
                    image: DecorationImage(
                      image: NetworkImage(
                        model.postImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
               const SizedBox(height: 15.0,),//image of post
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
                              Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                                size: 18.0,
                              ),
                              SizedBox(width: 4.0),
                              Expanded(
                                child: Text(
                                  '${SocialCubit.get(context).postsLikes[index]}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 13.0,
                                      ),
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
                            SizedBox(width: 4.0),
                            Text('0 comments',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 13.0,
                                    )), // caption style replaced by bodySmall
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: CircleAvatar(
                                radius: 1.6,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            Text(
                              '0 shares',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 13.0,
                                  ),
                            ), // caption style replaced by bodySmall
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ), // InkWell of Row of likes, comments, and shares
               Divider(color: Colors.grey[350],),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.0,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).userModel!.image,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Write a comment...',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 13.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(postId: SocialCubit.get(context).postsIds[index],index: index, userID:SocialCubit.get(context).userModel!.uId )
                          .then((value) {

                        //SocialCubit.get(context).postsLikes[index] += 1;
                      });

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text('Like',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 13.0,
                                color: Colors.black,
                                  )), // caption style replaced by bodySmall
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
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Upload,
                            color: Colors.green,
                            size: 18.0,
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            'Share',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 13.0,
                                  ),
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
}
