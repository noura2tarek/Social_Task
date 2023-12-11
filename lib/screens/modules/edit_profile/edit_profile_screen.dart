import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/bloc/states.dart';
import '../../../core/managers/values.dart';
import '../../../core/styles/icon_broken.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_form_field.dart';
import '../../widgets/default_text_button.dart';


class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverPickedImage = SocialCubit.get(context).coverImage;

          nameController.text = (userModel?.name) ?? '';
          bioController.text = (userModel?.bio) ?? '';
          phoneController.text = (userModel?.phone) ?? '';
          emailController.text = (userModel?.email) ?? '';

        // bool? isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit',
            actions: [
              DefaultTextButton(
                  text: 'Update',
                  function: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                      isEmailVerified: userModel!.isEmailVerified!,
                      email: emailController.text,
                    );
                  }),
              const SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: (userModel) != null,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is SocialUpdateUserDataLoadingState)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: LinearProgressIndicator(),
                      ),
                    Container(
                      height: 220.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: coverPickedImage == null
                                          ? NetworkImage(
                                        userModel!.coverImage!,
                                      )
                                          : FileImage(coverPickedImage)
                                      as ImageProvider,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 8.0),
                                  child: CircleAvatar(
                                    radius: 19.0,
                                    backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      backgroundColor: isDark? Colors.grey[400] :Colors.grey[350], //change color here according to theme mode
                                      radius: 17.0,
                                      child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context).getCoverImage();
                                        },
                                        splashRadius: 21.0,
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 61.0,
                                  backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 58.0,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage(
                                      userModel!.image!,
                                    )
                                        : FileImage(profileImage) as ImageProvider,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 0.0, right: 0.0),
                                  child: CircleAvatar(
                                    radius: 19.0,
                                    backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 17.0,
                                      backgroundColor: isDark? Colors.grey[400] :Colors.grey[350], //change color here according to theme mode
                                      child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getProfileImage();
                                        },
                                        splashRadius: 20.0,
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.black,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 75.0,
                            child: Text(
                              'Name:',
                              style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 18.0,
                                color: isDark? Colors.white :Colors.black, // change color here according to theme mode
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 56.0,
                              child: DefaultFormField(
                                style: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
                                  fontSize: 15.0,
                                ),
                                type: TextInputType.text,
                                controller: nameController,
                                preficon: IconBroken.Profile,
                                hint: 'Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Bio:',
                              style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 18.0,
                                color: isDark? Colors.white :Colors.black, // change color here according to theme mode
                              ),
                            ),
                            width: 75.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 56.0,
                              child: DefaultFormField(
                                style: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                type: TextInputType.text,
                                preficon: IconBroken.Info_Circle,
                                controller: bioController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Phone:',
                              style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 18.0,
                                color: isDark? Colors.white :Colors.black, // change color here according to theme mode
                              ),
                            ),
                            width: 75.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 56.0,
                              child: DefaultFormField(
                                style: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                type: TextInputType.phone,
                                preficon: IconBroken.Call,
                                controller: phoneController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, left: 20.0, right: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 75.0,
                            child: Text(
                              'Email:',
                              style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 18.0,
                                color: isDark? Colors.white :Colors.black, // change color here according to theme mode
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 56.0,
                              child: TextFormField(
                                controller: emailController,
                                style: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              );
            },
           fallback: (context) {
             return Container();
           },
          ),
        );
      },
    );
  }
}
