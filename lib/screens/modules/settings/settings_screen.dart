import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/bloc/states.dart';
import '../../../core/managers/app_strings.dart';
import '../../../core/managers/values.dart';
import '../../../core/styles/colors.dart';
import '../../../core/styles/icon_broken.dart';
import '../../widgets/default_app_bar.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
   const SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context, title: AppStrings.settings),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 200.0,
                  ),

                  /********      change mode and language button    **********/
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      padding: const EdgeInsetsDirectional.symmetric(vertical: 15.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDark? Colors.white38 : Colors.grey[700]!,
                        ),
                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(15.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /********      change mode button    **********/
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.brightness_2_outlined,
                                size: 24.0,
                                color: isDark? Colors.grey[350] :Colors.black87, //change color here according the theme
                              ),
                              const SizedBox(width: 7.0),
                              Text(
                                AppStrings.darkMod,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: isDark? Colors.grey[350] :Colors.black87, // change color here according to theme mode
                                ),
                              ),
                              const Spacer(),
                              Switch(
                                activeColor: AppColors.defaultColor,
                                splashRadius: 6.0,
                                value: isDark,
                                onChanged: (bool value) {
                                  SocialCubit.get(context).changeMode();
                                },
                              ),
                            ],
                          ),
                          /********      change language button    **********/
                          InkWell(
                            onTap: (){},
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(end: 10.0, top: 10.0, bottom: 10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language_outlined,
                                    size: 24.0,
                                    color: isDark? Colors.grey[350] :Colors.black87, //change color here according to theme
                                  ),
                                  const SizedBox(width: 7.0),
                                  Text(
                                    AppStrings.language,
                                    style: TextStyle(
                                      color:  isDark? Colors.grey[350] :Colors.black87,
                                      // change color here according to theme mode
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
                  ),

                  /********      log out button    **********/
                  InkWell(
                    onTap: (){
                      SocialCubit.get(context)
                          .logOut(context: context, widget: LoginScreen());
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Logout,
                            size: 24.0,
                            color:  isDark? Colors.grey[350] :Colors.black87, //change color here according to theme
                          ),
                          const SizedBox(width: 7.0),
                          Text(
                            AppStrings.logOut,
                            style: TextStyle(
                              color: isDark? Colors.grey[350] :Colors.black87,
                              // cange color here according to theme mode
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
          ),
        );
      },

    );
  }
}
