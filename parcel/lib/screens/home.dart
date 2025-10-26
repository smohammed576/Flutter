import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/models/user.dart';
import 'package:parcel/providers/database.dart';
import 'package:parcel/providers/session.dart';
import 'package:parcel/screens/size.dart';
import 'package:parcel/widgets/typebutton.dart';
import 'package:parcel/models/type.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService databaseService = DatabaseService();
  final SessionService sessionService = SessionService();
  User? user;
  List<Type>? types;

  @override
  void initState() {
    super.initState();
    getUser();
    getTypes();
  }

  void getUser() async {
    final id = await sessionService.getId();
    final users = await databaseService.getUsers();
    setState(() {
      user = users.firstWhere((item) => item.id == id);
    });
  }

  void getTypes() async {
    final String response = await rootBundle.loadString('assets/data/types.json');
    final List data = json.decode(response);
    setState(() {
      types = data.map((item) => Type.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 120,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi', style: TextStyle(
              color: AppColors.crow,
              fontSize: 20
            ),),
            Text(user != null ? user!.name : '', style: TextStyle(
              color: AppColors.crow.withAlpha(80),
              fontSize: 45,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Text('What are you sending today?', style: TextStyle(
              color: AppColors.crow,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
      body: types != null && types!.isNotEmpty ? Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: 500,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: types!.length,
                itemBuilder: (context, index) {
                  final item = types![index];
                  return TypeButton(
                    label: item.label, 
                    image: item.image, 
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SizeScreen(type: item))
                    )
                  );
                },
              ),
            ),
          ),
          Container(
            color: AppColors.backgroundgreen,
            child: Image.asset('assets/images/greendetails.png'),
          )
        ],
      ) : null
    );
  }
}