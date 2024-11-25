

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:rent_umbrella_capstone/elements/map.dart';
import 'package:rent_umbrella_capstone/elements/qrscanner.dart';
import 'package:rent_umbrella_capstone/main.dart';
import 'package:rent_umbrella_capstone/screen/login.dart';
import 'package:rent_umbrella_capstone/screen/profile.dart';
import 'package:rent_umbrella_capstone/screen/settings.dart';
import 'package:rent_umbrella_capstone/screen/profile.dart';


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


  // 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),


      
      //body: Body(counter: _counter, selectedIndex: _selectedIndex), 

      body: MapEl(),
      
      //Body(counter: _counter, selectedIndex: _selectedIndex),


      bottomNavigationBar: NavBar(
        onItemTapped: _onNavBarTapped, // Pass callback to NavBar
      ),


      floatingActionButton: CameraButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


// Defunct: Controls which Page  
// Widget _getSelectedPage() {
//   switch(_selectedIndex) {
//     case 0:
//       return Body(counter: _counter, selectedIndex: _selectedIndex);
//     case 1:
//       return Profile(counter: _counter, selectedIndex: _selectedIndex,);
//     case 2:
//       return Settings(counter: _counter, selectedIndex: _selectedIndex,);
//     default:
//       return Body(counter: _counter, selectedIndex: _selectedIndex);
//   }
// }

  FloatingActionButton CameraButton() {
    return FloatingActionButton(
      onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRScanner())
                  );
      },
      tooltip: 'Scan QR Code',
      child: const Icon(Icons.camera),
    );
  }
}

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

// MAV BAR



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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(counter: 2, selectedIndex: _selectedIndex))
                  );
                },
              ),
            ],
          ),
          Row(
            children: [

              IconButton(
                icon: const Icon(Icons.settings),
                 onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings())
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage())
                  );
                },
              )
            
            
            
            
            ],
          ),
        ],
      ),
    );
  }
}