import 'package:absents_app/ui/absen/absen_screen.dart';
import 'package:absents_app/ui/attend/attend_screen.dart';
import 'package:absents_app/ui/attendance_history/attendance_history.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          _onWillPop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AttendScreen()));
                      },
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/ic_absen.png'),
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            'Hadir',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AbsenScreen()));
                      },
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/ic_leave.png'),
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            'Izin / Cuti',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AttendanceHistoryScreen()));
                      },
                      child: const Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/ic_history.png'),
                            width: 100,
                            height: 100,
                          ),
                          Text(
                            'History',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ));
  }
}

Future<bool> _onWillPop(BuildContext context) async {
  return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("INFO"),
                content: const Text("Apakah anda yakin ingin keluar app?"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Batal")),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Keluar")),
                ],
              ))) ??
      false;
}
