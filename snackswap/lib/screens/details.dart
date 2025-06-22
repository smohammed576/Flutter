import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:snackswap/screens/swap.dart';

class DetailsScreen extends StatefulWidget {
  final String name;
  const DetailsScreen({required this.name, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Snack? snack;

  @override
  void initState() {
    super.initState();
    getSnack();
  }

  void getSnack() async {
    await Hive.openBox<Snack>('snacks');
    final data = Hive.box<Snack>('snacks');

    final findSnack = data.values.firstWhere(
      (item) => item.name == widget.name,
    );

    setState(() {
      snack = findSnack;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.chevron_left_rounded),
        iconSize: 50,
        color: AppColors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/${snack!.image}',
              fit: BoxFit.contain,
              height: 200,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: AppColors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snack!.name,
                      style: GoogleFonts.fredoka(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          child: Image.asset(
                            'assets/images/${snack!.flag}',
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(snack!.country, style: GoogleFonts.poppins()),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      snack!.description,
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => SwapScreen(snack: snack!),
                            ),
                          );
                        },
                        child: Text(
                          "Let's swap",
                          style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
