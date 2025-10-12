import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';
import 'package:packages/models/user.dart';
import 'package:packages/providers/database.dart';
import 'package:packages/providers/session.dart';
import 'package:packages/screens/home.dart';
import 'package:packages/screens/login.dart';
import 'package:packages/widgets/input.dart';
import 'package:packages/widgets/textbutton.dart';
import 'package:packages/widgets/yellowbutton.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();
  final SessionService sessionService = SessionService();
  User? user;

  void newUser() async {
    if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      final User newuser = User(
        id: Uuid().v4(), 
        username: usernameController.text, 
        image: imageController.text,
        password: passwordController.text
      );
      await databaseService.insertUser(newuser);
      await sessionService.setLoggedIn(newuser.id);
      setState(() {
        user = newuser;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(),)
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Register', style: TextStyle(
          color: AppColors.color,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            InputField(
              label: 'Username', 
              isPassword: false, 
              controller: usernameController
            ),
            SizedBox(height: 20,),
            InputField(
              label: 'Image (optional + locale imgs in juiste folder)', 
              isPassword: false, 
              controller: imageController
            ),
            SizedBox(height: 20,),
            InputField(
              label: 'Password', 
              isPassword: true, 
              controller: passwordController
            ),
            SizedBox(height: 40,),
            YellowButton(
              text: 'REGISTER', 
              onTap: () => newUser()
            ),
            SizedBox(height: 10,),
            BlueTextButton(
              text: 'Login', 
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen())
              ),
            )
          ],
        ),
      ),
    );
  }
}