import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/models/user.dart';
import 'package:parcel/providers/database.dart';
import 'package:parcel/providers/session.dart';
import 'package:parcel/screens/home.dart';
import 'package:parcel/widgets/greenbutton.dart';
import 'package:parcel/widgets/input.dart';
import 'package:uuid/uuid.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();
  final SessionService sessionService = SessionService();
  User? user;

  void login() async {
    final newuser = User(
      id: Uuid().v4(), 
      name: nameController.text, 
      email: emailController.text
    );
    await databaseService.createUser(newuser);
    await sessionService.setLoggedIn(newuser.id);
    setState(() {
      user = newuser;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen())
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_skid.png', width: 100),
            Text('Welcome to', style: TextStyle(
              color: AppColors.crow.withAlpha(150),
              fontSize: 20
            ),),
            Text('SKID', style: TextStyle(
              color: AppColors.crow,
              fontSize: 45,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 40,),
            InputWithLabel(
              label: 'Name', 
              hint: 'Enter first name', 
              bigText: false,
              controller: nameController
            ),
            SizedBox(height: 10,),
            InputWithLabel(
              label: 'Email address', 
              hint: 'Provide a valid email address', 
              bigText: false,
              controller: emailController
            ),
            SizedBox(height: 20,),
            GreenButton(
              text: 'Continue', 
              onTap: () => login()
            )
          ],
        ),
      ),
    );
  }
}