import 'package:flutter/material.dart';
import 'package:museum/constants/colors.dart';
import 'package:museum/screens/artists.dart';
import 'package:museum/screens/ticketing.dart';

class ExploreScreen extends StatefulWidget{
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreStateScreen();
}

class _ExploreStateScreen extends State<ExploreScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(left: 20, top: 10,),
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: AppColors.sandcolor))
            ),
            
            padding: EdgeInsets.only(bottom: 10),
            child: Text('Explore', style: TextStyle(
              fontSize: 30,
              color: AppColors.sandcolor
            ),),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Event', style: TextStyle(
                  color: AppColors.color,
                  fontSize: 20
                ),),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketingScreen()
                      )
                    );
                  },
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text('Tickets', style: TextStyle(
                        color: AppColors.greycolor,
                        fontSize: 16,
                      ),),
                      Image.asset('assets/icons/chevron_right.png', width: 20, height: 20, color: AppColors.greycolor,)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Card(
              shape: RoundedRectangleBorder(),
              elevation: 10,
              color: AppColors.grey,
              child: Column(
                children: [
                  Image.asset('assets/images/renaissance.jpg', height: 200, width: double.infinity, fit: BoxFit.cover,),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('10', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColors.color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22
                                ),),
                                Text('OCT', style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: AppColors.color,
                                  fontSize: 16
                                ),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30,),
                        SizedBox(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Renaissance Exhibition', style: TextStyle(
                                fontSize: 20,
                                color: AppColors.color
                              ),),
                              SizedBox(height: 20,),
                              SizedBox(
                                width: 200,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('9:00 AM', style: TextStyle(
                                          color: AppColors.color,
                                          fontSize: 14
                                        ),),
                                        SizedBox(width: 10,),
                                        Image.asset('assets/icons/arrow_right_alt.png', height: 16,),
                                        SizedBox(width: 10,),
                                        Text('6:00 PM', style: TextStyle(
                                          color: AppColors.color,
                                          fontSize: 14
                                        ),)
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                Text('Indulge in the rich tapestry of Renaissance art', style: TextStyle(
                                  color: AppColors.yellow,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.yellow,
                                  decorationThickness: 2
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text('+33 (0)1 23 45 67 89', style: TextStyle(
                                  color: AppColors.greycolor,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.greycolor,
                                  decorationThickness: 2
                                ),)
                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        shape: LinearBorder()
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArtistsScreen()
                          )
                        );
                      },
                      child: Text('Visit Gallery', style: TextStyle(
                        color: AppColors.background,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}