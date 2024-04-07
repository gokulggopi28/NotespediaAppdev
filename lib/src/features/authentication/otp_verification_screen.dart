import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/constants/app_export.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({
    super.key,
    this.mobileNo,
    this.emailId,
  });

  final String? mobileNo;
  final String? emailId;

  final authController = Get.put(AuthenticationController());
  final otpController = TextEditingController();
  Future<void> showSnackbarFunction({
    required BuildContext context,
    required String message,
  }) async {
    HelperFunctions.showSnackBar(
      context: context,
      message: message,
      seconds: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(55),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              const Gap(12),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Please enter the OTP sent to your mobile number ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
              const Gap(55),
              PinCodeTextField(
                appContext: context,
                mainAxisAlignment: MainAxisAlignment.center,
                length: 4,
                enabled: true,
                enableActiveFill: true,
                textStyle: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 65,
                  activeFillColor: const Color(0xffeaedf0),
                  activeColor: const Color(0xffeaedf0),
                  inactiveFillColor: const Color(0xffeaedf0),
                  inactiveColor: const Color(0xffeaedf0),
                  selectedColor: const Color(0xffeaedf0),
                  selectedFillColor: const Color(0xffeaedf0),
                ),
                controller: otpController,
                keyboardType: TextInputType.number,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                separatorBuilder: (context, index) {
                  return const Gap(22);
                },
              ),

              //
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Don’t receive the OTP?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0x994B4B4B),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                ),
              ),
              const Gap(16),
              GestureDetector(
                onTap: () {
                  showSnackbarFunction(
                      context: context,
                      message: "OTP has been resent successfully");
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Resend OTP',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color(0xFF0033B7),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                  ),
                ),
              ),

              //
              const Gap(36),
              ReusableMaterialButton(
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {
                  if (mobileNo != null) {
                    authController.otpMobileVerification(
                      ctx: context,
                      mobileNo: mobileNo,
                      otp: otpController.text,
                    );
                  } else {
                    authController.otpEmailVerification(
                      ctx: context,
                      emailAddress: emailId,
                      otp: otpController.text,
                    );
                  }
                },
                child: Text(
                  'Continue',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                ),
              ),

              //
              const Gap(70),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          AppImages.backIcon,
          color: AppColors.greyBrightIconColor,
          size: 32,
        ),
      ),
    );
  }
}
