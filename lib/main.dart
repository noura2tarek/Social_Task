import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home_layout.dart';
import 'package:social_app/pages/login/login_screen.dart';
import 'package:social_app/shared/bloc/cubit.dart';
import 'package:social_app/shared/bloc/states.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/styles/themes.dart';
import 'network/local/cache_helper.dart';

//Handle background message (the app is closed or the app is running in the background)
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  showToast(message: "Background message", state:ToastStates.SUCCESS);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

// use the returned token to send messages to users from your custom server
  String? token = await messaging.getToken();
  print('token is $token');
  //token is c0tM5SrMRcqXZPJJafAGoN:APA91bEYitQWQL4XumxyXXb4zJsCmMIWMhEx4dRShuXzVfLr6gvnDG2Z2awqYu9ny0k1Gz-hkTdINwocJdE_59bbjJuP9z7eyIpy05ZNynTjZDShE5wWLHlkt6AuB9itHlgNdfKEcDXM

  // Handle foreground messages (notification)
  //To listen to messages while your application is in the foreground (you are opening the application)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message in the foreground!');
    print('Message data: ${message.data}');
    showToast(message: "on message", state:ToastStates.SUCCESS);
    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification.toString()}');
    // }

  });

  //Handle a message when the user clicked on the notification  (the app is running in the background)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('On MessageOpened App!');
    print('Message data: ${message.data}');
    showToast(message: "On message opened app", state:ToastStates.SUCCESS);
    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification.toString()}');
    // }

  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId') as String?;
  Widget widget;

  if(uId != null){
    widget = HomeLayout();
  } else{
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
   final Widget startWidget;
   MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getPosts()..getUserData(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            //title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home:  startWidget,
          );
        },
      ),
    );
  }
}


