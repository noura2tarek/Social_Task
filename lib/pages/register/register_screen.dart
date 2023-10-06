import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/pages/register/register_bloc/register_cubit.dart';
import 'package:social_app/pages/register/register_bloc/register_states.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import '../../Styles/colors.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../layout/home_layout.dart';

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
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          //the error may occur if the user entered a used email
          if (state is SocialCreateUserSuccessState) {
            CacheHelper.savaData(
              key: 'uId',
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
                        Text(
                          'Register',
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
                        defaultFormField(
                          type: TextInputType.name,
                          controller: nameController,
                          label: 'Name',
                          inputBorder: OutlineInputBorder(),
                          preficon: Icons.person_outline,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email Address',
                          inputBorder: OutlineInputBorder(),
                          preficon: Icons.email_outlined,
                          onSubmit: (value) {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          label: 'Password',
                          inputBorder: OutlineInputBorder(),
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
                              return 'password must not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultFormField(
                          type: TextInputType.visiblePassword,
                          controller: confirmPasswordController,
                          label: 'Confirm Password',
                          inputBorder: OutlineInputBorder(),
                          preficon: Icons.lock_outline,
                          isObsecure: SocialRegisterCubit.get(context).isCheckPassword,
                          sufficon: SocialRegisterCubit.get(context).confirmIcon,
                          suffixPreesed: () {
                            SocialRegisterCubit.get(context)
                                .changeConfirmPasswordVisibility();
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "passwords don't match";
                            } else if(passwordController.text != confirmPasswordController.text){
                              return "passwords don't match";
                            } else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        defaultFormField(
                          type: TextInputType.phone,
                          controller: phoneController,
                          label: 'Phone',
                          inputBorder: OutlineInputBorder(),
                          preficon: Icons.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            } else if(value.length != 11){
                              return 'please enter valid phone number';
                            } else{
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) {
                            return defaultButton(
                              width: double.infinity,
                              text: 'Register',
                              backgroundColor: defaultColor,
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
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
