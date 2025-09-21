import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/screens/auth/login.dart';
import 'package:focusskills/screens/onboarding/welcome.dart';
import 'package:focusskills/widgets/auth_richtext.dart';
import 'package:focusskills/widgets/input.dart';
import 'package:focusskills/widgets/leadingbutton.dart';
import 'package:focusskills/widgets/purplebutton.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User? user;

  void registerUser() async{
    final users = Hive.box<User>('users');
    User? findUser;
    try{
      findUser = users.values.firstWhere((item) => item.email == emailController.text);
    }
    catch(error){
      findUser = null;
    }
    if(findUser == null){
      final User newUser = User(
        id: Uuid().v4(), 
        name: nameController.text, 
        email: emailController.text, 
        password: passwordController.text
      );
      await users.add(newUser);
      await Hive.box('auth').put('id', newUser.id);
      setState(() {
        user = newUser;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen(user: user!,))
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
                Text('Create your account', style: TextStyle(
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
                  hint: 'Name', 
                  isPassword: false, 
                  controller: nameController, 
                  suffix: Icon(Icons.check_rounded), 
                  iconColor: AppColors.green
                ),
                SizedBox(height: 15,),
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read the ',
                            style: TextStyle(
                              color: AppColors.color.withAlpha(100),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontSize: 14
                            )
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.facebook,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 14
                            )
                          )
                        ]
                      ),
                    ),
                    Checkbox(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(color: AppColors.color.withAlpha(140), width: 1.8),
                      value: false,
                      onChanged: (value) => {},
                    )
                  ],
                ),
                SizedBox(height: 10,),
                PurpleButton(
                  text: 'GET STARTED', 
                  isNotPurple: false,
                  onTap: () => registerUser()
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