import 'package:flutter/material.dart';
import 'package:parcel/models/driver.dart';
import 'package:parcel/widgets/progress.dart';

class ParcelHelpers{
  static Future showProgressBottomSheet(BuildContext context, Driver driver) async {
    return showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, 
      builder: (context) => ProgressBottomSheet(driver: driver),
    );
  }
}