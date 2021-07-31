import 'package:cowin_vaccine_slots/screens/vaccine_center_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindSlotButton extends StatelessWidget {
  const FindSlotButton({
    Key? key,
    required this.selectedDistrict,
  }) : super(key: key);

  final int selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        pressedOpacity: 0.7,
        color: Colors.red,
        child: Text("FIND A SLOT"),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return VaccineCenterScreen(
              districtId: selectedDistrict,
            );
          }));
        });
  }
}
