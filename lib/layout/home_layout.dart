import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/managers/app_strings.dart';
import '../core/controllers/bloc/cubit.dart';
import '../core/controllers/bloc/states.dart';
import '../core/managers/lists.dart';
import '../core/managers/values.dart';
import '../core/styles/icon_broken.dart';
import '../screens/modules/new_post/new_post_screen.dart';
import '../screens/widgets/components.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetUserErrorState) {
          showToast(
              message: AppStrings.checkInternet,
              state: ToastStates.NOTIFY);
        }
        if(state is SocialAddPostState){
          navigateTo(context: context, widget: NewPostScreen());
        }

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(screensTitles[savedCurrentIndex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: screens[savedCurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: savedCurrentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: AppStrings.home,
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: AppStrings.postc,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: AppStrings.usersc,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Profile
                ),
                label: AppStrings.profile,
              ),
            ],
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
          ),
        );
      },
    );
  }
}

