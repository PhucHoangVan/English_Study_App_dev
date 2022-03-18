import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
                child: Center(
              child: Image(
                image: AssetImage("assets/images/background_login.jpg"),
              ),
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Please enter the detail to continue!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 238, 47, 111),
                  ),
                ),
                const SizedBox(height: 0),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "User Email",
                        prefixIcon: Icon(Icons.mail,
                            color: Color.fromARGB(255, 2, 67, 119))),
                  ),
                ),
                const SizedBox(height: 0),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        hintText: "Enter password",
                        prefixIcon: Icon(Icons.lock,
                            color: Color.fromARGB(255, 2, 67, 119))),
                  ),
                ),
                const SizedBox(height: 10),
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  child: const Text(
                    "Forgot password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Color.fromARGB(255, 231, 114, 153)),
                  ),
                ),
                const SizedBox(height: 10),
                // ignore: sized_box_for_whitespace
                Center(
                  child: SizedBox(
                      width: 150,
                      child: RawMaterialButton(
                        fillColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )),
                ),
                const SizedBox(height: 10),
                // const Text("Don't have an account!",
                //     style: TextStyle(color: Colors.blue)),
                // const Text("Register", style: TextStyle(color: Colors.pink))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text("Don't have an account!",
                        style: TextStyle(color: Colors.blue)),
                    Text("Register", style: TextStyle(color: Colors.pink))
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
