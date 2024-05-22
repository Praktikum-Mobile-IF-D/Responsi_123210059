import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
     
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Text('Login'),
      ),
      body: Center(
        
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login Form',
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                String username = username_controller.text;
                String password = password_controller.text;
                if(username != '' && password != ''){
                  print('Successfull');
                  loginData.setBool('login', false);
                  loginData.setString('username', username);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyDashboard()));
                }
              }, 
              child: Text("Login"))
          ],
        ),
      ),
    );
  }

  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    print(newUser);
    if(newUser == false) {
      Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  @override
  void dispose () {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
}
