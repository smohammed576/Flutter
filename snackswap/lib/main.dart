import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/request/request.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:snackswap/models/user/user.dart';
import 'package:snackswap/screens/auth.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:snackswap/screens/home.dart';

// void main(){
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     MaterialApp(
//       home: HomeScreen(),
//       theme: ThemeData(
//         primaryColor: AppColors.black
//       ),
//       // theme: ThemeData(
//       //   textTheme: 
//       //   TextTheme(
//       //     bodyMedium: GoogleFonts.poppins(),

//       //   )
//       // )
//     )
//   );
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SnackAdapter());
  Hive.registerAdapter(StatusAdapter());
  Hive.registerAdapter(RequestAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<Snack>('snacks');
  await Hive.openBox<Request>('requests');
  await Hive.openBox('auth');

  final getAuth = Hive.box('auth').get('id');
  final returnScreen = getAuth == null ? AuthScreen() : HomeScreen();

  runApp(
    MaterialApp(
      home: returnScreen,
      theme: ThemeData(
        primaryColor: AppColors.black
      ),
    )
  );
}