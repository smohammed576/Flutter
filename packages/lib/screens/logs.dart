import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packages/constants/colors.dart';
import 'package:packages/models/log.dart';
import 'package:packages/models/user.dart';
import 'package:packages/providers/database.dart';
import 'package:packages/providers/session.dart';
import 'package:packages/screens/login.dart';
import 'package:packages/widgets/textbutton.dart';
import 'package:video_player/video_player.dart';

class LogsScreen extends StatefulWidget{
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<Log>? logs;
  final DatabaseService databaseService = DatabaseService();
  final SessionService sessionService = SessionService();
  User? user;
  bool playVideo = false;
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    getUser();
    getLogs();
    videoController = VideoPlayerController.asset('assets/mp4/svu.MP4')..initialize().then((_){
      setState(() {
        
      });
    });
    videoController.setLooping(true);
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void getUser() async {
    final auth = await sessionService.getId();
    if(auth != null){
      final users = await databaseService.retrieveUsers();
      final finduser = users.firstWhere((item) => item.id == auth);
      setState(() {
        user = finduser;
      });
    }
  }

  void getLogs() async {
    final results = await databaseService.retrieveLogs();
    final auth = await sessionService.getId();
    setState(() {
      logs = results.where((item) => item.user == auth).toList();
    });
  }

  String formatDate(date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  void signout() async {
    await sessionService.logout();
    setState(() {
      user = null;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(),)
      );
    });
  }

  void toggleVideo(){
    setState(() {
      videoController.value.isPlaying ? videoController.pause() : videoController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.chevron_left, color: AppColors.color, size: 30,),
        ),
        actions: [
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero
            ),
            onPressed: () {
              toggleVideo();
              setState(() {
                playVideo = !playVideo;
              });
            },
            icon: Icon(playVideo ? Icons.pause : Icons.play_arrow, color: AppColors.yellow,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              if(user != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if(user!.image != null && user!.image != '')
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.asset('assets/images/${user!.image}', width: 55, height: 55, fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user!.username, style: TextStyle(
                            color: AppColors.color,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                          Text('${logs!.length} ${logs!.length == 1 ? 'film' : 'films'} logged', style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 12
                          ),)
                        ],
                      )
                    ],
                  ),
                  BlueTextButton(
                    text: 'Sign out',
                    color: AppColors.red, 
                    onTap: () => signout()
                  )
                ],
              ),
              SizedBox(height: 20),
              if(playVideo)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('random video van mn telefoon, maar kijk het werkt!', style: TextStyle(
                    color: AppColors.color,
                    fontSize: 12
                  ),),
                  AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
                    child: VideoPlayer(videoController),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Column(
                children: logs != null && logs!.isNotEmpty ? 
                  List.generate(logs!.length, (index) {
                    final item = logs![index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                color: item.poster != null && item.poster != '' ? null : AppColors.background,
                                width: 40,
                                height: 60,
                                child: item.poster != null && item.poster != '' ? Image.network('https://image.tmdb.org/t/p/original${item.poster}', fit: BoxFit.cover,) : null
                              ),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(item.title, style: TextStyle(
                                      color: AppColors.color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(formatDate(item.createdAt), style: TextStyle(
                                    color: AppColors.yellow,
                                    fontSize: 12
                                  ),)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if(item.watched)
                              Icon(Icons.remove_red_eye, color: AppColors.yellow, size: 20,),
                              SizedBox(width: 10,),
                              if(item.liked)
                              Icon(Icons.thumb_up, color: AppColors.yellow, size: 20,),
                              SizedBox(width: 10,),
                              if(item.watchlisted)
                              Icon(Icons.watch_later, color: AppColors.yellow, size: 20,),
                            ],
                          )
                        ],
                      ),
                    );
                  },)
                 : []
              ),
            ],
          ),
        ),
      ),
    );
  }
}