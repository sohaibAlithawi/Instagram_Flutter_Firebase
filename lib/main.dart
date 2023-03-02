import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta1/Screens/Login_Screen.dart';
import 'package:insta1/provider/user_Provider.dart';
import 'package:insta1/responsive/mobile_Screen_Layout.dart';
import 'package:insta1/responsive/responsive_screen_layout.dart';
import 'package:insta1/responsive/web_Screen_layout.dart';
import 'package:insta1/utils/costum_Colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCbfI1bxk13WGqBNU0tlyG14jCWqiuiqsw",
          appId: "1:5618219349:web:56f7ab300be5d8bba0d7dc",
          storageBucket: "insta-5b89c.appspot.com",
          messagingSenderId: "5618219349",
          projectId: "insta-5b89c"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => userProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        home: StreamBuilder(
            stream: _auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      mobileScreenLayout: Mobile_Screen_Layout(),
                      webScreenLayout: Web_Screen_layout());
                } else if (snapshot.hasError) {
                  print("No data found for user ");
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                print("No internet connection");

                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                );
              }
              return Login_Screen();
            }),
      ),
    );
  }
}
