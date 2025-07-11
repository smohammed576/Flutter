import 'package:flutter/material.dart';
import 'package:museum/constants/colors.dart';
import 'package:museum/screens/exhibit.dart';
import 'package:museum/widgets/artist.dart';

class ArtistsScreen extends StatefulWidget{
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsStateScreen();
}

class _ArtistsStateScreen extends State<ArtistsScreen> with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image.asset('assets/images/background.jpg', width: double.infinity, fit: BoxFit.cover,),
        toolbarHeight: 220,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore the art of', style: TextStyle(
                color: AppColors.background,
                fontSize: 30
              ),),
              Text('Renaissance', style: TextStyle(
                fontSize: 45,
                color: AppColors.yellow
              ),),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.zero, borderSide: BorderSide(width: 1, color: AppColors.greycolor)),
                  prefixIcon: Image.asset('assets/icons/search.png', width: 50, color: AppColors.grey,),
                  prefixIconConstraints: BoxConstraints(maxWidth: 50, maxHeight: 25),
                  hintText: 'Type to search...',
                  hintStyle: TextStyle(
                    color: AppColors.greycolor,
                    fontSize: 16
                  ),
                  suffixIcon: Image.asset('assets/icons/crop_free.png', width: 50, color: AppColors.grey,),
                  suffixIconConstraints: BoxConstraints(maxWidth: 50, maxHeight: 25),
                )),
              )
            ],
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: AppColors.yellow,
          labelColor: AppColors.yellow,
          unselectedLabelColor: AppColors.greycolor,
          dividerColor: AppColors.grey,
          onTap: (value){
            if(value == 1){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExhibitScreen()
                )
              );
            }
          },
          tabs: [
            Text('Artists', style: TextStyle(
              fontSize: 20
            ),),
            Text('Artworks', style: TextStyle(
              fontSize: 20
            ),)
          ]
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                width: double.infinity,
                child: Column(
                  children: [
                    ArtistCard(name: 'Leonardo da Vinci', image: 'assets/images/leonardo_da_vinci/leonardo_da_vinci.jpeg', dates: [1452, 1519], direction: 'start'),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 40),
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset('assets/images/leonardo_da_vinci/mona_lisa.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 10,),
                          ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
                            child: Image.asset('assets/images/leonardo_da_vinci/lady_ermine.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 10,),
                          ClipRRect(
                            // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
                            child: Image.asset('assets/images/leonardo_da_vinci/litta_madonna.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(right: 20),
                width: double.infinity,
                child: Column(
                  children: [
                    ArtistCard(name: 'Michelangelo', image: 'assets/images/michelangelo/michelangelo.jpg', dates: [1475, 1564], direction: 'end'),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: 40),
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
                            child: Image.asset('assets/images/michelangelo/david.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset('assets/images/michelangelo/torment_of_saint_anthony.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                            child: Image.asset('assets/images/michelangelo/delphic_sibyl.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(right: 20),
                width: double.infinity,
                child: Column(
                  children: [
                    ArtistCard(name: 'Gustav Klimt', image: 'assets/images/gustav_klimt/gustav_klimt.jpg', dates: [1862, 1918], direction: 'start'),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left: 40),
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                            child: Image.asset('assets/images/gustav_klimt/the_kiss.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 15,),
                          ClipRRect(
                            child: Image.asset('assets/images/gustav_klimt/adele_bloch_bauer.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset('assets/images/gustav_klimt/lady_with_fan.jpg', width: 120, height: 150, fit: BoxFit.cover,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}