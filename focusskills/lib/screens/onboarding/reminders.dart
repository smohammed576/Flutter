import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/models/user/user.dart';
import 'package:focusskills/routes/navigator.dart';
import 'package:focusskills/widgets/daybutton.dart';
import 'package:focusskills/widgets/purplebutton.dart';
import 'package:hive/hive.dart';

class RemindersScreen extends StatefulWidget{
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final List<String> days = ["S", "M", "T", "W", "T", "F", "S"];
  User? user;
  DateTime time = DateTime.now();
  List<int> weekdays = [];

  void addReminders(DateTime pickedTime, List<int> pickedDays) async{
    final auth = Hive.box('auth').get('id');
    final getUser = Hive.box<User>('users').values.firstWhere((item) => item.id == auth);
    getUser.time = pickedTime;
    getUser.days = pickedDays;
    await getUser.save();
    setState(() {
      user = getUser;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainNavigator(user: user!,),)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('What time would you like to meditate?', style: TextStyle(
              color: AppColors.color,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10,),
            Text('Any time you can choose but we recommend first thing in the morning.', style: TextStyle(
              color: AppColors.color.withAlpha(150),
              fontWeight: FontWeight.w200,
              fontSize: 14
            ),
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.color.withAlpha(10)
              ),
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              padding: EdgeInsets.all(10),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: time,
                onDateTimeChanged: (value) {
                  setState(() {
                    time = value;
                  });
                },
              )
            ),
            SizedBox(height: 20,),
            Text('Which day would you like to meditate?', style: TextStyle(
              color: AppColors.color,
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 10,),
            Text('Every day is best, but we recommend picking at least five.', style: TextStyle(
              color: AppColors.color.withAlpha(150),
              fontWeight: FontWeight.w200,
              fontSize: 14
            ),
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(days.length, (index) => RemindersDayButton(
                day: days[index],
                isActive: weekdays.contains(index),
                onTap: (){
                  if(weekdays.contains(days[index])){
                    weekdays.remove(index);
                  }
                  else{
                    weekdays.add(index);
                  }
                }
              )
              )
            ),
            SizedBox(height: 40,),
            PurpleButton(
              text: 'SAVE', 
              isNotPurple: false, 
              onTap: () => addReminders(time, weekdays)
            ),
            SizedBox(height: 10,),
            Text('NO THANKS', style: TextStyle(
              color: AppColors.color,
              fontSize: 14
            ),)
          ],
        ),
      ),
    );
  }
}