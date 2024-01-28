import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:social_app/core/controllers/login_bloc/login_cubit.dart';
import 'package:social_app/core/controllers/register_bloc/register_cubit.dart';
import 'package:social_app/core/managers/app_strings.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/screens/modules/login/login_screen.dart';
import 'package:social_app/screens/widgets/components.dart';
import 'core/controllers/bloc_observer.dart';
import 'core/controllers/bloc/cubit.dart';
import 'core/controllers/bloc/states.dart';
import 'core/controllers/visit_profile_bloc/visit_profile_cubit.dart';
import 'core/managers/values.dart';
import 'core/network/local/cache_helper.dart';
import 'core/styles/themes/theme_data_dark.dart';
import 'core/styles/themes/theme_data_light.dart';

// //Handle background message (the app is closed or the app is running in the background)
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   showToast(message: "Background message", state: ToastStates.SUCCESS);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize firebase
  await Firebase.initializeApp();

  //check internet
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    return;
  } else {
    showToast(message: AppStrings.checkInternet, state: ToastStates.NOTIFY);
  }

  //-------------------------//
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
// // use the returned token to send messages to users from your custom server
//   String? token = await messaging.getToken();
//   print('token is $token');
//   //token is c0tM5SrMRcqXZPJJafAGoN:APA91bEYitQWQL4XumxyXXb4zJsCmMIWMhEx4dRShuXzVfLr6gvnDG2Z2awqYu9ny0k1Gz-hkTdINwocJdE_59bbjJuP9z7eyIpy05ZNynTjZDShE5wWLHlkt6AuB9itHlgNdfKEcDXM
//
//   // Handle foreground messages (notification)
//   //To listen to messages while your application is in the foreground (you are opening the application)
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Got a message in the foreground!');
//     print('Message data: ${message.data}');
//     showToast(message: "on message", state: ToastStates.SUCCESS);
//     // if (message.notification != null) {
//     //   print('Message also contained a notification: ${message.notification.toString()}');
//     // }
//   });

  // //Handle a message when the user clicked on the notification  (the app is running in the background)
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   print('On MessageOpened App!');
  //   print('Message data: ${message.data}');
  //   showToast(message: "On message opened app", state: ToastStates.SUCCESS);
  //   // if (message.notification != null) {
  //   //   print('Message also contained a notification: ${message.notification.toString()}');
  //   // }
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  if (CacheHelper.checkData(key: AppStrings.userIdKey)) {
    uId = CacheHelper.getData(key: AppStrings.userIdKey) as String;
  } else {
    uId = null;
  }

  if (CacheHelper.checkData(key: AppStrings.savedCurrentIndexKey)) {
    savedCurrentIndex =
        CacheHelper.getData(key: AppStrings.savedCurrentIndexKey) as int;
  }

  bool? isDarkTheme = CacheHelper.getBoolean(key: AppStrings.isDarkKey);

  if (uId != null) {
    startingWidget = HomeLayout();
  } else {
    startingWidget = LoginScreen();
  }

  runApp(MyApp(
    isDarkk: isDarkTheme,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDarkk;

  const MyApp({super.key, required this.isDarkk});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()
            ..setMode(fromShared: isDarkk)
            ..getUserData(userId: uId)
            ..getPosts()
            ..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => VisitCubit(),
        ),
        BlocProvider(
          create: (context) => SocialLoginCubit(),
        ),
        BlocProvider(
          create: (context) => SocialRegisterCubit(),
        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: startingWidget,
          );
        },
      ),
    );
  }
}
