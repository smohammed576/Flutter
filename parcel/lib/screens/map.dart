import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/helpers/parcel_helper.dart';
import 'package:parcel/models/driver.dart';
import 'package:parcel/models/position.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/driver.dart';
import 'package:parcel/widgets/line.dart';
import 'package:video_player/video_player.dart';

class MapScreen extends StatefulWidget{
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isLoading = true;
  Driver? driver;
  List<Position>? positions;
  int? random;
  
  @override
  void initState() {
    super.initState();
    getPositions();
    Future.delayed(Duration(seconds: 5), () {
      getRandomDriver();
      setState(() {
        playSoundeffect();
        HapticFeedback.vibrate();
        isLoading = false;
      });
    });
  }

  void getPositions() async {
    final String response = await rootBundle.loadString('assets/data/positions.json');
    final List data = json.decode(response);
    setState(() {
      positions = data.map((item) => Position.fromJson(item)).toList();
    });
  }

  void getRandomDriver() async {
    final String response = await rootBundle.loadString('assets/data/drivers.json');
    final List data = json.decode(response);
    int randomNumber = Random().nextInt(data.length);
    setState(() {
      driver = Driver.fromJson(data[randomNumber]);
      random = Random().nextInt(positions!.length);
    });
  }

  Future<void> playSoundeffect() async {
    final controller = VideoPlayerController.asset('assets/driver_found.mp3');
    await controller.initialize();
    controller.setVolume(1.0);
    controller.play();

    controller.addListener((){
      if(!controller.value.isPlaying && controller.value.position >= controller.value.duration){
        controller.dispose();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 50), 
        child: ParcelAppBar()
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/map.png', fit: BoxFit.cover,),
          ),
          Stack(
            children: positions != null && positions!.isNotEmpty ? List.generate(positions!.length, (index) {
              final item = positions![index];
              return Positioned(
                top: item.top,
                left: item.left,
                right: item.right,
                bottom: item.bottom,
                child: Image.asset('assets/images/bike.png'),
              );
            },) : [],
          ),
          Center(
            child: Image.asset('assets/images/marker.png'),
          ),
          if(!isLoading)
          Positioned(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return CustomPaint(
                  painter: LinePainter(
                    Offset(MediaQuery.sizeOf(context).width / 2, MediaQuery.sizeOf(context).height / 2), 
                    Offset(
                      positions![random ?? 0].top ?? positions![random ?? 0].bottom!, 
                      positions![random ?? 0].left ?? positions![random ?? 0].right!
                    )
                  ),
                );
              },
            ),
          ),
          if(isLoading)
          Positioned(
            bottom: 180,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withAlpha(50),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: Offset(0, 2)
                    )
                  ]
                ),
                width: 220,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset('assets/images/bike.png', width: 40,),
                    SizedBox(width: 10,),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '4 Bikes ', style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Geist'
                            )
                          ),
                          TextSpan(
                            text: 'close to you', style: TextStyle(
                              color: AppColors.crow,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Geist'
                            )
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                if(!isLoading && driver != null)
                DeliveryDriver(
                  driver: driver!
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: isLoading ? BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)) : null,
                    color: AppColors.white
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  height: 160,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text('Status', style: TextStyle(
                              color: AppColors.crow,
                              fontSize: 12
                            ),),
                            Text(isLoading ? 'Finding a rider near you' : 'Driver is enroute', style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14
                            ),),
                            ],
                          ),
                          if(!isLoading)
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.timer_sharp, size: 15,)
                                ),
                                TextSpan(
                                  text: ' 8 Mins Away', style: TextStyle(
                                    color: AppColors.crow,
                                    fontSize: 12,
                                    fontFamily: 'Geist'
                                  )
                                )
                              ]
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero
                            ),
                            onPressed: (){},
                            child: Text('Cancel', style: TextStyle(
                              color: AppColors.green,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.green
                            ),),
                          ),
                          SizedBox(
                            width: 120,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                              ),
                              onPressed: () => isLoading ? null : ParcelHelpers.showProgressBottomSheet(context, driver!) ,
                              child: Text('View Progress', style: TextStyle(
                                color: AppColors.crow,
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}