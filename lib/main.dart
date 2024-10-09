import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  int _selectedIndex = 0; // Add selectedIndex to the parent state

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),


      // Where we select our main page
      switch(_selectedIndex){
        case 0: 
        return Body(counter: counter, selectedIndex: selectedIndex);
        case 1:
        return Profile();
        case 2: 
        return Settings();
        default:
        return Body(counter: counter, selectedIndex: selectedIndex);
       
      }
      
      body: Body(counter: _counter, selectedIndex: _selectedIndex), 




      bottomNavigationBar: NavBar(
        onItemTapped: _onNavBarTapped, // Pass callback to NavBar
      ),


      floatingActionButton: CameraButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  FloatingActionButton CameraButton() {
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Scan QR Code',
      child: const Icon(Icons.camera),
    );
  }
}



// NAV BAR BELOW


class NavBar extends StatefulWidget {
  final Function(int) onItemTapped; // Define the callback

  const NavBar({super.key, required this.onItemTapped});

  @override
  State<NavBar> createState() => _NavBarState();
}


class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onItemTapped(index); // Call the passed callback
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => _onItemTapped(1),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _onItemTapped(2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// MAIN BODY THIS SHOULD EVENTUALLY BE REPLACED WITH A MAP OR LIST OF STUFF


class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.counter,
    required this.selectedIndex,
  });

  final int counter;
  final int selectedIndex; // Accept selectedIndex as a parameter

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Text(
            'Hello!',
          ),
          Text('Selected Index: $selectedIndex'), // Display the selectedIndex
        ],
      ),
    );
  }
}
