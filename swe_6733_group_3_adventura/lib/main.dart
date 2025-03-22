import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'createaccount.dart';
import 'package:swe_6733_group_3_adventura/createaccount.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventra',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const MyHomePage(title: 'Adventra'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Controller for text inputs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
    child: Column(
      children: [
        Container(
          width: 1280,
          height: 832,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 394,
                top: 70,
                child: SizedBox(
                  width: 504,
                  height: 78,
                  child: Text(
                    'Adventra',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 64,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 393,
                top: 543,
                child: Container(
                  width: 247,
                  height: 68,
                  decoration: BoxDecoration(color: const Color(0xFFD9D9D9)),
                ),
              ),
              Positioned(
                left: 484,
                top: 563,
                child: SizedBox(
                  width: 65,
                  height: 29,
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 698,
                top: 543,
                child: Container(
                  width: 247,
                  height: 68,
                  decoration: BoxDecoration(color: const Color(0xFFD9D9D9)),
                ),
              ),
              Positioned(
                left: 729,
                top: 563,
                //Makes button able to be tapped by using GestureDetector for Create Account Page
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccountPage()),
                    );
                  },
                  child: Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 252,
                //Code to make TextField for E-Mail input
                child: SizedBox(
                  width: 667,
                  height: 60,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                      border: OutlineInputBorder(),
                      hintText: 'example@email.com',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 208,
                child: Text(
                  'E-Mail',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 356,
                //TextField for password input               
                child: SizedBox(
                  width: 667,
                  height: 60,
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 312,
                top: 312,
                child: Text(
                  'Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    ),
    );
  }

}
