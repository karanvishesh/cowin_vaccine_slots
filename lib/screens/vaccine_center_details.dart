import 'package:cowin_vaccine_slots/models/centers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class VaccineCenterDetails extends StatelessWidget {
  VaccineCenterDetails({required this.vaccineCenter});
  VaccineCenter vaccineCenter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              vaccineCenter.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Address: ${vaccineCenter.address}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "State: ${vaccineCenter.state}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "District: ${vaccineCenter.district}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Pincode: ${vaccineCenter.pincode}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Block: ${vaccineCenter.block}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Vaccine: ${vaccineCenter.vaccine}",
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Age:", style: TextStyle(fontSize: 25)),
                Text(
                  "${vaccineCenter.min_age} +",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Available dose 1: ${vaccineCenter.dose1} dose",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Available dose 2: ${vaccineCenter.dose2} dose",
                style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 10,
            ),
            Text(
                vaccineCenter.fee == "0"
                    ? "Price : Free"
                    : "Price : ${vaccineCenter.fee}",
                style: TextStyle(fontSize: 25)),
          ]),
        ),
      )),
    );
  }
}
