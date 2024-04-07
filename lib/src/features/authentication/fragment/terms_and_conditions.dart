import 'package:notespedia/utils/constants/app_export.dart';

class TermsAndCondition extends StatelessWidget {
  TermsAndCondition({
    super.key,
  });

  final signupController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            side: const BorderSide(
              color: AppColors.greyDim,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            value: signupController.isAgreed.value,
            onChanged: (value) {
              signupController.isAgreed.value = value!;
            },
          ),
        ),
        Text(
          'I agree to the terms and conditions',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF4B4B4B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0,
              ),
        ),
      ],
    );
  }
}
