import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/routes/navigator.dart';
import 'package:focusskills/widgets/input.dart';
import 'package:focusskills/widgets/leadingbutton.dart';
import 'package:focusskills/widgets/purplebutton.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User? user;

  void loginUser() async{
    final users = Hive.box<User>('users');
    User? findUser;
    try{
      findUser = users.values.firstWhere((item) => item.email == emailController.text && item.password == passwordController.text);
    }
    catch(error){
      findUser = null;
    }
    if(findUser != null){
      await Hive.box('auth').put('id', findUser.id);
      setState(() {
        user = findUser;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainNavigator(user: user!,))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: LeadingButton(
          isClose: false,
          hasOutline: false,
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset('assets/backgrounds/auth_curved_lines.svg'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Welcome Back!', style: TextStyle(
                  color: AppColors.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),),
                SizedBox(height: 25,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.facebook
                    ),
                    onPressed: (){},
                    child: Text('CONTINUE WITH FACEBOOK', style: TextStyle(
                      color: AppColors.lightcolor
                    ),),
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 55,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      side: BorderSide(width: 0.1, color: AppColors.color.withAlpha(100))
                    ),
                    onPressed: (){},
                    child: Text('CONTINUE WITH GOOGLE', style: TextStyle(
                      color: AppColors.color
                    ),),
                  ),
                ),
                SizedBox(height: 25,),
                Text('OR LOG IN WITH EMAIL', style: TextStyle(
                  color: AppColors.color.withAlpha(150),
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),),
                SizedBox(height: 25,),
                InputField(
                  hint: 'Email address', 
                  isPassword: false, 
                  controller: emailController, 
                  suffix: Icon(Icons.check_rounded), 
                  iconColor: AppColors.green
                ),
                SizedBox(height: 15,),
                InputField(
                  hint: 'Password', 
                  isPassword: true, 
                  controller: passwordController, 
                  suffix: Icon(Icons.remove_red_eye), 
                  iconColor: AppColors.black
                ),
                SizedBox(height: 20,),
                PurpleButton(
                  text: 'LOG IN', 
                  isNotPurple: false,
                  onTap: () => loginUser()
                ),
                SizedBox(height: 20,),
                Text('Forgot Password?', style: TextStyle(
                  color: AppColors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}