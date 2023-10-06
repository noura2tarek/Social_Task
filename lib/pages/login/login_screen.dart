import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/constants/constants.dart';


import '../../shared/components/components.dart';
import '../../styles/colors.dart';
import '../../layout/home_layout.dart';
import '../register/register_screen.dart';
import 'login_bloc/login_cubit.dart';
import 'login_bloc/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            CacheHelper.savaData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              uId = state.uId;
              SocialCubit.get(context).getUserData(userId: state.uId).then((value) {
                SocialCubit.get(context).getPosts().then((value) {
                  navigateAndRemove(
                    context: context,
                    widget: HomeLayout(),
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
                        Text(
                          'LOGIN',
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
                        defaultFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: 'Email Address',
                          inputBorder: OutlineInputBorder(),
                          preficon: Icons.email_outlined,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          label: 'Password',
                          inputBorder: OutlineInputBorder(),
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
                              return 'password is too short';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) {
                            return defaultButton(
                              width: double.infinity,
                              text: 'Login',
                              backgroundColor: defaultColor,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  //print(emailController.text);
                                  SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
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
                          height: 20.0,
                        ),
                        const Align(
                          child: Text('- OR -'),
                          alignment: AlignmentDirectional.center,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: OutlinedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 15.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/google.jpg'),
                                    ),
                                    const SizedBox(
                                      width: 9.0,
                                    ),
                                    Text(
                                      'Login With Goggle',
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
                              height: 10.0,
                            ),
                            Container(
                              width: double.infinity,
                              height: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: OutlinedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 14.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/facebook logo.png'),
                                    ),
                                    const SizedBox(
                                      width: 9.0,
                                    ),
                                    Text(
                                      'Login With Facebook',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                                text: 'Register',
                                function: () {
                                  navigateTo(
                                      context: context,
                                      widget: RegisterScreen());
                                })
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
      ),
    );
  }
}
