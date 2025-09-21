import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focusskills/constants/colors.dart';
import 'package:focusskills/widgets/leadingbutton.dart';
import 'package:focusskills/widgets/sleep/opacitybutton.dart';
import 'package:just_audio/just_audio.dart';

final AudioPlayer player = AudioPlayer();

class PlayScreen extends StatefulWidget{
  final String title;
  final String subtitle;
  final bool isLight;
  const PlayScreen({super.key, required this.title, required this.subtitle, required this.isLight});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isPlaying = false;

  @override
  void initState(){
    super.initState();
    if(!player.playing){
      player.setAsset('assets/audio/meditation-music.mp3');
    }
  }

  void togglePause(){
    if(player.playing){
      player.pause();
    }
    else{
      player.play();
    }
    setState(() {
      isPlaying = player.playing;
    });
  }

  void fifteenSeconds(bool hasSkipped) async{
    if(hasSkipped){
      if(player.duration! - player.position >= Duration(seconds: 15)){
        final plusFifteen = player.position + Duration(seconds: 15);
        await player.seek(plusFifteen);
      }
      else{
        player.seek(Duration(seconds: player.duration!.inSeconds));
      }
    }
    else{
      if(player.position > Duration(seconds: 15)){
        final minusFifteen = player.position - Duration(seconds: 15);
        await player.seek(minusFifteen);
      }
      else{
        player.seek(Duration.zero);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isLight ? AppColors.beigeBackground : AppColors.darkblue,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 80,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: LeadingButton(
            isClose: true,
            hasOutline: true, 
            onTap: () => Navigator.of(context).pop()
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        actions: [
          OpacityButton(
            icon: 'assets/icons/heart_white.svg', 
            onTap: (){}
          ),
          SizedBox(width: 10,),
          OpacityButton(
            icon: 'assets/icons/download_white.svg', 
            onTap: (){}
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SvgPicture.asset('assets/backgrounds/${widget.isLight ? 'play_background_light' : 'play_background'}.svg'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 180, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.title, style: TextStyle(
                  color: widget.isLight ? AppColors.color : AppColors.lightcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),),
                SizedBox(height: 10,),
                Text(widget.subtitle, style: TextStyle(
                  color: widget.isLight ? AppColors.color.withAlpha(150) : AppColors.lightcolor.withAlpha(150),
                  fontWeight: FontWeight.w600,
                  fontSize: 14
                ),),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero
                      ),
                      onPressed: () => fifteenSeconds(false),
                      icon: SvgPicture.asset('assets/icons/rewind.svg', colorFilter: widget.isLight ? ColorFilter.mode(AppColors.darkgrey, BlendMode.srcIn) : null,),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero
                      ),
                      onPressed: () => togglePause(),
                      icon: SvgPicture.asset('assets/icons/${widget.isLight ? 'pause_dark' : 'pause'}.svg'),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero
                      ),
                      onPressed: () => fifteenSeconds(true),
                      icon: SvgPicture.asset('assets/icons/skip.svg', colorFilter: widget.isLight ? ColorFilter.mode(AppColors.darkgrey, BlendMode.srcIn) : null,),
                    )
                  ],
                ),
                SizedBox(height: 40,),
                SizedBox(
                  height: 25,
                  child: StreamBuilder<Duration>(
                  stream: player.positionStream, 
                  builder: (context, snapshot) {
                    Duration position = snapshot.data ?? Duration.zero;
                    Duration total = player.duration ?? Duration.zero;
                    return SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 1.5,
                        inactiveTrackColor: widget.isLight ? AppColors.color.withAlpha(50) : AppColors.lightcolor.withAlpha(50),
                        activeTrackColor: widget.isLight ? AppColors.color : AppColors.lightcolor,
                        thumbColor: widget.isLight ? AppColors.color : AppColors.purple,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5)
                      ),
                      child: Slider(
                        value: position.inSeconds.toDouble(),
                        max: total.inSeconds.toDouble(), 
                        onChanged: (value){
                          player.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    );
                  },
                ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${player.position == null ? '00' : player.position!.inMinutes}:${player.position == null ? '00' : player.position!.inSeconds % 60}', style: TextStyle(
                        color: widget.isLight ? AppColors.color : AppColors.lightcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),),
                      Text('${player.duration == null ? '00' : player.duration!.inMinutes}:${player.duration == null ? '00' : player.duration!.inSeconds % 60}', style: TextStyle(
                        color: widget.isLight ? AppColors.color : AppColors.lightcolor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}