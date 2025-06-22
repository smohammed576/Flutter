import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/user/user.dart';
import 'package:snackswap/screens/home.dart';
import 'package:uuid/uuid.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _flagController = TextEditingController();

  Future<void> auth() async {
    final data = Hive.box<User>('users');

    User? findUser;
    try {
      findUser = data.values.firstWhere(
        (item) => item.name == _nameController.text,
      );
    } catch (_) {
      findUser = null;
    }

    if (findUser != null) {
      final currentUser = Hive.box('auth');
      await currentUser.put('id', findUser.id);
    } else {
      final addUser = User(
        id: const Uuid().v4(),
        name: _nameController.text,
        image: _imageController.text,
        country: _countryController.text,
        flag: _flagController.text,
      );
      await data.add(addUser);

      final currentUser = Hive.box('auth');
      await currentUser.put('id', addUser.id);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(page: 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          spacing: 10,
          children: [
            Text(
              'Sign in',
              style: GoogleFonts.fredoka(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                hintText: 'Enter your name...',
                hintStyle: GoogleFonts.poppins(color: AppColors.black),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                hintText: 'Enter your image...',
                hintStyle: GoogleFonts.poppins(color: AppColors.black),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                hintText: 'Enter your country...',
                hintStyle: GoogleFonts.poppins(color: AppColors.black),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _flagController,
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                hintText: 'Enter your flag...',
                hintStyle: GoogleFonts.poppins(color: AppColors.black),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brown,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  auth();
                },
                child: Text(
                  'Sign in',
                  style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
