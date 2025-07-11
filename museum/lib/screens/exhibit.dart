import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:museum/constants/colors.dart';
import 'package:museum/models/artwork.dart';

class ExhibitScreen extends StatefulWidget{
  const ExhibitScreen({super.key});

  @override
  State<ExhibitScreen> createState() => _ExhibitStateScreen();
}

class _ExhibitStateScreen extends State<ExhibitScreen>{
  List<Artwork>? data;
  int index = 0;

  @override
  void initState(){
    super.initState();
    getData();
  }

  void getData() async{
    final String response = await rootBundle.loadString('assets/artworks.json');
    List results = json.decode(response);
    setState(() {
      data = results.map((item) => Artwork.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.yellow
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data![index].title, style: TextStyle(
                              color: AppColors.background,
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                            ),),
                            Text('${data![index].years}, ${data![index].birthplace}', style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                            ),)
                          ],
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: Image.asset('assets/icons/arrow_outward.png', width: 50, height: 50,),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200)
                    ),
                    child: Image.asset('assets/images/leonardo_da_vinci/${data![index].title.toLowerCase().replaceAll(" ", "_")}.jpg', width: double.infinity, height: 400, fit: BoxFit.cover,)
                  ),
                ],
              ),
            ),
            Stack(
              fit: StackFit.loose,
              children: [
                Image.asset('assets/images/quote.png', width: 100, color: AppColors.grey,),
                SizedBox(height: 20,),
                Text(data![index].comment, style: TextStyle(
                  color: AppColors.greycolor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}