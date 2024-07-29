import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_meeting/model/profileModel.dart';
import 'package:student_meeting/view/screen/profile_detail.dart';
import '../../viewmodel/mainViewModel.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context);

    return ProfileListScreen(profiles: viewModel.profileList);
  }
}

class ProfileListScreen extends StatelessWidget {
  final List<ProfileModel> profiles;

  const ProfileListScreen({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상담가능 선생님'),
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final ProfileModel profile = profiles[index];
          List photo = [
            'lib/images/루피.webp',
            'lib/images/조로.webp',
            'lib/images/나미.webp',
            'lib/images/우솝.webp',
            'lib/images/상디.jpeg',
            'lib/images/쵸파.webp'
          ];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: CupertinoColors.inactiveGray,
                backgroundImage: AssetImage(photo[index]),
              ),
              title: Text(
                profile.t_name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                '${profile.t_lib} - ${profile.t_gender}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // context.push('/profileDetail/$index');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDetail(
                      index: index,
                      photo: photo[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
