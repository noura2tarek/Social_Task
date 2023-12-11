import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/bloc/states.dart';
import '../../../core/managers/app_strings.dart';
import '../../../core/managers/values.dart';
import '../../../core/styles/icon_broken.dart';
import '../../widgets/build_post_item.dart';
import '../../widgets/default_text_button.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialGetPostsSuccessState) {}
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var model = SocialCubit.get(context).userModel;
        var posts = SocialCubit.get(context).posts;
        return ConditionalBuilder(
          condition: posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ////////    Verify Email Button  //////////
                  if (!(model!.isEmailVerified!))
                    Container(
                      height: 45.0,
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        //borderRadius: const BorderRadiusDirectional.all(Radius.circular(7.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(IconBroken.Info_Circle),
                          const SizedBox(width: 12.0),
                          Expanded(
                              child: Text(
                            AppStrings.pleaseVerifyEmail,
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                          DefaultTextButton(
                            text: AppStrings.verifyEmail,
                            function: () {
                              cubit.verifyEmail();
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  /////////////***   Posts List  ***//////////////
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildPostItem(
                          context: context, model: posts[index], index: index);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 9.0,
                    ),
                    itemCount: posts.length,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) {
            if (state is SocialGetPostsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    color: isDark ? Colors.grey[400] : Colors.black45,
                    //black 45 for light theme , grey[400] for dark
                    size: 100.0,
                  ),
                  Text(
                    AppStrings.noPostsYet,
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.black45,
                      //change color here according to theme mode
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
