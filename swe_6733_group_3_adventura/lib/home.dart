import 'package:flutter/material.dart';
import 'package:swe_6733_group_3_adventura/main.dart';
import 'dart:math';

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

enum SwipeDirection { none, left, right }

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const HomePage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: ProfileSwipePage(userData: userData),
    );
  }
}

class ProfileSwipePage extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const ProfileSwipePage({super.key, this.userData});

  @override
  State<ProfileSwipePage> createState() => _ProfileSwipePageState();
}

class _ProfileSwipePageState extends State<ProfileSwipePage>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 0;
  Set<Filter> filters = <Filter>{};
  double _currentRadius = 20.0;
  int _currentProfileIndex = 0;
  bool _isSwiping = false; // Track if a swipe animation is in progress

  late AnimationController _swipeController;
  late Animation<Offset> _swipeAnimation;
  Offset _dragStartOffset = Offset.zero;
  Offset _dragCurrentOffset = Offset.zero;
  bool _isDragging = false;
  double _dragStartX = 0.0;

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

  final List<Map<String, dynamic>> _profiles = [
    {
      'name': 'Jessica',
      'photoUrl':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'bio':
          'My favorite thing in the world is to climb the most difficult mountain climbs in the world. If you like a challenge, I\'m the one to join!',
      'preferences': ['Hiking', 'Walking', 'Climbing'],
      'distance': '2.5 miles away',
    },
    {
      'name': 'Madison',
      'photoUrl':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'bio':
          'I love to go cycling through my city, there\'s nothing better than a warm bike ride through the park there.',
      'preferences': ['Cycling', 'Running'],
      'distance': '5.1 miles away',
    },
    {
      'name': 'Sophia',
      'photoUrl':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'bio':
          'I\'ve been surfing for years, if you want to know the best beaches, I know the absolute best!',
      'preferences': ['Swimming', 'Surfing'],
      'distance': '1.8 miles away',
    },
    {
      'name': 'no name',
      'photoUrl':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'bio': 'Loves climbing mountains and challenging themselves.',
      'preferences': ['Climbing', 'Hiking'],
      'distance': '3.7 miles away',
    },
    {
      'name': 'no name',
      'photoUrl':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'bio': 'Enthusiastic about skiing and winter adventures.',
      'preferences': ['Skiing', 'Snowboarding'],
      'distance': '7.2 miles away',
    },
  ];

  @override
  void initState() {
    super.initState();
    _swipeController = AnimationController(
      duration: const Duration(
        milliseconds: 200,
      ), // Shorter duration for faster swipe
      vsync: this,
    );
    _swipeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _dragCurrentOffset = Offset.zero;
          _isSwiping = false; // Swipe animation completed, allow new drags
          if (_swipeDirection != SwipeDirection.none) {
            if (_swipeDirection == SwipeDirection.left) {
              _nextProfile();
            } else if (_swipeDirection == SwipeDirection.right) {
              _previousProfile();
            }
            _swipeDirection = SwipeDirection.none;
          }
        });
      }
    });
    _swipeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _swipeController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  void _startDrag(DragStartDetails details) {
    if (_isSwiping) return; // Prevent dragging during swipe animation
    setState(() {
      _isDragging = true;
      _dragStartOffset = details.localPosition;
      _dragCurrentOffset = Offset.zero;
      _dragStartX = details.globalPosition.dx;
      if (_swipeController.isAnimating) {
        _swipeController.stop();
      }
    });
  }

  void _updateDrag(DragUpdateDetails details) {
    if (_isSwiping) return; // Prevent updating drag during swipe animation
    setState(() {
      _dragCurrentOffset = details.localPosition - _dragStartOffset;
    });
  }

  SwipeDirection _swipeDirection = SwipeDirection.none;

  void _endDrag(DragEndDetails details) {
    if (_isSwiping) return; // Prevent ending drag during swipe animation
    setState(() {
      _isDragging = false;
      final screenWidth = MediaQuery.of(context).size.width;
      final currentX = _dragStartX + _dragCurrentOffset.dx;

      if (currentX < screenWidth / 3) {
        // Swiped to the left third
        _animateSwipe(Offset(-screenWidth * 1.5, 0)); // Fly off left
        _swipeDirection = SwipeDirection.left;
      } else if (currentX > screenWidth * 2 / 3) {
        // Swiped to the right third
        _animateSwipe(Offset(screenWidth * 1.5, 0)); // Fly off right
        _swipeDirection = SwipeDirection.right;
      } else {
        // Not swiped far enough, animate back
        _animateBack();
        _swipeDirection = SwipeDirection.none;
      }
    });
  }

  void _animateSwipe(Offset endOffset) {
    setState(() {
      _isSwiping = true; // Mark that a swipe animation is in progress
      _swipeAnimation = Tween<Offset>(
        begin: _dragCurrentOffset,
        end: endOffset,
      ).animate(
        CurvedAnimation(parent: _swipeController, curve: Curves.easeInOut),
      );
      _swipeController.reset();
      _swipeController.forward();
    });
  }

  void _animateBack() {
    _swipeAnimation = Tween<Offset>(
      begin: _dragCurrentOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _swipeController, curve: Curves.easeInOut),
    );
    _swipeController.reset();
    _swipeController.forward();
  }

  void _nextProfile() {
    setState(() {
      if (_currentProfileIndex < _profiles.length - 1) {
        _currentProfileIndex++;
      }
    });
  }

  void _previousProfile() {
    setState(() {
      if (_currentProfileIndex > 0) {
        _currentProfileIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Badge(label: Text('2'), child: Icon(Icons.message)),
            icon: Badge(label: Text('2'), child: Icon(Icons.message_outlined)),
            label: 'Messages',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body:
          <Widget>[
            Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 255, 136, 0),
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  if (_profiles.length > 1)
                    Positioned(
                      top: screenHeight * 0.04,
                      left: 20,
                      right: 20,
                      bottom: screenHeight * 0.04,
                      child: Opacity(
                        opacity: 0.8,
                        child: Transform.scale(
                          scale: 0.9,
                          child: IgnorePointer(
                            // Make the card behind non-interactive during swipe
                            ignoring: _isSwiping,
                            child: ProfileCard(
                              profileData:
                                  _profiles[(_currentProfileIndex + 1) %
                                      _profiles.length],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_profiles.isNotEmpty)
                    AnimatedBuilder(
                      animation: _swipeController,
                      builder: (context, child) {
                        final offset =
                            _isDragging
                                ? _dragCurrentOffset
                                : _swipeAnimation?.value ?? Offset.zero;
                        return Positioned(
                          top: screenHeight * 0.04,
                          left: 20 + offset.dx,
                          right: 20 - offset.dx,
                          bottom: screenHeight * 0.04,
                          child: GestureDetector(
                            onPanStart: _startDrag,
                            onPanUpdate: _updateDrag,
                            onPanEnd: _endDrag,
                            child: ProfileCard(
                              profileData: _profiles[_currentProfileIndex],
                            ),
                          ),
                        );
                      },
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return FilterBottomSheet(
                                initialFilters: filters,
                                initialRadius: _currentRadius,
                                onFiltersChanged: (newFilters) {
                                  setState(() {
                                    filters = newFilters;
                                  });
                                },
                                onRadiusChanged: (newRadius) {
                                  setState(() {
                                    _currentRadius = newRadius;
                                  });
                                },
                              );
                            },
                          );
                        },
                        foregroundColor: Colors.white,
                        elevation: 20,
                        backgroundColor: Colors.orange,
                        shape: const CircleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 255, 102, 0),
                            width: 3,
                          ),
                        ),
                        child: const Icon(Icons.filter_alt),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Messages
Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3, // Let's show a few example chats
        itemBuilder: (BuildContext context, int index) {
          // Example data for each chat item
          final String name = ['Amanda', 'John', 'Sarah'][index];
          const String lastMessage = 'Hey, how are you doing?';
          const String avatarUrl =
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(lastMessage),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(name: name),
                ),
              );
            },
          );
        },
      ),
    ),

            Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 255, 136, 0),
                title: Text(
                  '${widget.userData?['firstname']} ${widget.userData?['lastname']} ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Change Profile Page:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select identification',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedIdentification,
                        items:
                            <String>[
                              'Male',
                              'Female',
                              'Non-Binary',
                              'Other',
                            ].map((String value) {
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
                        items:
                            <String>[
                              'Male',
                              'Female',
                              'Non-Binary',
                              'Other',
                            ].map((String value) {
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
                          return <String>[
                            'Male',
                            'Female',
                            'Non-Binary',
                            'Other',
                          ].map((String value) {
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
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Save Changes'),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const App(),
                              ),
                            );
                          },
                          child: const Text('Sign Out'),
                        ),
                      ),

                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ][currentPageIndex],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> profileData;

  const ProfileCard({super.key, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.zero, // Remove default margin
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 100.0,
                height: 100.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileData['photoUrl']),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                profileData['name'] ?? 'No bio available.',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Bio',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(profileData['bio'] ?? 'No bio available.'),
            const SizedBox(height: 16.0),
            Text(
              'Preferences',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children:
                  (profileData['preferences'] as List<String>?)?.map((
                    preference,
                  ) {
                    return Chip(label: Text(preference));
                  }).toList() ??
                  [const Text('No preferences listed.')],
            ),
            const SizedBox(height: 16.0),
            Text(
              'Distance',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(profileData['distance'] ?? 'Distance not available.'),
          ],
        ),
      ),
    );
  }
}

