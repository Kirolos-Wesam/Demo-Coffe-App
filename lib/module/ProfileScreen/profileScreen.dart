import 'package:coffeeapp/module/ProfileScreen/cubit/profile_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        return Column(
          children: [
             
          ],
        );
      },
    );
  }
}
