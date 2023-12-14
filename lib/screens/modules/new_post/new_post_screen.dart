import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/bloc/states.dart';
import '../../../core/managers/app_strings.dart';
import '../../../core/managers/values.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/icon_broken.dart';
import '../../../models/user_model.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_text_button.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserModel? userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        var now = DateTime.now();
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              DefaultTextButton(
                  text: AppStrings.post,
                  function: () {
                    if (cubit.postImage == null) {
                      cubit
                          .createPost(
                              text: textController.text,
                              dateTime: now.toString())
                          .then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      cubit
                          .uploadPostImage(
                              text: textController.text,
                              dateTime: now.toString())
                          .then((value) {
                        Navigator.pop(context);
                      });
                    }
                  }),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 15.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26.0,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 60.0,
                          width: 60.0,
                          imageUrl: userModel!.image!,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[300]),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.name!,
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.6,
                        color: isDark
                            ? Colors.white
                            : Colors
                                .black, //change color here according to theme mode
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind...',
                      hintStyle:
                          Theme.of(context).inputDecorationTheme.hintStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 180.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(cubit.postImage!),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                        child: CircleAvatar(
                          backgroundColor: AppColors.defaultColor,
                          radius: 17.0,
                          child: IconButton(
                            onPressed: () {
                              cubit.removePostImage();
                            },
                            splashRadius: 21.0,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: DefaultTextButton(text: '#tags', function: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
