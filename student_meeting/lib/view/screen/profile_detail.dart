import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/profileModel.dart';
import '../../viewmodel/mainViewModel.dart';

class ProfileDetail extends StatelessWidget {
  final int index;

  const ProfileDetail({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainViewModel>(context);
    return ProfileListDetail(profile: viewModel.profileList[index]);
  }
}


class ProfileListDetail extends StatelessWidget {
  final ProfileModel profile;
  const ProfileListDetail({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${profile.t_no}')),
    );
  }
}


