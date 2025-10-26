import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/screens/vehicle.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/greenbutton.dart';

class DatetimeScreen extends StatefulWidget{
  const DatetimeScreen({super.key});

  @override
  State<DatetimeScreen> createState() => _DatetimeScreenState();
}

class _DatetimeScreenState extends State<DatetimeScreen> with TickerProviderStateMixin{
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 1,
      length: 2, 
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 50), 
        child: ParcelAppBar()
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/map.png', fit: BoxFit.cover,),
          ),
          BottomSheet(
            onClosing: (){}, 
            backgroundColor: AppColors.white,
            enableDrag: false,
            constraints: BoxConstraints(maxHeight: 690),
            
            builder: (context) {
              return Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Schedule a pickup time', style: TextStyle(
                              color: AppColors.crow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 40,),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.black.withAlpha(20),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              padding: EdgeInsets.all(2),
                              child: TabBar(
                                controller: tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: AppColors.black.withAlpha(20),
                                dividerHeight: 0,
                                indicator: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                labelColor: AppColors.crow,
                                labelStyle: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Geist'
                                ),
                                labelPadding: EdgeInsets.all(5),
                                onTap: (value) {
                                  setState(() {
                                    tabIndex = value;
                                  });
                                },
                                tabs: [
                                  Text(
                                    'Depart after',
                                  ),
                                  Text(
                                    'Arrive by',
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: TabBarView(
                                controller: tabController,
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.dateAndTime,
                                        minimumDate: DateTime.now(),
                                        use24hFormat: true,
                                        onDateTimeChanged: (value) {
                                        
                                        }
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.dateAndTime,
                                        minimumDate: DateTime.now(),
                                        use24hFormat: true,
                                        onDateTimeChanged: (value) {
                                        
                                        }
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    GreenButton(
                      text: 'Next', 
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VehicleScreen())
                      )
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}