import 'dart:convert';

import 'package:cowin_vaccine_slots/models/states.dart';
import 'package:cowin_vaccine_slots/screens/vaccine_center_screens.dart';
import 'package:cowin_vaccine_slots/widgets/find_slot_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  States statesList = States();
  List<Center> districtList = [];
  List districtID = [];
  static final ctrl = FixedExtentScrollController(initialItem: 0);
  int selectedState = 1;
  int selectedDistrict = 3;
  TextStyle styleTxt = TextStyle(color: Colors.white);
  getDistrict() async {
    var response = await http.get(Uri.https(
        "cdn-api.co-vin.in", "api/v2/admin/location/districts/$selectedState"));
    var data = jsonDecode(response.body);
    districtList.clear();
    districtID.clear();
    for (var district in data["districts"]) {
      setState(() {
        districtList.add(Center(child: Text(district["district_name"])));
        districtID.add(district["district_id"]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    districtList = [
      Center(child: Text("Nicobar")),
      Center(child: Text("North and Middle Andaman")),
      Center(child: Text("South Andaman")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Cowin Vaccine Slot Finder"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Text(
                "Select State",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              selectState(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Select District",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              selectDistrict(),
              SizedBox(
                height: 20,
              ),
              FindSlotButton(selectedDistrict: selectedDistrict),
            ]),
          ),
        ),
      ),
    );
  }

  Container selectDistrict() {
    return Container(
      height: 200,
      color: Colors.red,
      child: CupertinoPicker.builder(
          childCount: districtList.length,
          scrollController: ctrl,
          itemExtent: 40,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedDistrict = districtID[index];
            });
          },
          itemBuilder: (context, index) {
            if (districtList.isEmpty) {
              return CupertinoActivityIndicator();
            }
            return districtList[index];
          }),
    );
  }

  Container selectState() {
    return Container(
      height: 170,
      child: CupertinoPicker(
        backgroundColor: Colors.red,
        itemExtent: 55,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedState = statesList.states[index]["state_id"];
          });
          getDistrict();
        },
        children: [
          for (var state in statesList.states)
            Center(
                child: Text(
              state["state_name"],
            )),
        ],
      ),
    );
  }
}
