import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:uuid/uuid.dart';

class AddSnackScreen extends StatefulWidget {
  const AddSnackScreen({super.key});

  @override
  State<AddSnackScreen> createState() => _AddSnackScreen();
}

class _AddSnackScreen extends State<AddSnackScreen> {
  final id = Hive.box('auth').get('id');
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _name = '';
  String _image = '';
  String _description = '';
  String _country = '';
  String _flag = '';
  int _amount = 0;

  void addSnack() async {
    await Hive.openBox('auth');
    await Hive.openBox<Snack>('snacks');
    final data = Hive.box<Snack>('snacks');
    final newSnack = Snack(
      id: const Uuid().v4(),
      name: _name,
      image: _image,
      description: _description,
      country: _country,
      flag: _flag,
      userId: id,
      amount: _amount,
    );
    await data.add(newSnack);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brown,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'Add snack',
              style: GoogleFonts.fredoka(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _globalKey,
              child: Column(
                spacing: 10,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: 'Enter your name...',
                      hintStyle: GoogleFonts.poppins(color: AppColors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _name = value,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: 'Enter your image...',
                      hintStyle: GoogleFonts.poppins(color: AppColors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _image = value,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: 'Enter your description...',
                      hintStyle: GoogleFonts.poppins(color: AppColors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _description = value,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: 'Enter your country...',
                      hintStyle: GoogleFonts.poppins(color: AppColors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _country = value,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: 'Enter your flag...',
                      hintStyle: GoogleFonts.poppins(color: AppColors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _flag = value,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: 'Enter your amount...',
                      hintStyle: GoogleFonts.poppins(color: AppColors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) => _amount = int.parse(value),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                      ),
                      onPressed: () {
                        addSnack();
                      },
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
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
    );
  }
}