class FilterBottomSheet extends StatefulWidget {
  final Set<Filter> initialFilters;
  final double initialRadius;
  final Function(Set<Filter>) onFiltersChanged;
  final Function(double) onRadiusChanged;

  const FilterBottomSheet({
    super.key,
    required this.initialFilters,
    required this.initialRadius,
    required this.onFiltersChanged,
    required this.onRadiusChanged,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class ChatScreen extends StatelessWidget {
  final String name;

  const ChatScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 136, 0),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Text('Messaging'),
        // You'll build your actual messaging UI here
      ),
    );
  }
}

class ChatMessage {
  final String id;
  final String name;
  final String lastMessage;
  final String avatarUrl;

  ChatMessage({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.avatarUrl,
  });
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Set<Filter> filters;
  late double _currentRadius;

  @override
  void initState() {
    super.initState();
    filters = Set.from(widget.initialFilters);
    _currentRadius = widget.initialRadius;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 1200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Filter Activities',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Wrap(
              children:
                  Filter.values.map((Filter exercise) {
                    return FilterChip(
                      padding: const EdgeInsets.all(8.0),
                      selectedColor: const Color.fromARGB(255, 255, 178, 114),
                      label: Text(exercise.name),
                      selected: filters.contains(exercise),
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            filters.add(exercise);
                          } else {
                            filters.remove(exercise);
                          }
                        });
                        widget.onFiltersChanged(filters);
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 40.0),
            Text(
              'Filter Radius',
              textAlign: TextAlign.left,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Slider(
              value: _currentRadius,
              activeColor: const Color.fromARGB(255, 255, 167, 85),
              max: 200,
              onChanged: (double value) {
                setState(() {
                  _currentRadius = value;
                });
                widget.onRadiusChanged(_currentRadius);
              },
            ),
            const SizedBox(height: 10.0),
            Text(
              'Radius: ${_currentRadius.toStringAsFixed(0)} miles',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
