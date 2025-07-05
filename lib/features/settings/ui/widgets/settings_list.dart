import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshd/core/mycore/di/service_locator.dart';
import 'package:morshd/features/profile/ui/profile_screen.dart';
import 'package:morshd/features/settings/logic/update_pass_cubit/update_pass_cubit.dart';
import 'package:morshd/features/settings/ui/widgets/contact_support_screen.dart';
import 'package:morshd/features/settings/ui/widgets/faq_screen.dart';
import 'package:morshd/features/settings/ui/widgets/update_password_screen.dart';
import '../../../../core/mycore/helper/constants.dart';
import '../../../../core/mycore/helper/shared_pref_helper.dart';
import '../../../../core/mycore/logic/user_cubit/user_cubit.dart';
import '../../../../core/mycore/networking/dio_factory.dart';
import '../../../sign_in_screen/ui/sign_in_screen.dart';
import 'create_report_pop_up.dart';
import 'show_logout_confirmation_dialog.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>().state.user;
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      children: [
        Text('Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffDF713D),
            )),
        const SizedBox(height: 8),
        _buildSettingTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => getIt<UpdatePassCubit>(),
                  child: const UpdatePasswordScreen(),
                ),
              ),
            );
          },
        ),
        _buildSettingTile(
          icon: Icons.person_outline,
          title: 'Edit Profile',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            );
          },
        ),
        SizedBox(height: 24.h),
        Text('Preferences & Advanced',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffDF713D),
            )),
        SizedBox(height: 8.h),
        _buildSettingTile(
          icon: Icons.feedback_outlined,
          title: 'Send Feedback',
          onTap: () {
            createReportPopup(context, userCubit!);
          },
        ),
        _buildSettingTile(
          icon: Icons.support_agent_outlined,
          title: 'Contact Support',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ContactSupportScreen(),
              ),
            );
          },
        ),
        _buildSettingTile(
          icon: Icons.info_outline,
          title: 'FAQ',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const FAQScreen(),
              ),
            );
          },
        ),
        _buildSettingTile(
          icon: Icons.logout,
          title: 'Log Out',
          iconColor: Color(0xffD9163A),
          textColor: Color(0xffD9163A),
          onTap: () async {
            final shouldLogout = await showLogoutConfirmationDialog(context);
            if (shouldLogout == true) {
              await logout(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    String? svgAssetPath,
    IconData? icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: svgAssetPath != null
            ? SvgPicture.asset(
                svgAssetPath,
                color: iconColor,
                width: 24,
                height: 24,
              )
            : Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await SharedPrefHelper.removeSecuredData(SharedPrefKeys.userToken);
    DioFactory.removeTokenFromHeader();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SignInScreen()));
  }
}
