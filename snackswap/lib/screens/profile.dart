import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:snackswap/models/user/user.dart';
import 'package:snackswap/screens/add_snack.dart';
import 'package:snackswap/screens/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileStateScreen();
}

class _ProfileStateScreen extends State<ProfileScreen> {
  User? user;
  int? amount;

  @override
  void initState() {
    super.initState();
    getCurrent();
  }

  void getCurrent() {
    final findId = Hive.box('auth').get('id');
    final users = Hive.box<User>('users');
    final snacks = Hive.box<Snack>('snacks');

    final getUser = users.values.firstWhere((item) => item.id == findId);
    final getAmount = snacks.values.where((item) => item.userId == findId).length;

    setState(() {
      user = getUser;
      amount = getAmount;
    });
  }

  void signout(BuildContext context) async{
    await Hive.box('auth').delete('id');
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => AuthScreen()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Scaffold(
        backgroundColor: AppColors.blue,
        body: Center(child: Text('no user sorry')),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/${user?.image}',
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  '${user?.name}',
                  style: GoogleFonts.fredoka(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  spacing: 10,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/${user?.flag}',
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text('${user?.country}', style: GoogleFonts.poppins(
                      color: AppColors.white
                    ),)
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.peach,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      spacing: 10,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brown,
                            ),
                            onPressed: (){},
                            child: Text('My snacks ($amount)', style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brown,
                            ),
                            onPressed: (){
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (context) => AddSnackScreen()
                                )
                              );
                            },
                            child: Text('Add snack', style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          spacing: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Successful swaps', style: GoogleFonts.fredoka(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white
                                  ),
                                ),
                                Text('${user?.swaps}', style: GoogleFonts.fredoka(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white
                                ),)
                              ],
                            ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.brown,
                              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20)
                            ),
                            onPressed: (){
                              signout(context);
                            },
                            child: Text('Sign out', style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                        )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
