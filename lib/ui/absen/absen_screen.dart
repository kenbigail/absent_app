import 'package:absents_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsenScreen extends StatefulWidget {
  const AbsenScreen({super.key});

  @override
  State<AbsenScreen> createState() => _AbsenScreenState();
}

class _AbsenScreenState extends State<AbsenScreen> {
  final CollectionReference dataCollection =
  FirebaseFirestore.instance.collection('attendance_app');
  final controllerName = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();
  String dropValueCategories = "Please choose";
  var categoriesList = <String>["Please choose", "Sick", "Permission", "Other"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Request Permision",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(
                        10), // Tambahkan tanda kurung tutup di sini
                  ),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.maps_home_work_outlined),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Please fill out the form',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  controller: controllerName,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Your name",
                    labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
                    hintText: "Enter your name",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent, width: 1.0)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    value: dropValueCategories,
                    items: categoriesList.map((value) {
                      return DropdownMenuItem(
                        value: value, // Tambahkan nilai untuk properti 'value'
                        child: Text(
                          value.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropValueCategories = value.toString();
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 14,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                    underline: Container(
                      color: Colors.transparent,
                      height: 2,
                    ),
                    isExpanded: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    const Text(
                      "From:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: TextField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          onPrimary: Colors.white,
                                          onSurface: Colors.white,
                                          primary: Colors.blueAccent),
                                      datePickerTheme: const DatePickerThemeData(
                                          headerBackgroundColor: Colors.blueAccent,
                                          backgroundColor: Colors.white)),
                                  child: child!,
                                );
                              },
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(9999),
                            );
                            if (pickedDate != null) {
                              fromController.text =
                                  DateFormat('DD-MM-YYYY').format(pickedDate);
                            }
                          },
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          controller: fromController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              hintText: "Starting From",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              )),
                        )),
                    Expanded(
                        child: Row(
                          children: [
                            const Text(
                              "Until",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Expanded(
                                child: TextField(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      builder: (BuildContext context, Widget? child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                              colorScheme: const ColorScheme.light(
                                                  onPrimary: Colors.white,
                                                  onSurface: Colors.white,
                                                  primary: Colors.blueAccent),
                                              datePickerTheme: const DatePickerThemeData(
                                                  headerBackgroundColor:
                                                  Colors.blueAccent,
                                                  backgroundColor: Colors.white)),
                                          child: child!,
                                        );
                                      },
                                      context: context,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(9999),
                                    );
                                    if (pickedDate != null) {
                                      toController.text =
                                          DateFormat('DD-MM-YYYY').format(pickedDate);
                                    }
                                  },
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  controller: toController,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      hintText: "to",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      )),
                                ))
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(30),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 50,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent,
                      child: InkWell(
                        splashColor: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          if (controllerName.text.isEmpty || dropValueCategories == "Please choose:" || fromController.text.isEmpty || toController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    'Ups Please fill out the form',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.blueAccent,
                              shape: StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }else{
                            submitAbsen(controllerName.text.toString(), dropValueCategories.toString(), String, fromController.text, toController.text);
                          }
                        },
                        child: const Center(
                          child: Text("Make a request", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),

                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitAbsen(
      String name,
      String reason,
      String,
      from,
      String until,
      ) async {
    showLoaderDialog(context);
    dataCollection.add({
      'address': '-',
      'name': name,
      'reason': reason,
      'dateTime': '$from - $until',
    }).then((result) {
      Navigator.of(context).pop();
      try {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Colors.red,
              ),
              Text(
                'Your data has been submitted',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Colors.blueGrey,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text(
                'Ups! something went wrong',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Colors.blueGrey,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
          ),
          Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text("checking data...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}