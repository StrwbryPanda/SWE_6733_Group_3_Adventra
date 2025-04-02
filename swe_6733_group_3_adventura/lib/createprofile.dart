import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final db = FirebaseFirestore.instance;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isMalePreferenceSelected = false;
  bool _isFemalePreferenceSelected = false;

  bool _isMale = false;
  bool _isFemale = false;

  String? _passwordError;
  String? _password;

  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  void _updateFormValidation() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateFormValidation);
    _lastNameController.addListener(_updateFormValidation);
    _usernameController.addListener(_updateFormValidation);
    _emailController.addListener(_updateFormValidation);
    _passwordController.addListener(_updateFormValidation);
    _confirmPasswordController.addListener(_updateFormValidation);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        title: Text(
          'Create Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'How do you identify?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isMale = !_isMale;
                          if (_isFemale) {_isFemale = false;}
                        });
                      },
                      foregroundColor:
                          _isMale ? Colors.white : const Color.fromARGB(255, 212, 212, 212),
                      backgroundColor:
                          _isMale ? Colors.orange : Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _isMale ? const Color.fromARGB(255, 255, 102, 0) : const Color.fromARGB(255, 212, 212, 212)
                          , width: 3),
                      ),
                      child: const Icon(Icons.male),
                    ),
                    const SizedBox(width: 40.0),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isFemale = !_isFemale;
                          if (_isMale) {_isMale = false;}
                        });
                      },
                      foregroundColor:
                          _isFemale ? Colors.white : const Color.fromARGB(255, 212, 212, 212),
                      backgroundColor:
                          _isFemale ? Colors.orange : Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _isFemale ? const Color.fromARGB(255, 255, 102, 0) : const Color.fromARGB(255, 212, 212, 212)
                          , width: 3),
                      ),
                      child: const Icon(Icons.female),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Preference',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isMalePreferenceSelected = !_isMalePreferenceSelected;
                        });
                      },
                      foregroundColor:
                          _isMalePreferenceSelected ? Colors.white : const Color.fromARGB(255, 212, 212, 212),
                      backgroundColor:
                          _isMalePreferenceSelected ? Colors.orange : Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _isMalePreferenceSelected ? const Color.fromARGB(255, 255, 102, 0) : const Color.fromARGB(255, 212, 212, 212)
                          , width: 3),
                      ),
                      child: const Icon(Icons.male),
                    ),
                    const SizedBox(width: 40.0),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isFemalePreferenceSelected = !_isFemalePreferenceSelected;
                        });
                      },
                      foregroundColor:
                          _isFemalePreferenceSelected ? Colors.white : const Color.fromARGB(255, 212, 212, 212),
                      backgroundColor:
                          _isFemalePreferenceSelected ? Colors.orange : Colors.white,
                      shape: CircleBorder(
                        side: BorderSide(
                          color: _isFemalePreferenceSelected ? const Color.fromARGB(255, 255, 102, 0) : const Color.fromARGB(255, 212, 212, 212)
                          , width: 3),
                      ),
                      child: const Icon(Icons.female),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value == 'name') {
                          // FIREBASE AUTH NEEDED
                          return 'Username already in use';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
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
                        setState(() {});
                        _updateFormValidation();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!_emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                        errorText: _passwordError,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        _updateFormValidation();
                        _password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value) ||
                            !RegExp(r'[0-9]').hasMatch(value) ||
                            !RegExp(
                              r'[!@#$%^&*(),.?":{}|<>]',
                            ).hasMatch(value)) {
                          return 'Password must contain at least one uppercase letter, one number, and one special character';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
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
                        _updateFormValidation();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter your password';
                        }
                        if (value != _password) {
                          return 'The passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   print('Sign up with email: ${_emailController.text}');
                    // }
                    if (_firstNameController.text.isNotEmpty &&
                        _lastNameController.text.isNotEmpty &&
                        _usernameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      db.collection('users').add({
                        "email": _emailController.text,
                        "firstname": _firstNameController.text,
                        "lastname": _lastNameController.text,
                        "password": _passwordController.text,
                        "username": _usernameController.text,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProfilePage(),
                        ),
                      );
                    }
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
