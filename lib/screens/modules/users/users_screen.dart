import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/screens/widgets/default_divider.dart';
import '../../../core/controllers/bloc/cubit.dart';
import '../../../core/controllers/bloc/states.dart';
import '../../../core/managers/values.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).usersData.isNotEmpty &&
              SocialCubit.get(context).userModel != null,
          builder: (context) {
            return ListView.separated(
              itemBuilder: (context, index) => buildUserItem(
                model: SocialCubit.get(context).usersData[index],
                context: context,
              ),
              separatorBuilder: (context, index) => DefaultDivider(),
              itemCount: SocialCubit.get(context).usersData.length,
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildUserItem(
      {required UserModel model, required BuildContext context}) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[600] : Colors.grey[200],
            //200 for light and grey[500] for dark
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(8.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26.0,
                  child: ClipOval(
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: model.image!,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[300]),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Text(
                    model.name!, // model.name!
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.6,
                      color: isDark
                          ? Colors.white.withOpacity(0.9)
                          : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
