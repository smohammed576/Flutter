
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcel/constants/colors.dart';
import 'package:parcel/models/vehicle.dart';
import 'package:parcel/screens/map.dart';
import 'package:parcel/widgets/appbar.dart';
import 'package:parcel/widgets/greenbutton.dart';

class VehicleScreen extends StatefulWidget{
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen>{
  List<Vehicle>? vehicles;
  int? selected;

  @override
  void initState() {
    super.initState();
    getVehicles();
  }

  void getVehicles() async {
    final String response = await rootBundle.loadString('assets/data/vehicles.json');
    final List data = json.decode(response);
    setState(() {
      vehicles = data.map((item) => Vehicle.fromJson(item)).toList();
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
                            Text('Select a Vehicle Type', style: TextStyle(
                              color: AppColors.crow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 40,),
                            Column(
                              children: vehicles != null && vehicles!.isNotEmpty ? List.generate(vehicles!.length, (index) {
                                final item = vehicles![index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(
                                        color: index == selected ? AppColors.green : AppColors.black.withAlpha(50)
                                      )
                                    ),
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        color: index == selected ? AppColors.green : null,
                                        shape: BoxShape.circle,
                                        border: BoxBorder.all(color: index == selected ? AppColors.green : AppColors.black)
                                      ),
                                      width: 15,
                                      height: 15,
                                    ),
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Image.asset('assets/images/${item.image}'),
                                        ),
                                        SizedBox(width: 10,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.name, style: TextStyle(
                                              color: AppColors.crow
                                            ),),
                                            Text("€${item.price},00", style: TextStyle(
                                              color: AppColors.green,
                                              fontWeight: FontWeight.bold
                                            ),),
                                            Text('${item.duration} mins to deliver', style: TextStyle(
                                              color: AppColors.crow
                                            ),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  
                                  ),
                                );
                              },) : []
                            )
                          ]
                        )
                      ],
                    ),
                    GreenButton(
                      text: 'Find driver', 
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen(),)
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