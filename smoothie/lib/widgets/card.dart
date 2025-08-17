import 'package:flutter/material.dart';
import 'package:smoothie/constants/colors.dart';
import 'package:smoothie/widgets/option.dart';

class SmoothieCard extends StatefulWidget{
  final String name;
  final int step;
  final List<String> options;
  final String? subtext;
  final String? chosen;
  final bool isOpen;
  final VoidCallback onTap;
  final Function(String) onNext;

  const SmoothieCard({super.key, required this.name, required this.step, required this.options, required this.isOpen, this.subtext, this.chosen, required this.onTap, required this.onNext});

  @override
  State<SmoothieCard> createState() => _SmoothieCardState();
}

class _SmoothieCardState extends State<SmoothieCard> {
  List<String> chosen = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: widget.isOpen ? 400 : 350,
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            child: AnimatedSize(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.isOpen ? [
                  Text('Step ${widget.step}', style: TextStyle(
                    color: AppColors.color,
                    fontSize: 18
                  ),),
                  Text(widget.name, style: TextStyle(
                    color: AppColors.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 35
                  ),),
                  // SizedBox(height: 10,),
                  if(widget.subtext != null)
                  Text('${widget.subtext}', style: TextStyle(
                    color: AppColors.color,
                    fontWeight: FontWeight.w200,
                    fontSize: 18
                  ),),
                  // SizedBox(height: 10,),
                  Column(
                    children: List.generate(widget.options.length, (index) => OptionButton(
                      text: widget.options[index],
                      isChosen: chosen.contains(widget.options[index]),
                      onTap: (){
                        if(widget.step == 1){
                          if(chosen.isEmpty){
                            chosen.add(widget.options[index]);
                          }
                          else{
                            chosen.remove(chosen[0]);
                            chosen.add(widget.options[index]);
                          }
                          widget.onNext(widget.options[index]);
                        }
                        else{
                          if(chosen.contains(widget.options[index])){
                            chosen.remove(widget.options[index]);
                          }
                          else{
                            chosen.add(widget.options[index]);
                          }
                        }
                      },
                    ),)
                  ),
                  if(widget.step != 1)
                  SizedBox(
                    width: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        ),
                        onPressed: () => widget.onNext(chosen.join(', ')),
                        child: Text(widget.step == 2 ? "Kies je extra's" : 'Door naar bestellen', style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),),
                      ),
                    ),
                  )
                ] : [
                  Text('Step ${widget.step}', style: TextStyle(
                    color: AppColors.color,
                    fontSize: 18
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.name, style: TextStyle(
                        color: AppColors.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ),),
                      if(widget.chosen != null)
                      SizedBox(
                        width: widget.chosen!.length > 20 ? 150 : null,
                        child: Text('${widget.chosen}', style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}