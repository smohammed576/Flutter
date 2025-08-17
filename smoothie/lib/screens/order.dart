import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smoothie/constants/colors.dart';
import 'package:smoothie/models/smoothie/smoothie.dart';
import 'package:smoothie/screens/home.dart';
import 'package:smoothie/screens/shop.dart';
import 'package:smoothie/widgets/drink.dart';
import 'package:smoothie/widgets/logo.dart';
import 'package:uuid/uuid.dart';

class OrderScreen extends StatefulWidget{
  final String basis;
  final List<String> fruit;
  final List<String> extras;
  const OrderScreen({super.key, required this.basis, required this.fruit, required this.extras});

  @override
  State<OrderScreen> createState() => _OrderStateScreen();
}

class _OrderStateScreen extends State<OrderScreen>{
  late TextEditingController nameController;
  bool isEnabled = false;

  @override
  void initState(){
    super.initState();
    nameController = TextEditingController();
    nameController.addListener((){
      final isEnabled = nameController.text.isNotEmpty;
      setState(() {
        this.isEnabled = isEnabled;
      });
    });
  }

  void addOrder() async{
    final orders = Hive.box<Smoothie>('smoothies');
    final neworder = Smoothie(
      id: Uuid().v4(),
      name: nameController.text, 
      options: [widget.basis]
    );
    await orders.add(neworder);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(),)
    );
  }

  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        leadingWidth: 400,
        leading: Padding(
          padding: EdgeInsets.only(top: 20, left: 50),
          child: Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: AppColors.white
                ),
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back, size: 40, color: AppColors.orange,),
              ),
              SizedBox(width: 20,),
              Text('Pas je bestelling aan', style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 26
              ),)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingLogo(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.background
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 450,
                    height: 350,
                    child: Card(
                      color: AppColors.white,
                      elevation: 10,
                      shadowColor: AppColors.orange.withAlpha(100),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text('Geef je smoothie een naam', style: TextStyle(
                              color: AppColors.color,
                              fontWeight: FontWeight.w600,
                              fontSize: 38
                            ),
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(height: 20,),
                            TextField(
                              controller: nameController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.purple,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderSide: BorderSide(width: 3, color: AppColors.purple), borderRadius: BorderRadius.circular(100)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3, color: AppColors.purple), borderRadius: BorderRadius.circular(100)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 3, color: AppColors.purple), borderRadius: BorderRadius.circular(100)),
                                hint: Center(
                                  child: Text('Voer een naam in...', style: TextStyle(
                                    color: AppColors.purple.withAlpha(100),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20
                                  ),),
                                )
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:  AppColors.purple,
                                  disabledBackgroundColor: AppColors.purple.withAlpha(100)
                                ),
                                onPressed: isEnabled ? (){
                                  addOrder();
                                } : null,
                                child: Text('Toevoegen aan mandje', style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 140,),
                  Row(
                    children: [
                      Text('Ga naar winkelmandje', style: TextStyle(
                        color: AppColors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 22
                      ),),
                      SizedBox(width: 10,),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.white,
                          shape: CircleBorder()
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ShopScreen(),)
                        ),
                        icon: Icon(Icons.shopping_basket, color: AppColors.orange, size: 30,),
                      )
                    ],
                  )
                ],
              ),
            ),
            Stack(
              children: [
                SmoothieDrink(
                  amount: 0.55, 
                  color: widget.extras.isNotEmpty ? AppColors.drinkColors[widget.extras[0].toLowerCase()] ?? Colors.white : Colors.transparent
                ),
                SmoothieDrink(
                  amount: 0.65, 
                  color: widget.fruit.isNotEmpty ? AppColors.drinkColors[widget.fruit[0].toLowerCase().replaceAll(" ", "")] ?? Colors.white : Colors.transparent
                ),
                SmoothieDrink(
                  amount: 0.8, 
                  color: AppColors.drinkColors[widget.basis.toLowerCase()] ?? Colors.white
                ),
                Positioned(
                  bottom: -105,
                  left: 44,
                  child: SizedBox(
                    width: 500,
                    height: 930,
                    child: Image.asset('assets/smoothie_cup_empty.png', fit: BoxFit.cover, opacity: AlwaysStoppedAnimation(0.8),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}