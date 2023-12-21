import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/managers/app_strings.dart';
import 'package:social_app/screens/widgets/default_text_button.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/register_bloc/register_cubit.dart';
import '../../../core/controllers/register_bloc/register_states.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/styles/colors.dart';
import '../../../layout/home_layout.dart';
import '../../widgets/components.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_form_field.dart';
import '../login/login_screen.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
      listener: (context, state) {
        //the error may occur if the user entered a used email
        if (state is SocialCreateUserSuccessState) {
          CacheHelper.savaData(
            key: AppStrings.userIdKey,
            value: state.userId,
          ).then((value) {
            SocialCubit.get(context).getUserData(userId: state.userId).then((value) {
              SocialCubit.get(context).getPosts().then((value) {
                navigateAndRemove(
                  context: context,
                  widget: HomeLayout(),
                );
              });
            });
          });


        }else if (state is SocialRegisterErrorState) {
          showToast(
            message: state.error,
            state: ToastStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(context: context),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///////////// Title of page ////////////
                      Text(
                        AppStrings.register,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),

                      ///////////////****** Text Form Fields *****////////////
                      DefaultFormField(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.name,
                        controller: nameController,
                        label: AppStrings.name,
                        preficon: Icons.person_outline,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterName;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      DefaultFormField(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        label: AppStrings.emailAddress,
                        preficon: Icons.email_outlined,
                        onSubmit: (value) {},
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterEmail;
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 24.0,
                      ),
                      DefaultFormField(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        label: AppStrings.password,
                        preficon: Icons.lock_outline,
                        isObsecure:
                            SocialRegisterCubit.get(context).isPassword,
                        sufficon: SocialRegisterCubit.get(context).icon,
                        suffixPreesed: () {
                          SocialRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.emptyPassword;
                          } else {
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 24.0,
                      ),

                      DefaultFormField(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                        label: AppStrings.confirmPassword,
                        preficon: Icons.lock_outline,
                        isObsecure: SocialRegisterCubit.get(context).isCheckPassword,
                        sufficon: SocialRegisterCubit.get(context).confirmIcon,
                        suffixPreesed: () {
                          SocialRegisterCubit.get(context)
                              .changeConfirmPasswordVisibility();
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.passwordMatch;
                          } else if(passwordController.text != confirmPasswordController.text){
                            return AppStrings.passwordMatch;
                          } else{
                            return null;
                          }
                        },
                      ),

                      const SizedBox(
                        height: 24.0,
                      ),

                      DefaultFormField(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        type: TextInputType.phone,
                        controller: phoneController,
                        label: AppStrings.phone,
                        preficon: Icons.phone,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return AppStrings.enterPhone;
                          } else if(value.length != 11){
                            return AppStrings.validPhone;
                          } else{
                            return null;
                          }
                        },
                      ),
                      ///////////////****** End of Text Form Fields *****////////////

                      const SizedBox(
                        height: 30.0,
                      ),

                      ////////////*** Register Button ***///////////////
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) {
                          return DefaultButton(
                            text: AppStrings.register,
                            backgroundColor: AppColors.defaultColor,
                            isUpperCase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          );
                        },
                        fallback: (context) {
                          return  Container(
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
                                backgroundColor:AppColors.defaultColor,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 10.0,
                      ),

                      /////////****  Login Button if have account ***/////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(AppStrings.haveAccount, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),),
                          DefaultTextButton(
                            function: () {
                              navigateAndRemove(context: context,widget: LoginScreen());
                            },
                            text: AppStrings.login,
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
