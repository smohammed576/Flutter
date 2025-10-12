import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';
import 'package:packages/models/user.dart';
import 'package:packages/providers/database.dart';
import 'package:packages/providers/session.dart';
import 'package:packages/screens/home.dart';
import 'package:packages/screens/register.dart';
import 'package:packages/widgets/input.dart';
import 'package:packages/widgets/textbutton.dart';
import 'package:packages/widgets/yellowbutton.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DatabaseService databaseService = DatabaseService();
  final SessionService sessionService = SessionService();
  User? user;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signinUser() async {
    if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      final users = await databaseService.retrieveUsers();
      User? finduser;
      try{
        finduser = users.firstWhere((item) => item.username == usernameController.text && item.password == passwordController.text);
      } catch(error){
        finduser = null;
      }
      if(finduser != null){
        await sessionService.setLoggedIn(finduser.id);
        setState(() {
          user = finduser;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('Login', style: TextStyle(
          color: AppColors.color,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(
              label: 'Username', 
              isPassword: false, 
              controller: usernameController
            ),
            SizedBox(height: 20,),
            InputField(
              label: 'Password', 
              isPassword: true, 
              controller: passwordController
            ),
            SizedBox(height: 40,),
            YellowButton(
              text: 'LOGIN', 
              onTap: () => signinUser()
            ),
            SizedBox(height: 10,),
            BlueTextButton(
              text: 'Register', 
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen())
              ),
            )
          ],
        ),
      ),
    );
  }
}