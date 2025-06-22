import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/request/request.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:snackswap/models/user/user.dart';
import 'package:uuid/uuid.dart';

class SwapScreen extends StatefulWidget {
  final Snack snack;
  const SwapScreen({required this.snack, super.key});

  @override
  State<SwapScreen> createState() => _SwapScreenState();
}

class _SwapScreenState extends State<SwapScreen> {
  User? user;
  Snack? selectedSnack;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  void findUser() async {
    await Hive.openBox<User>('users');
    final data = Hive.box<User>('users');

    final getUser = data.values.firstWhere(
      (item) => item.id == widget.snack.userId,
    );

    setState(() {
      user = getUser;
    });
  }

  void sendRequest(Request request) async {
    await Hive.openBox<Request>('requests');
    final requests = Hive.box<Request>('requests');
    await requests.add(request);
  }

  void openBottomSheet() async {
    final snacks = Hive.box<Snack>('snacks');
    final user = Hive.box('auth').get('id');

    final findSnacks = snacks.values
        .where((item) => item.userId == user)
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected a snack',
              style: GoogleFonts.fredoka(
                color: AppColors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: findSnacks.length,
                itemBuilder: (context, index) {
                  final Snack snack = findSnacks[index];
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedSnack = snack;
                        Navigator.pop(context);
                      });
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                        color: AppColors.beige,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/${snack.image}',
                        width: 50,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(
                      snack.name,
                      style: GoogleFonts.fredoka(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Let's swap",
              style: GoogleFonts.fredoka(
                fontSize: 45,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    user == null
                        ? CircularProgressIndicator()
                        : Text(
                            'Swap with ${user?.name}',
                            style: GoogleFonts.fredoka(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                    SizedBox(height: 10),
                    Image.asset('assets/images/arrow.png'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  'assets/images/${widget.snack.image}',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                widget.snack.name,
                                style: GoogleFonts.fredoka(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            selectedSnack == null
                                ? Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: AppColors.beige,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          openBottomSheet();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: AppColors.orange,
                                          size: 20,
                                          weight: 100,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: AppColors.beige,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset(
                                        'assets/images/${selectedSnack?.image}',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                '${selectedSnack?.name}',
                                style: GoogleFonts.fredoka(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                ),
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Transform.flip(
                      flipX: true,
                      flipY: true,
                      child: Image.asset('assets/images/arrow.png'),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        ),
                        onPressed: () {
                          final id = Hive.box('auth').get('id');
                          if (selectedSnack != null) {
                            final request = Request(
                              id: const Uuid().v4(),
                              user: id,
                              sendUser: widget.snack.userId,
                              snack: selectedSnack!.id,
                              requestSnack: widget.snack.id,
                              status: Status.pending
                            );
                            sendRequest(request);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Send request',
                          style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
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
