import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/pages/chats/chat_details_screen.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/bloc/states.dart';

import '../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).usersData.isNotEmpty && SocialCubit.get(context).userModel != null,
          builder: (context) {
            //var model = SocialCubit.get(context).userModel;
            return ListView.separated(
                itemBuilder: (context, index) => buildChatItem(model: SocialCubit.get(context).usersData[index], context: context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).usersData.length,
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },


    );


  }
  Widget buildChatItem({required UserModel model, required BuildContext context}){
    return InkWell(
      onTap: () {
        navigateTo(context: context, widget: ChatDetailsScreen(receiverModel: model));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    model.image,
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    height: 1.6,
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
