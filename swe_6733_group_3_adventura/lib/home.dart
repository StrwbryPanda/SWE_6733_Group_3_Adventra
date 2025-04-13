import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {
  final Map<String, dynamic>? userData;

  const HomePage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: NavigationExample(userData: userData),
    );
  }
}

class NavigationExample extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const NavigationExample({super.key, this.userData});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
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
      body: <Widget>[
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 136, 0),
            title: const Text(
              'Person\'s Name',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Align(
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
        ),

        // Messages
        
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 136, 0),
            title: const Text(
              'Messages / Person\' Name',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
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
        ),

        // Profile Page

        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 136, 0),
            title: const Text(
              'Profile Name',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Save Changes'),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const App()),
                      );
                    },
                    child: const Text('Sign Out'),
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
              children: Filter.values.map((Filter exercise) {
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