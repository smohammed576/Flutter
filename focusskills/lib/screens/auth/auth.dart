import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/screens/auth/login.dart';
import 'package:focusskills/screens/auth/register.dart';
import 'package:focusskills/widgets/auth_richtext.dart';
import 'package:focusskills/widgets/purplebutton.dart';

class AuthScreen extends StatefulWidget{
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/images/logo_dark.svg'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset('assets/backgrounds/beige_background.svg'),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 185,),
                Center(
                  child: SvgPicture.asset('assets/images/chilling.svg', width: 300,)
                ),
                SizedBox(height: 100,),
                Text('Enjoy Focus Skills', style: TextStyle(
                  color: AppColors.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),),
                SizedBox(height: 10,),
                Text('Thousand of people are using Focus Skills for meditation.', style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  color: AppColors.color.withAlpha(150)
                ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50,),
                PurpleButton(
                  text: 'SIGN UP', 
                  isNotPurple: false,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen(),)
                  ), 
                ),
                SizedBox(height: 10,),
                AuthRichText(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen(),)
                  ), 
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}