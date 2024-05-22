import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsi059/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build (BuildContext context){
     return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
      ),
      home: MyDashboard(),
    );
  }
}
class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();

}

class _MyDashboardState extends State<MyDashboard>{
  late SharedPreferences loginData;
  late String username;

  @override
  void initState(){
    super.initState();
    initial();
  }
  void initial() async {
    loginData =  await SharedPreferences.getInstance();
    setState(() {
      username = loginData.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                loginData.setBool('login', true);
                Navigator.push(context, new MaterialPageRoute(builder: (context) => MyLoginPage()));
              }, 
              child: Text('LogOut'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.blue,)),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline, color: Colors.white,)),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit, color: Colors.white,)),
        ],
      ),
    );
  }
}
