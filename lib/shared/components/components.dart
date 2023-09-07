import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../styles/colors.dart';

void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return widget;
  }));
}

void navigateAndRemove({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) {
      return false;
    },
  );
}

Widget defaultButton({
  required double width,
  double height = 40.0,
  required Color backgroundColor,
  bool isUpperCase = true,
  double radius = 6.0,
  required String text,
  required Function function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required String text,
  required void Function()? function,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: defaultColor,
          ),
        ));

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title ?? ''),
    leading: IconButton(
      icon: Icon(
        IconBroken.Arrow___Left_2,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: actions,
  );
}

Widget defaultFormField({
  required TextInputType type,
  required TextEditingController controller,
  String? label,
  String? hint,
  IconData? preficon,
  IconData? sufficon,
  String? Function(String?)? validator,
  InputBorder? inputBorder,
  Color? fillColor,
  Color? labelColor,
  Color? hintColor,
  Color? cursorColor,
  double? cursorHeight,
  Color? prefixColor,
  double? prefixIconSize,
  void Function()? suffixPreesed,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  TextStyle? style,
  bool isObsecure = false,
  void Function()? onTab,
}) =>
    TextFormField(
      style: style,
      keyboardType: type,
      controller: controller,
      validator: validator,
      obscureText: isObsecure,
      cursorColor: cursorColor,
      cursorHeight: cursorHeight,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        fillColor: fillColor,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        border: inputBorder,
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
        ),
        prefixIcon: Icon(
          preficon,
          color: prefixColor,
          size: prefixIconSize,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            sufficon,
          ),
          onPressed: suffixPreesed,
        ),
      ),
      onTap: onTab,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
    );

void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStates { SUCCESS, WAENING, ERROR, NOTIFY }

Color chooseToastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WAENING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.NOTIFY:
      color = Colors.grey;
      break;
  }
  return color;
}

Widget myDivider() {
  return  Divider(
    height: 1.0,
    indent: 15.0,
    endIndent: 15.0,
    color: Colors.grey[350],
  );
}

Widget buildProductList(model, BuildContext context, {bool isSearch = false}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.image,
                ),
                width: 120.0,
                height: 120.0,
              ),
              if ((isSearch = false) && model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.yellow,
                  child: Text(
                    '${model.discount}% DISCOUNT',
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if ((isSearch = false) && model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        //SocialCubit.get(context).changeFavorites(productId: model.id);
                      },
                      tooltip: 'Delete from favourites',
                      icon: CircleAvatar(
                        // backgroundColor: SocialCubit.get(context).favouritesProductsId.contains(model.id)? Colors.blue : Colors.grey ,
                        radius: 15.0,
                        child: Icon(
                          Icons.favorite_border,
                          size: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
