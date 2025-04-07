import 'package:flutter/material.dart';
import 'package:swe_6733_group_3_adventura/home.dart';
import 'createaccount.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'createprofile.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: const MyHomePage(title: 'Adventra'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 255, 230, 86),
              const Color.fromARGB(255, 209, 112, 0),
            ],
          ),
        ),
        child: Form( // Wrap Column with Form
          key: _formKey,
          child: Column(
            children: <Widget>[
              Align(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: Text(
                      'Adventra',
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 102, 0),
                          width: 2.5,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      _username = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 255, 102, 0),
                          width: 2.5,
                        ),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 50),
              FractionallySizedBox(
                widthFactor: 0.3,
                child: ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                          //Query the firestore with username and password
                          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                          .collection('users')
                          .where('username', isEqualTo: _username)
                          .where('password', isEqualTo: _password)
                          .get();

                          if(querySnapshot.docs.isNotEmpty){
                            //Login if found
                            Navigator.push(context, MaterialPageRoute(builder :(context) => HomePage(),));
                          }
                          else{
                            //Show error message if not found
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid username or password')));
                          }
                    }
                    // if (_formKey.currentState!.validate()) {
                    //   if (_username != 'name' || _password != '123') { // FIREBASE AUTH REQUIRED
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(content: Text('Invalid username or password')),
                    //     );
                    //     _formKey.currentState!.validate();
                    //   } else {
                    //     print('Success');
                    //   }
                    // }
                  },
                  child: Text('Sign in'),
                ),
              ),
              SizedBox(height: 20),
              FractionallySizedBox(
                widthFactor: 0.3,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAccountPage(),
                      ),
                    );
                  },
                  child: Text('Create an Account'),
                ),
              ),
              SizedBox(height: 20),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  child: Text('Jump to Home >'),
                ),
              ),
              SizedBox(height: 20),
              Align(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfilePage(),
                      ),
                    );
                  },
                  child: Text('Jump to Create Profile >'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}