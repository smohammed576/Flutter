import 'package:flutter/material.dart';
import 'package:gym/constants/colors.dart';
import 'package:gym/screens/home.dart';
import 'package:hive/hive.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  String? theme;
  List<String> colors = [
    'green',
    'purple',
    'blue',
    'red',
    'orange',
    'black',
    'pink',
    'pretty',
  ];

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  void getTheme() async {
    await Hive.openBox('theme');
    setState(() {
      theme = Hive.box('theme').get('color');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Image.asset(
                  'assets/Icon.png',
                  color: theme != 'green'
                      ? BlendColors.blendColors[theme]
                      : null,
                  colorBlendMode: BlendMode.color,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Themes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.appColors[theme],
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pick a theme color here:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await Hive.openBox('theme');
                      await Hive.box('theme').put('color', colors[index]);
                      setState(() {
                        theme = Hive.box('theme').get('color');
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/Icon.png',
                            height: 50,
                            width: 50,
                            color: colors[index] != 'green'
                                ? BlendColors.blendColors[colors[index]]
                                : null,
                            colorBlendMode: BlendMode.color,
                          ),
                          SizedBox(width: 20),
                          Text(
                            colors[index].substring(0, 1).toUpperCase() +
                                colors[index].substring(
                                  1,
                                  colors[index].length,
                                ),
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.appColors[colors[index]],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
