import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smoothie/constants/colors.dart';
import 'package:smoothie/models/smoothie/smoothie.dart';
import 'package:smoothie/screens/number.dart';
import 'package:smoothie/widgets/logo.dart';
import 'package:smoothie/widgets/order.dart';

class ShopScreen extends StatefulWidget{
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List? orders;
  List<String>? names;

  @override
  void initState(){
    super.initState();
    getOrders();
  }

  void getOrders(){
    final data = Hive.box<Smoothie>('smoothies').values.toList();
    setState(() {
      orders = data;
      names = data.map((item) => item.name).toList();
    });
  }

  void removeOrder(id) async{
    final order = Hive.box<Smoothie>('smoothies').values.firstWhere((item) => item.id == id);
    await order.delete();
    getOrders();
  }

  void empty() async{
    final keys = Hive.box<Smoothie>('smoothies').keys;
    await Hive.box<Smoothie>('smoothies').deleteAll(keys);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderNumberScreen(name: names!.join(", ")),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
              Text('Terug naar bestellen', style: TextStyle(
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
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 150, left: 40, bottom: 40),
        child: orders != null && orders!.isNotEmpty ? Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(orders!.length, (index) => ShopOrder(
                    name: orders![index].name, 
                    onTap: () => removeOrder(orders![index].id)
                  ),)
                ),
                SizedBox(height: 40,),
                SizedBox(
                  width: 500,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  AppColors.purple,
                      disabledBackgroundColor: AppColors.purple.withAlpha(100)
                    ),
                    onPressed: () => empty(),
                    child: Text('Bestellen', style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),),
                  ),
                )
              ],
            ),
          ),
        ) : null
      ),
    );
  }
}