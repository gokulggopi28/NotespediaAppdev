import 'package:notespedia/utils/constants/app_export.dart';

import '../../../../models/user_profile.dart';
import '../../../widgets/profile/user_profile_controller.dart';
import '../../subscription/subscription_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(SubscriptionController());
    final UserProfileController controller = Get.find<UserProfileController>();
    final SubscriptionController subscriptionController =
        Get.find<SubscriptionController>();
    return Obx(() {
      final profile = controller.userProfile.value ??
          UserProfile(
            name: '',
            courseName: '',
            college: '',
            profileimage: '',
            notes: 0,
            followers: 0,
            following: 0,
          );
      bool isSubscribed =
          subscriptionController.subscriptionStatus.value == 'subscribed';
      return Container(
        width: double.infinity,
        height: 180,
        decoration: ShapeDecoration(
          color: Color(0xFFEAF4F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: [AppColors.containerShadow],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Gap(26),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          profile.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        if (isSubscribed)
                          Padding(
                            padding: const EdgeInsets.only(
                                left:
                                    2.0), // Reduce space between text and icon
                            child: Image.asset(
                              'assets/images/icons/verified_logo.png', // Path to your custom icon
                              width: 20,
                              height: 20,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      profile.courseName,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Text(
                      profile.college,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Gap(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TitleAndTextGrid(
                          count: "${profile.notes}",
                          title: "Notes",
                        ),
                        ReusableVerticalBar(),
                        TitleAndTextGrid(
                          count: "${profile.followers}",
                          title: "Followers",
                        ),
                        ReusableVerticalBar(),
                        TitleAndTextGrid(
                          count: "${profile.following}",
                          title: "Following",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, -2.50),
              child: Container(
                height: 100,
                width: 100,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                ),
                child: ClipOval(
                  child: ReusableCachedNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl: profile.profileimage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
