import 'package:flutter/material.dart';

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

class HomePage extends StatelessWidget {
  //Call for userData
  final Map<String, dynamic>? userData;

  const HomePage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: NavigationExample(userData: userData,),
    );
  }
}

class NavigationExample extends StatefulWidget {
  //Call for userData
  final Map<String, dynamic>? userData;

  const NavigationExample({super.key, this.userData});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 1;
  Set<Filter> filters = <Filter>{};
  double _currentRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 255, 167, 85),
        indicatorColor: const Color.fromARGB(255, 255, 255, 255),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.filter_alt),
            icon: Icon(Icons.filter_alt_outlined),
            label: 'Filter',
          ),
          NavigationDestination(
            selectedIcon: Badge(label: Text('2'), child: Icon(Icons.message)),
            icon: Badge(label: Text('2'), child: Icon(Icons.message_outlined)),
            label: 'Messages',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
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
            /// Home page
            Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Center(
                  child: Text('Home page', style: theme.textTheme.titleLarge),
                ),
              ),
            ),

            /// Filters page
            Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Column(
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
                              selectedColor: Color.fromARGB(255, 255, 178, 114),
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
                      activeColor: Color.fromARGB(255, 255, 167, 85),
                      max: 200,
                      onChanged: (double value) {
                        setState(() {
                          _currentRadius = value;
                        });
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
            ),

            /// Messages page
            ListView.builder(
              reverse: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Hello',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  );
                }
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Hi, ${widget.userData?['email']}!',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),

            /// Settings page
            Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    'Settings page',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
            ),

            Card(
              shadowColor: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: SizedBox.expand(
                child: Center(
                  child: Text(
                    'Profile page',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ][currentPageIndex],
    );
  }
}
