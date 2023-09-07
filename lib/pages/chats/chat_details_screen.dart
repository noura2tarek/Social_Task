import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Styles/colors.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/bloc/states.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel? receiverModel;
  final messageController = TextEditingController();

  ChatDetailsScreen({Key? key, required this.receiverModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: receiverModel!.uId);

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (BuildContext context, SocialStates state) {},
          builder: (BuildContext context, SocialStates state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        receiverModel!.image,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        receiverModel!.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz_sharp,
                      size: 22.0,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty && receiverModel != null,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              var message = SocialCubit.get(context).messages[index];
                              if(message.senderId  == SocialCubit.get(context).userModel?.uId){
                                return buildMyMessage(message);
                              } else{
                                return buildMessageItem(message);
                              }

                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(20.0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    controller: messageController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Write a message...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: receiverModel!.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                },
                                icon: Icon(
                                  IconBroken.Send,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessageItem(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.grey[600],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          messageModel.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildMyMessage(MessageModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: defaultColor.withOpacity(0.7),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsetsDirectional.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
