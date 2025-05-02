import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swe_6733_group_3_adventura/home.dart';
import 'package:swe_6733_group_3_adventura/main.dart';

enum Filter {
  Walking,
  Running,
  Cycling,
  Hiking,
  Swimming,
  Climbing,
  Skiing,
  Snowboarding,
  Surfing,
  Skating,
}

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
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedIdentification;
  List<String> _selectedPreferences = [];
  String? _passwordError;
  String? _password;
  final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // For the filter and distance code
  Set<Filter> filters = <Filter>{};
  double _currentRadius = 50; // Default radius

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
    _bioController.addListener(_updateFormValidation);
    _locationController.addListener(_updateFormValidation);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        title: const Text(
          'Create Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity, // Added to take full width
        height: double.infinity, // Added to take full height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 255, 230, 86),
              Color.fromARGB(255, 209, 112, 0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Give us some info about yourself',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Select identification',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedIdentification,
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
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
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
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _bioController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Current Location (e.g., City, State)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Activities',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Wrap(
                    spacing: 8.0,
                    children: Filter.values.map((Filter activity) {
                      return FilterChip(
                        padding: const EdgeInsets.all(8.0),
                        selectedColor:
                            const Color.fromARGB(255, 255, 115, 0),
                        label: Text(activity.name),
                        selected: filters.contains(activity),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              filters.add(activity);
                            } else {
                              filters.remove(activity);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20.0),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Search Radius',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Slider(
                    value: _currentRadius,
                    activeColor: const Color.fromARGB(255, 255, 115, 0),
                    max: 200,
                    onChanged: (double value) {
                      setState(() {
                        _currentRadius = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Radius: ${_currentRadius.toStringAsFixed(0)} miles',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);

                        if (_firstNameController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _usernameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _selectedIdentification != null) {
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
                              builder: (context) => const CreateProfilePage(),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}