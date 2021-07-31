class VaccineCenter {
  VaccineCenter({
    required this.name,
    required this.address,
    required this.feeType,
    required this.vaccine,
    required this.fee,
    this.min_age = "18",
    this.max_age = "100",
    required this.from,
    required this.to,
    required this.date,
    required this.dose1,
    required this.dose2,
    required this.block,
    required this.district,
    required this.slots,
    required this.state,
    required this.pincode,
  });
  String name;
  String address;
  String feeType;
  String fee;
  String vaccine;
  String min_age;
  String max_age;
  String from;
  String to;
  String date;
  String dose1;
  String dose2;
  String district;
  String state;
  String block;
  List slots;
  String pincode;
}

// class Session {
//     Session({
//         required this.centerId,

//         required this.address,
//         @required this.stateName,
//         @required this.districtName,
//         required this.blockName,
//         required this.pincode,
//         required this.from,
//         required this.to,
//       @required this.lat,
//         @required this.long,
//
//         @required this.sessionId,
//         @required this.date,
//         @required this.availableCapacity,
//         @required this.availableCapacityDose1,
//         @required this.availableCapacityDose2,
//         @required this.fee,
//         @required this.allowAllAge,
//         @required this.minAgeLimit,
//         @required this.vaccine,
//         @required this.slots,
//         @required this.maxAgeLimit,
//     });

// int centerId;

// StateName stateName;
// DistrictName districtName;
// String blockName;
// int pincode;
// String from;
// String to;
// int lat;
// int long;
// FeeType feeType;
// String sessionId;
// Date date;
// int availableCapacity;
// int availableCapacityDose1;
// int availableCapacityDose2;
// String fee;
// bool allowAllAge;
// int minAgeLimit;
// Vaccine vaccine;
// List<String> slots;
// int maxAgeLimit;
