import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:snackswap/constants/colors.dart';
import 'package:snackswap/models/request/request.dart';
import 'package:snackswap/models/snack/snack.dart';
import 'package:snackswap/models/swap/swap.dart';
import 'package:snackswap/models/user/user.dart';

class SwapsScreen extends StatefulWidget {
  const SwapsScreen({super.key});

  @override
  State<SwapsScreen> createState() => _SwapsScreenState();
}

class _SwapsScreenState extends State<SwapsScreen> {
  List<Swap> newRequests = [];
  List<Swap> pendingRequests = [];
  List<Swap> myRequests = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    checkRequests();

    Hive.box<Request>('requests').listenable().addListener(() {
      checkRequests();
    });
  }

  void checkRequests() async {
    await Hive.openBox<Request>('requests');
    await Hive.openBox<User>('users');
    await Hive.openBox<Snack>('snacks');
    final requests = Hive.box<Request>('requests');
    final users = Hive.box<User>('users');
    final snacks = Hive.box<Snack>('snacks');
    final id = Hive.box('auth').get('id');

    List<Swap> findMyData = [];

    final findData = requests.values.where(
      (item) => item.user == id && item.status != Status.pending,
    );
    for (final item in findData) {
      final user = users.values.firstWhere(
        (value) => value.id == item.sendUser,
      );
      final snack = snacks.values.firstWhere(
        (value) => value.id == item.requestSnack,
      );
      final mySnack = snacks.values.firstWhere(
        (value) => value.id == item.snack,
      );

      findMyData.add(
        Swap(
          request: item,
          username: user.name,
          pfp: user.image,
          snackname: snack.name,
          image: snack.image,
          snack: mySnack.name,
        ),
      );
    }

    List<Swap> findPendingData = [];

    final findPending = requests.values
        .where((item) => item.user == id && item.status == Status.pending)
        .toList();

    for (final item in findPending) {
      final user = users.values.firstWhere(
        (value) => value.id == item.sendUser,
      );
      final snack = snacks.values.firstWhere(
        (value) => value.id == item.requestSnack,
      );
      final mySnack = snacks.values.firstWhere(
        (value) => value.id == item.snack,
      );

      findPendingData.add(
        Swap(
          request: item,
          username: user.name,
          pfp: user.image,
          snackname: snack.name,
          image: snack.image,
          snack: mySnack.name,
        ),
      );
    }

    List<Swap> findNewData = [];
    final findNew = requests.values
        .where(
          (item) =>
              item.sendUser == id &&
              item.status != Status.cancelled &&
              item.status == Status.pending,
        )
        .toList();
    for (final item in findNew) {
      final user = users.values.firstWhere((value) => value.id == item.user);
      final snack = snacks.values.firstWhere((value) => value.id == item.snack);
      final mySnack = snacks.values.firstWhere(
        (value) => value.id == item.requestSnack,
      );

      findNewData.add(
        Swap(
          request: item,
          username: user.name,
          pfp: user.image,
          snackname: mySnack.name,
          image: mySnack.image,
          snack: snack.name,
        ),
      );
    }

    setState(() {
      pendingRequests = findPendingData;
      newRequests = findNewData;
      myRequests = findMyData;
    });
  }

  Future<void> updateStatus(Swap swap, Status status) async {
    final data = Hive.box<Request>('requests');
    final users = Hive.box<User>('users');
    final snacks = Hive.box<Snack>('snacks');
    final request = swap.request;

    final key = data.keys.firstWhere((item) => data.get(item) == request);
    final sendUpdate = Request(
      id: request.id,
      user: request.user,
      sendUser: request.sendUser,
      snack: request.snack,
      requestSnack: request.requestSnack,
      status: status,
    );
    await data.put(key, sendUpdate);

    if (status == Status.accepted) {
      final snack = snacks.values.firstWhere(
        (item) => item.id == request.snack,
      );
      final requested = snacks.values.firstWhere(
        (item) => item.id == request.requestSnack,
      );

      snack.isSwapped = true;
      await snack.save();

      requested.isSwapped = true;
      await requested.save();

      final user = users.values.firstWhere((item) => item.id == request.user);
      final senduser = users.values.firstWhere(
        (item) => item.id == request.sendUser,
      );

      user.swaps += 1;
      await user.save();

      senduser.swaps += 1;
      await senduser.save();
    }

    checkRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brown,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Text(
              'Swaps',
              style: GoogleFonts.fredoka(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontSize: 50,
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
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your requests',
                    style: GoogleFonts.fredoka(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: myRequests.length,
                      itemBuilder: (context, index) {
                        final Swap item = myRequests[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xCEF5C989),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.orange,
                              child: Image.asset(
                                'assets/images/${item.image}',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            title: Text(
                              '${item.username} ${item.request.status.toString().substring(7, 15)} your offer of ${item.snack} traded for ${item.snackname}',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'New requests',
                    style: GoogleFonts.fredoka(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: newRequests.length,
                      itemBuilder: (context, index) {
                        final Swap item = newRequests[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xCEF5C989),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.orange,
                              child: Image.asset(
                                'assets/images/${item.pfp}',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            title: Text(
                              '${item.username} wants your ${item.snackname} in trade for ${item.snack}',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue,
                                  ),
                                  onPressed: () async {
                                    await updateStatus(item, Status.accepted);
                                  },
                                  child: Text(
                                    'Accept',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue,
                                  ),
                                  onPressed: () async {
                                    await updateStatus(item, Status.declined);
                                  },
                                  child: Text(
                                    'Decline',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    'Pending requests',
                    style: GoogleFonts.fredoka(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: pendingRequests.length,
                      itemBuilder: (context, index) {
                        final Swap item = pendingRequests[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xCEF5C989),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.orange,
                              child: Image.asset(
                                'assets/images/${item.image}',
                                width: 80,
                                height: 80,
                              ),
                            ),
                            title: Text(
                              'You want to trade ${item.snackname} with ${item.username} with your ${item.snack}',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                              ),
                              onPressed: () async {
                                await updateStatus(item, Status.cancelled);
                              },
                              child: Text(
                                'Cancel request',
                                style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
