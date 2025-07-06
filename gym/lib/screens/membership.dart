import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym/constants/colors.dart';
import 'package:gym/helpers/confirm.helper.dart';
import 'package:gym/models/member/member.dart';
import 'package:gym/models/subscription/type.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  Member? member;
  SubscriptionType? type;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? selectedDate;
  final _formKey = GlobalKey<FormState>();
  String? theme;

  @override
  void initState() {
    super.initState();
    findMember();
    getTheme();
  }

  void getTheme() async {
    await Hive.openBox('theme');
    setState(() {
      theme = Hive.box('theme').get('color');
    });
  }

  void findMember() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    await Hive.openBox('auth');
    final auth = Hive.box('auth').get('username');

    setState(() {
      member = Member.fromJson(data['users'][auth]);
      type = SubscriptionType.fromJson(
        data['subscription_types'][member?.subscription?.type],
      );
      selectedDate = formatDate(member!.dateOfBirth);
      _firstnameController.text = member!.firstname;
      _lastnameController.text = member!.lastname;
      _dateController.text = selectedDate!;
    });
  }

  formatDate(value) {
    final formatString = DateFormat("yyyy-MM-dd").parse(value);
    final date = DateFormat.yMMMMd('en_US').format(formatString);
    return date;
  }

  Future<void> datePicker(BuildContext context) async {
    final today = DateTime.now();
    final ago = int.parse(today.toString().substring(0, 4)) - 16;
    final ageLimit = ago.toString() + today.toString().substring(4, 10);
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(
        ago,
        int.parse(ageLimit.substring(5, 7)),
        int.parse(ageLimit.substring(8, 10)),
      ),
    );

    if (picked != null) {
      if (formatDate(picked.toString()) != selectedDate) {
        setState(() {
          selectedDate = formatDate(picked.toString());
          _dateController.text = selectedDate!;
        });
      }
    }
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
                onTap: () => Navigator.of(context).pop(),
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
                'Membership',
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              color: LightColors.lightColors[theme],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Member Details',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appColors[theme],
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                dialogBuilder(context, theme);
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _firstnameController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your name';
                          } else if (value.length > 15) {
                            return 'Name is too long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            'assets/Icons/Person.svg',
                            width: 25,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusColor:
                              AppColors.appColors[theme] ?? Colors.green,
                          label: Text('First name'),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _lastnameController,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your name';
                          } else if (value.length > 15) {
                            return 'Name is too long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            'assets/Icons/Person.svg',
                            width: 25,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusColor:
                              AppColors.appColors[theme] ?? Colors.green,
                          label: Text('Last name'),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _dateController,
                        onTap: () => datePicker(context),
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            'assets/Icons/Today.svg',
                            width: 25,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 50,
                            minHeight: 25,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.appColors[theme] ?? Colors.green,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusColor:
                              AppColors.appColors[theme] ?? Colors.green,
                          label: Text('Date of Birth'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Card(
                color: LightColors.lightColors[theme] ?? Colors.green,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Subscription Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${member?.subscription?.type[0].toUpperCase()}${member?.subscription?.type.substring(1)} Subscription',
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Expires on ${formatDate(member!.subscription!.expiration)}',
                      ),
                      SizedBox(height: 5),
                      Text('${type?.price} €/month'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
