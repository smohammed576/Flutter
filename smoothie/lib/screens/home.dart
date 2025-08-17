import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';
import 'package:smoothie/screens/order.dart';
import 'package:smoothie/widgets/card.dart';
import 'package:smoothie/widgets/drink.dart';
import 'package:smoothie/widgets/logo.dart';
// import 'package:smoothie/widgets/wave.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int step = 0;
  String? chosenBasis;
  List<String> chosenFruit = [];
  List<String> chosenExtras = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingLogo(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.background
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothieCard(
                    name: 'Basis', 
                    step: 1, 
                    options: ['Melk', 'Water', 'Yoghurt', 'Havermelk'], 
                    isOpen: step == 0 ? true : false, 
                    chosen: chosenBasis,
                    onTap: (){
                      setState(() {
                        step = 0;
                      });
                    },
                    onNext: (value){
                      setState(() {
                        chosenBasis = value;
                        step++;
                      });
                    }
                  ),
                  SmoothieCard(
                    name: 'Fruit', 
                    step: 2, 
                    options: ['Aardbei', 'Banaan', 'Mango', 'Blauwe bes', 'Avocado'], 
                    isOpen: step == 1 ? true : false, 
                    chosen: chosenFruit.isNotEmpty ? chosenFruit.join(', ') : null,
                    subtext: 'Kies minimaal 1 ingredïent',
                    onTap: (){
                      setState(() {
                        step = 1;
                      });
                    },
                    onNext: (value){
                      final List<String> all = value.split(', ');
                      setState(() {
                        if(all.isNotEmpty && all[0] != ""){
                          chosenFruit = all;
                          step++;
                        }
                      });
                    },
                  ),
                  SmoothieCard(
                    name: "Extra's", 
                    step: 3, 
                    options: ['Proteïnepoeder', 'Chiazaad', 'Honing', 'Spinazie'], 
                    isOpen: step == 2 ? true : false, 
                    chosen: chosenExtras.isNotEmpty ? chosenExtras.join(', ') : null,
                    subtext: 'Je kunt er meerdere selecteren',
                    onTap: (){
                      setState(() {
                        step = 2;
                      });
                    },
                    onNext: (value){
                      final List<String> all = value.split(', ');
                      if(chosenBasis != null && chosenBasis != "" && chosenFruit.isNotEmpty && chosenFruit[0] != ""){
                        setState(() {
                          chosenExtras = all;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderScreen(basis: chosenBasis!, fruit: chosenFruit, extras: chosenExtras,),)
                          );
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SmoothieDrink(
                  amount: 0.55, 
                  color: chosenExtras.isNotEmpty ? AppColors.drinkColors[chosenExtras[0].toLowerCase()] ?? Colors.white : Colors.transparent
                ),
                // SmoothieWave(
                //   height: 160,
                //   color: Colors.red
                // ),
                SmoothieDrink(
                  amount: 0.65, 
                  color: chosenFruit.isNotEmpty ? AppColors.drinkColors[chosenFruit[0].toLowerCase().replaceAll(" ", "")] ?? Colors.white : Colors.transparent
                ),
                // SmoothieWave(
                //   height: 260,
                //   color: Colors.red
                // ),
                SmoothieDrink(
                  amount: 0.8, 
                  color: chosenBasis != null ? AppColors.drinkColors[chosenBasis!.toLowerCase()] ?? Colors.white : Colors.transparent
                ),
                // SmoothieWave(
                //   height: 360,
                //   color: Colors.red
                // ),
                Positioned(
                  bottom: -105,
                  left: 44,
                  child: SizedBox(
                    width: 500,
                    height: 930,
                    child: Image.asset('assets/smoothie_cup_empty.png', fit: BoxFit.cover, opacity: AlwaysStoppedAnimation(0.8),),
                  ),
                ),
              ],
            ),
                // AnimatedContainer(
                //   duration: Duration(milliseconds: 1000),
                //   height: animationheight,
                //   width: 100,
                // )
          ],
        ),
      ),
    );
  }
}
