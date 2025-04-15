import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ylj_flutter/constant/colors.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '로그인',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: 구글 로그인 구현
            },
            icon: SvgPicture.asset(
              'assets/images/login/google_logo.svg',
              height: 24,
            ),
            label: const Text('Google로 계속하기'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: 애플 로그인 구현
            },
            icon: SvgPicture.asset(
              'assets/images/login/apple_logo.svg',
              height: 24,
            ),
            label: const Text('Apple로 계속하기'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
