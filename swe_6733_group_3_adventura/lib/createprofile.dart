import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_6733_group_3_adventura/home.dart';
import 'package:swe_6733_group_3_adventura/main.dart';

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

  // No need for these individual booleans anymore
  // bool _isMale = false;
  // bool _isFemale = false;
  // bool _isOther = false;

  // New variable to store the selected identification
  String? _selectedIdentification;

  // New list to store selected preferences
  List<String> _selectedPreferences = [];

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
                // Replace the Row of FloatingActionButtons with this:
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select identification',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedIdentification, // Set the current selected value
                  items: <String>['Male', 'Female', 'Non-Binary', 'Other']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedIdentification = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Preference (Multiple can be selected)',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select your preferences',
                    border: OutlineInputBorder(),
                  ),
                  value: null,
                  items: <String>['Male', 'Female', 'Non-Binary', 'Other']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue != null) {
                        if (_selectedPreferences.contains(newValue)) {
                          _selectedPreferences.remove(newValue);
                        } else {
                          _selectedPreferences.add(newValue);
                        }
                      }
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return <String>['Male', 'Female', 'Non-Binary', 'Other']
                        .map((String value) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _selectedPreferences.join(', '),
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      );
                    }).toList();
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    // if (_firstNameController.text.isNotEmpty &&
                    //     _lastNameController.text.isNotEmpty &&
                    //     _usernameController.text.isNotEmpty &&
                    //     _emailController.text.isNotEmpty &&
                    //     _passwordController.text.isNotEmpty &&
                    //     _selectedIdentification != null) {
                    //   db.collection('users').add({
                    //     "email": _emailController.text,
                    //     "firstname": _firstNameController.text,
                    //     "lastname": _lastNameController.text,
                    //     "password": _passwordController.text,
                    //     "username": _usernameController.text,
                    //     "identification": _selectedIdentification,
                    //     "preferences": _selectedPreferences,
                    //   });
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => CreateProfilePage(),
                    //     ),
                    //   );
                    // } 
                    // else if (_selectedIdentification == null) {
                    //   print('Please select how you identify');
                    // }
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