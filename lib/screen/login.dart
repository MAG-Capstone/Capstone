import 'package:flutter/material.dart';




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate a login attempt (replace with actual logic)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _errorMessage = 'Login failed, please try again'; // Example error
    });
  }



  void _register() async{
   throw UnimplementedError('This feature is not yet implemented.');

  }
  void _forgot() async{
   throw UnimplementedError('This feature is not yet implemented.');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO:
      //TEMPORARY REMOVE PLEASE ONCE THIS ISS IMPLEMENTED
      appBar: AppBar(  
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login"),
        ),
        

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          
          
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [

            if (_errorMessage != null) 
              Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            _isLoading 
              ? CircularProgressIndicator() 
              : ElevatedButton(
                  onPressed: _login, 
                  child: Text('Login'),
                ),

                ElevatedButton(
                  onPressed: _register, 
                  child: Text('Register'),
                ),
          
          
          ],),
          ElevatedButton(
                  onPressed: _forgot, 
                  child: Text('Forgot your password?'),
                ),
          
          
          ],
        ),
      ),
    );
  }
}
