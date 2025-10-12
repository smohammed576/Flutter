import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:packages/constants/colors.dart';
import 'package:packages/models/film.dart';
import 'package:packages/models/log.dart';
import 'package:packages/models/user.dart';
import 'package:packages/providers/api.dart';
import 'package:packages/providers/database.dart';
import 'package:packages/providers/session.dart';
import 'package:packages/screens/logs.dart';
import 'package:packages/widgets/option.dart';
import 'package:packages/widgets/searchitem.dart';
import 'package:packages/widgets/yellowbutton.dart';
import 'package:quick_actions/quick_actions.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  User? user;
  Film? film;
  bool logFilm = false;
  bool watched = false;
  bool liked = false;
  bool watchlisted = false;
  final DatabaseService databaseService = DatabaseService();
  final SessionService sessionService = SessionService();
  String shortcut = 'none';
  bool showSearchbar = false;
  final TextEditingController queryController = TextEditingController();
  List<Film>? films;

  @override
  void initState() {
    super.initState();
    getUser();
    const QuickActions quickActions = QuickActions();
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_logs', 
        localizedTitle: 'Logs'
      )
    ]);
    quickActions.initialize((String? shortcutType){
      if(shortcutType == null) return;
      switch(shortcutType){
        case 'action_logs':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogsScreen())
          );
      }
      setState(() {
        shortcut = shortcutType;
      });
    });
  }

  void getUser() async {
    final auth = await sessionService.getId();
    if(auth != null){
      final results = await databaseService.retrieveUsers();
      final finduser = results.firstWhere((item) => item.id == auth);
      setState(() {
        user = finduser;
      });
    }
  }

  void getRandomFilm() async {
    final result = await apiService.getRandomFilm();
    setState(() {
      film = result;
    });
  }

  void addLog() async {
    final Log newlog = Log(
      id: film!.id, 
      title: film!.title, 
      poster: film!.poster,
      watched: watched, 
      liked: liked, 
      watchlisted: watchlisted,
      user: user!.id,
      createdAt: DateTime.now()
    );
    await databaseService.insertLog(newlog);
    setState(() {
      logFilm = false;
      watched = false;
      liked = false;
      watchlisted = false;
      getRandomFilm();
    });
  }

  void searchFilm() async {
    final results = await apiService.searchFilms(queryController.text);
    setState(() {
      films = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: AnimatedSize(
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
          reverseDuration: Duration(milliseconds: 500),
          child: SizedBox(
            key: ValueKey(showSearchbar),
            width: showSearchbar ? MediaQuery.sizeOf(context).width * 0.7 : 0,
            child: showSearchbar ? TextField(
              controller: queryController,
              autocorrect: false,
              autofocus: true,
              style: TextStyle(
                color: AppColors.color
              ),
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.yellow)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.yellow)
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.yellow)
                ),
                hintText: 'Type a movie name...',
                suffixIcon: IconButton(
                  onPressed: () => searchFilm(),
                  icon: Icon(Icons.search, color: AppColors.color.withAlpha(200),),
                )
              ),
            ) : null
          ),
        ),
        centerTitle: true,
        actions: [
          SizedBox(
            width: 20,
            child: IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero
              ),
              onPressed: () {
                setState(() {
                  showSearchbar = !showSearchbar;
                });
              },
              icon: Icon(showSearchbar ? Icons.close : Icons.search, color: AppColors.yellow,),
            ),
          ),
          IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogsScreen(),)
            ),
            icon: Icon(Icons.star, color: AppColors.yellow,),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: film != null ? 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        logFilm = true;
                      });
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          child: film!.poster != null && film!.poster != '' ? Image.network('https://image.tmdb.org/t/p/original${film!.poster}', key: ValueKey(film!.id),) : Container(color: AppColors.grey, width: MediaQuery.sizeOf(context).width * 0.8,),
                        ),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 200),
                          // reverse: true,
                          transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation, 
                            child: child,
                          ),
                          child: logFilm ? ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LogOption(
                                        text: 'Watched', 
                                        icon: Icon(watched ? Icons.remove_red_eye : Icons.remove_red_eye_outlined, color: AppColors.color,), 
                                        onTap: () {
                                          setState(() {
                                            watched = !watched;
                                          });
                                        }
                                      ),
                                      LogOption(
                                        text: 'Liked', 
                                        icon: Icon(liked ? Icons.thumb_up : Icons.thumb_up_outlined, color: AppColors.color,), 
                                        onTap: () {
                                          setState(() {
                                            liked = !liked;
                                          });
                                        }
                                      ),
                                      LogOption(
                                        text: 'Watchlist', 
                                        icon: Icon(watchlisted ? Icons.watch_later : Icons.watch_later_outlined, color: AppColors.color,), 
                                        onTap: () {
                                          setState(() {
                                            watchlisted = !watchlisted;
                                          });
                                        }
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  YellowButton(
                                    text: 'LOG', 
                                    onTap: () => addLog()
                                  )
                                ],
                              ),
                            ),
                          )
                        ) : SizedBox.shrink()
                        ),
                      ],
                    ),
                  )
                 : null,
              ),
              SizedBox(height: 20,),
              if(film != null)
              AnimatedTextKit(
                key: ValueKey(film!.id),
                animatedTexts: [
                  TypewriterAnimatedText(film!.title, textStyle: TextStyle(
                    color: AppColors.color
                  ))
                ]
              ),
              SizedBox(height: 20),
              YellowButton(
                text: logFilm ? 'CANCEL' : 'RANDOM', 
                onTap: () {
                  if(logFilm){
                    setState(() {
                      logFilm = false;
                    });
                  } else{
                    getRandomFilm();
                  }
                }
              )
            ],
          ),
          if(films != null && films!.isNotEmpty && showSearchbar)
          Positioned(
            top: kToolbarHeight + 55,
            left: -50,
            right: 0,
            child: Center(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.7,
                height: 250,
                color: AppColors.grey,
                child: ListView.builder(
                  itemCount: films!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = films![index];
                    return SearchItem(
                      film: item, 
                      onTap: (){
                        setState(() {
                          film = item;
                          films = null;
                          queryController.clear();
                          showSearchbar = false;
                        });
                      }
                    );
                  },
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}