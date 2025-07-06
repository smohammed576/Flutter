import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/constants/colors.dart';
import 'package:gym/models/user/user.dart';
import 'package:gym/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? theme;

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  void getTheme() async {
    await Hive.openBox('theme');
    setState(() {
      theme = Hive.box('theme').get('color');
    });
  }

  Future<void> auth() async {
    final data = Hive.box<User>('users');

    User? findUser;
    try {
      findUser = data.values.firstWhere(
        (item) =>
            item.username == _nameController.text.toLowerCase() &&
            item.password == _passwordController.text,
      );
    } catch (_) {
      findUser == null;
    }

    if (findUser != null) {
      final current = Hive.box('auth');
      await current.put('username', findUser.username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _nameController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Icon.png',
                  width: 80,
                  colorBlendMode: BlendMode.color,
                  color: theme != 'green'
                      ? BlendColors.blendColors[theme]
                      : null,
                ),
                SizedBox(height: 10),
                Text(
                  'VierToreGym',
                  style: TextStyle(
                    color: AppColors.appColors[theme],
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Card(
              color: LightColors.lightColors[theme],
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColors.appColors[theme],
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color:
                                      AppColors.appColors[theme] ??
                                      Colors.green,
                                  width: 3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color:
                                      AppColors.appColors[theme] ??
                                      Colors.green,
                                  width: 3,
                                ),
                              ),
                              prefixIcon: SvgPicture.asset(
                                'assets/Icons/Person.svg',
                                width: 25,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 50,
                                minHeight: 25,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Username',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color:
                                      AppColors.appColors[theme] ??
                                      Colors.green,
                                  width: 3,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color:
                                      AppColors.appColors[theme] ??
                                      Colors.green,
                                  width: 3,
                                ),
                              ),
                              prefixIcon: SvgPicture.asset(
                                'assets/Icons/Lock.svg',
                                width: 25,
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 50,
                                minHeight: 25,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.appColors[theme] ?? Colors.green,
                                padding: EdgeInsets.symmetric(vertical: 20),
                              ),
                              onPressed: auth,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not registered yet?',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 5),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.appColors[theme] ?? Colors.green,
                      width: 3,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: AppColors.appColors[theme] ?? Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
