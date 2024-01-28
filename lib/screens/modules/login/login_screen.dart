import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/managers/app_strings.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/login_bloc/login_cubit.dart';
import '../../../core/controllers/login_bloc/login_states.dart';
import '../../../core/managers/images_path.dart';
import '../../../core/managers/values.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/styles/colors.dart';
import '../../../layout/home_layout.dart';
import '../../widgets/components.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_form_field.dart';
import '../../widgets/default_text_button.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (context, state) {
        if (state is SocialLoginSuccessState) {
          CacheHelper.savaData(
            key: AppStrings.userIdKey,
            value: state.uId,
          ).then((value) {
            uId = state.uId;
            SocialCubit.get(context)
                .getUserData(userId: state.uId)
                .then((value) {
              SocialCubit.get(context).getPosts().then((value) {
                navigateAndRemove(
                  context: context,
                  widget: const HomeLayout(),
                );
              });
            });
          });
        } else if (state is SocialLoginErrorState) {
          showToast(
            message: state.error,
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(27.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///////////// Title of page ////////////
                      Text(
                        AppStrings.login.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Jannah',
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      //////////////****** Text Form Fields *****//////////////

                      DefaultFormField(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        label: AppStrings.emailAddress,
                        preficon: Icons.email_outlined,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterEmail;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      DefaultFormField(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        label: AppStrings.password,
                        preficon: Icons.lock_outline,
                        isObsecure: SocialLoginCubit.get(context).isPassword,
                        sufficon: SocialLoginCubit.get(context).icon,
                        suffixPreesed: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          SocialLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emptyPassword;
                          } else {
                            return null;
                          }
                        },
                      ),

                      ///////////////****** End of Text Form Fields *****////////////

                      const SizedBox(
                        height: 30.0,
                      ),

                      /////////////***  Login Button ***//////////////
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) {
                          return DefaultButton(
                            text: AppStrings.login,
                            backgroundColor: AppColors.defaultColor,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          );
                        },
                        fallback: (context) {
                          return Container(
                            width: double.infinity,
                            height: 42.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              color: AppColors.defaultColor,
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: AppColors.defaultColor,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Align(
                        alignment: AlignmentDirectional.center,
                        child: Text('- OR -'),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      /////////////***  Login with google Button ***//////////////
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: OutlinedButton(
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 15.0,
                                backgroundImage:
                                    AssetImage(AppImages.googleImagePath),
                              ),
                              SizedBox(
                                width: 9.0,
                              ),
                              Text(
                                AppStrings.loginWithGoggle,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ////////*** Register Button if the user have not account ****/////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.dontHaveAccount,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.normal),
                          ),
                          DefaultTextButton(
                            text: AppStrings.register,
                            function: () {
                              navigateTo(
                                  context: context, widget: RegisterScreen());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
