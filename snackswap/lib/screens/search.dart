import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:snackswap/screens/details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int activeFilter = 0;
  List filters = ["All", "Not traded yet", "Traded"];
  List<Snack> snacks = [];
  List<Snack> filtered = [];
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState(){
    super.initState();
    getSnacks();
  }

  void getSnacks() async{
    await Hive.openBox<Snack>('snacks');
    final getAll = Hive.box<Snack>('snacks');

    final findAll = getAll.values.map((item) => item).toList();
    setState(() {
      snacks = findAll;
    });
  }

  void searchSnack(String query) async{
    await Hive.openBox<Snack>('snacks');
    final getAll = Hive.box<Snack>('snacks');
    final findSnack = getAll.values.where((item) => item.name == query).toList();
    setState(() {
      snacks = findSnack;
      _searchController.clear();
    });
  }

  void filterSnacks() async{
      await Hive.openBox<Snack>('snacks');
      final getAll = Hive.box<Snack>('snacks');
    if(activeFilter == 1){
      final findNotTraded = getAll.values.where((item) => item.isSwapped == false).toList();
      setState(() {
        snacks = findNotTraded;
      });
    }
    else if(activeFilter == 2){
      final findTraded = getAll.values.where((item) => item.isSwapped == true).toList();
      setState(() {
        snacks = findTraded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Snacks', style: GoogleFonts.fredoka(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                  fontSize: 60
                  ),
                ),
                Row(
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeFilter == 0 ? AppColors.white : const Color(0x74FFF3E2),
                        elevation: 0
                      ),
                      onPressed: (){
                        setState(() {
                          activeFilter = 0;
                          getSnacks();
                        });
                      },
                      child: Text('All', style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: activeFilter == 0 ? FontWeight.w600 : null,
                        color: AppColors.black
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeFilter == 1 ? AppColors.white : const Color(0x74FFF3E2),
                        elevation: 0
                      ),
                      onPressed: (){
                        setState(() {
                          activeFilter = 1;
                          filterSnacks();
                        });
                      },
                      child: Text('Not traded yet', style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: activeFilter == 1 ? FontWeight.w600 : null,
                        color: AppColors.black
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activeFilter == 2 ? AppColors.white : const Color(0x74FFF3E2),
                        elevation: 0
                      ),
                      onPressed: (){
                        setState(() {
                          activeFilter = 2;
                          filterSnacks();
                        });
                      },
                      child: Text('Traded', style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: activeFilter == 2 ? FontWeight.w600 : null,
                        color: AppColors.black
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: AppColors.white
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
                child: Column(
                  spacing: 10,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Search a snack',
                        hintStyle: GoogleFonts.poppins(
                          color: AppColors.black
                        )
                      ),
                      onSubmitted: (String value) {
                        searchSnack(_searchController.text);
                      },
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: snacks.length,
                        itemBuilder: (context, index) {
                          // final snack = Hive.box<Snack>('snacks').getAt(index);
                          final snack = snacks[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(name: snack.name,)
                                  )
                                );
                              },
                              child: Expanded(
                                child: Row(
                                  spacing: 20,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppColors.pink,
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Image.asset('assets/images/${snack.image}', height: 60, width: 60, fit: BoxFit.contain,)
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 10,
                                        children: [
                                          Text(snack.name, style: GoogleFonts.fredoka(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          Row(
                                            spacing: 10,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(4),
                                                child: Image.asset('assets/images/${snack.flag}', width: 20, height: 20, fit: BoxFit.cover,),
                                              ),
                                              Text(snack.country, style: GoogleFonts.poppins(),)
                                            ],
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
