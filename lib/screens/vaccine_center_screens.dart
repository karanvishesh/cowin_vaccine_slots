import 'dart:convert';

import 'package:cowin_vaccine_slots/models/centers.dart';
import 'package:cowin_vaccine_slots/screens/vaccine_center_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VaccineCenterScreen extends StatefulWidget {
  VaccineCenterScreen({this.districtId = 392});
  final int districtId;

  @override
  _VaccineCenterScreenState createState() => _VaccineCenterScreenState();
}

class _VaccineCenterScreenState extends State<VaccineCenterScreen> {
  var day = DateTime.now().day.toString().padLeft(2, "0");
  var month = DateTime.now().month.toString().padLeft(2, "0");
  var year = DateTime.now().year.toString();
  List<VaccineCenter> centerList = [];
  Future getCenter() async {
    var date = day + "-" + month + "-" + year;
    Uri uri = Uri.parse(
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=${widget.districtId}&date=$date");
    var header = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36'
    };
    var response = await http.get(uri, headers: header);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      centerList.clear();
      for (var center in data["sessions"]) {
        setState(() {
          center["available_capacity"] > 1
              ? centerList.add(VaccineCenter(
                  name: center["name"],
                  address: center["address"],
                  feeType: center["fee_type"],
                  vaccine: center["vaccine"],
                  date: center["date"],
                  fee: center["fee"],
                  dose1: center["available_capacity_dose1"].toString(),
                  dose2: center["available_capacity_dose2"].toString(),
                  from: center["from"],
                  to: center["to"],
                  min_age: center["min_age_limit"] == null
                      ? "18"
                      : center["min_age_limit"].toString(),
                  max_age: center["max_age_limit"] == null
                      ? "80"
                      : center["max_age_limit"].toString(),
                  block: center["block_name"],
                  state: center["state_name"],
                  district: center["district_name"],
                  slots: center["slots"],
                  pincode: center["pincode"].toString(),
                ))
              : null;
        });
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getCenter();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.red,
          title: Text("Cowin Vaccine Slot Finder"),
        ),
        body: Column(
          children: [
            Expanded(
              child: centerList.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Sorry no vacant slots available\n right now at this location.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        )),
                        CupertinoActivityIndicator(
                          radius: 20,
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: centerList.length,
                      itemBuilder: (context, index) => CenterTile(
                        centerList: centerList,
                        index: index,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class CenterTile extends StatelessWidget {
  const CenterTile({
    Key? key,
    required this.centerList,
    required this.index,
  }) : super(key: key);

  final List<VaccineCenter> centerList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        visualDensity: VisualDensity(vertical: 1.8),
        title: Text(centerList[index].name),
        subtitle: Text(
          centerList[index].address,
        ),
        trailing: Column(
          children: [
            Text(
              centerList[index].feeType,
            ),
            centerList[index].fee == "0"
                ? Text("")
                : Text(
                    "₹ ${centerList[index].fee}",
                  )
          ],
        ),
        leading: Column(
          children: [Text("Age"), Text("${centerList[index].min_age} +")],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VaccineCenterDetails(
                      vaccineCenter: centerList[index],
                    )));
      },
    );
  }
}
