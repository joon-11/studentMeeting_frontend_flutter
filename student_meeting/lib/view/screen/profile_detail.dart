import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_meeting/view/screen/reservation_screen.dart';

import '../../model/profileModel.dart';
import '../../viewmodel/mainViewModel.dart';

class ProfileDetail extends StatelessWidget {
  final int index;

  String photo;

  ProfileDetail({super.key, required this.index, required this.photo});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context);
    return ProfileListDetail(
      profile: viewModel.profileList[index],
      photo: photo,
    );
  }
}

class ProfileListDetail extends StatelessWidget {
  final ProfileModel profile;

  final String photo;

  const ProfileListDetail(
      {super.key, required this.profile, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("선생님 소개"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(photo),
                backgroundColor: CupertinoColors.inactiveGray,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade100,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "선생님 정보",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        title: Text(
                          "이름 - ${profile.t_name}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "과목 - ${profile.t_lib}",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          "설명",
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          "${profile.t_exp}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationScreen(
                        profile: profile,
                      ),
                    ));
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.blue), // Background color
              ),
              child: Container(
                height: 80,
                width: 300,
                child: Center(
                  child: Text(
                    "${profile.t_lib} 수업 예약하기!",
                    style: const TextStyle(fontSize: 25, color: Colors.black),
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
