import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/bloc/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverPickedImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        phoneController.text = userModel.phone;
        bool? isEmailVerified =
            FirebaseAuth.instance.currentUser?.emailVerified;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit',
            actions: [
              defaultTextButton(
                  text: 'Update',
                  function: () {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                      isEmailVerified: isEmailVerified!,
                    );
                  }),
              const SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
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
                                          userModel.coverImage,
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
                                  backgroundColor: Colors.grey[350],
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
                                        userModel.image,
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
                                  backgroundColor: Colors.grey[350],
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
                        child: Text(
                          'Name:',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 19.0,
                                  ),
                        ),
                        width: 75.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 56.0,
                          child: defaultFormField(
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            ),
                            type: TextInputType.text,
                            controller: nameController,
                            preficon: IconBroken.Profile,
                            inputBorder: OutlineInputBorder(),
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
                                    fontSize: 19.0,
                                  ),
                        ),
                        width: 75.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 56.0,
                          child: defaultFormField(
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                            ),
                            type: TextInputType.text,
                            preficon: IconBroken.Info_Circle,
                            controller: bioController,
                            inputBorder: OutlineInputBorder(),
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
                                    fontSize: 19.0,
                                  ),
                        ),
                        width: 75.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 56.0,
                          child: defaultFormField(
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                            ),
                            type: TextInputType.phone,
                            preficon: IconBroken.Call,
                            controller: phoneController,
                            inputBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
