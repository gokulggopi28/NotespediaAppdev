import 'package:dio/dio.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/features/authentication/otp_verification_screen.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../src/features/detailed/personal_information_screen.dart';
import '../src/features/navigation/home_screen.dart';
import '../src/features/navigation/navigationController.dart';
import '../src/widgets/profile/user_profile_controller.dart';

class AuthenticationController extends GetxController {
  AuthenticationController({this.countryPicker});

  final FlCountryCodePicker? countryPicker;
  CountryCode countryCode =
      const CountryCode(name: 'India', code: 'IN', dialCode: '+91');

  var isLoggedIn = false.obs;
  var isUserId = 0.obs;

  var isAgreed = false.obs;

  @override
  void onInit() {
    isLoggedIn.value = UserPreferences.isLoggedIn;
    isUserId.value = UserPreferences.userId;
    debugAuthTestFunction();
    super.onInit();
  }

  void debugAuthTestFunction() {
    DebugLogger.info(
      "OnboardingVisited: ${UserPreferences.isVisited}"
      "\nLoggedIn: ${UserPreferences.isLoggedIn}"
      "\nAuthToken: ${UserPreferences.authToken}"
      "\nRefreshToken: ${UserPreferences.refreshToken}"
      "\nUserId: ${UserPreferences.userId}"
      "\nSubscriptionStatus: ${UserPreferences.subscriptionStatus}",
    );
  }

  Future<void> loginAction(int userid, {bool navigateToHome = true}) async {
    await UserPreferences.setUserId(userid);
    await UserPreferences.setIsLoggedIn(true);
    isLoggedIn.value = true;
    isUserId.value = userid;
    if (navigateToHome) {
      Get.find<NavigationController>().changeIndex(0); // Set selectedIndex to 3
      Get.to(() => HomeScreen());
    }
  }

  Future<void> logoutAction() async {
    isLoggedIn.value = false;
    UserPreferences.clearUserPreferences();
  }

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

  Future<void> mobileLogin({
    required BuildContext ctx,
    dynamic mobileNo,
  }) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}users/sign_in/",
        data: {"signup_method": "phone", "mobile_number": mobileNo},
      );
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        String message = jsonData['message'];
        showSnackbarFunction(
            context: ctx, message: "User account not found please signup");
        if (message.isNotEmpty) Get.toNamed(AppRoutes.signUpMobileRoute);
      } else if (response.statusCode == 201) {
        Map<String, dynamic> jsonData = response.data;
        String message = jsonData['message'];
        String otp = jsonData['otp'];
        showSnackbarFunction(context: ctx, message: message + " ");
        Get.to(() => OtpVerificationScreen(mobileNo: mobileNo));
      } else {
        DebugLogger.warning('${response.statusCode}');
      }
    } catch (error) {
      Get.back();
      showSnackbarFunction(
          context: ctx,
          message: "Something Went Wrong, Check internet connection..");
      DebugLogger.error(error.toString());
    }
  }

  Future<void> emailLogin({
    required BuildContext ctx,
    dynamic emailAddress,
  }) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}users/sign_in/",
        data: {"signup_method": "email", "email": emailAddress},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        String message = jsonData['message'];
        if (message.isNotEmpty) Get.toNamed(AppRoutes.signUpMobileRoute);
        showSnackbarFunction(context: ctx, message: message);
      } else if (response.statusCode == 201) {
        Map<String, dynamic> jsonData = response.data;
        String message = jsonData['message'];
        String otp = jsonData['otp'];
        showSnackbarFunction(context: ctx, message: message + " ");
        Get.to(() => OtpVerificationScreen(emailId: emailAddress));
      } else {
        DebugLogger.warning('${response.statusCode}');
      }
    } catch (error) {
      Get.back();
      showSnackbarFunction(
          context: ctx,
          message: "Something Went Wrong, Check internet connection..");
      DebugLogger.error(error.toString());
    }
  }

  Future<void> mobileRegister({
    required BuildContext ctx,
    dynamic mobileNo,
  }) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}users/sign_up/",
        data: {"signup_method": "phone", "mobile_number": mobileNo},
      );
      Get.back();
      if (response.statusCode == 201) {
        // Handle the OTP sent case
        Map<String, dynamic> jsonData = response.data;
        String otp = jsonData['otp'];
        HelperFunctions.showSnackBar(
            context: ctx, message: "OTP sent:", seconds: 5);
        Get.to(() => OtpVerificationScreen(mobileNo: mobileNo));
      } else {
        // Handling other status codes
        HelperFunctions.showSnackBar(
            context: ctx,
            message: "Unexpected response: ${response.statusCode}",
            seconds: 5);
      }
    } on DioError catch (dioError) {
      if (dioError.response != null && dioError.response!.statusCode == 400) {
        // Extract the message from the error response
        String errorMessage = dioError.response!.data['message'];
        HelperFunctions.showSnackBar(
            context: ctx, message: errorMessage, seconds: 5);
      } else {
        // Handle unexpected Dio errors
        HelperFunctions.showSnackBar(
            context: ctx,
            message: "Account already exists please login",
            seconds: 5);
        Get.toNamed(AppRoutes.signInMobileRoute);
      }
    } catch (error) {
      Get.back();
      // Handle any other types of errors
      HelperFunctions.showSnackBar(
          context: ctx,
          message: "Account already exists please login",
          seconds: 5);
      Get.toNamed(AppRoutes.signInMobileRoute);
    }
  }

  Future<void> emailRegister({
    required BuildContext ctx,
    dynamic email,
  }) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}users/sign_up/",
        data: {"signup_method": "email", "email": email},
      );
      Get.back();
      if (response.statusCode == 201) {
        // Handle the OTP sent case
        Map<String, dynamic> jsonData = response.data;
        String otp = jsonData['otp'];
        HelperFunctions.showSnackBar(
            context: ctx, message: "OTP sent", seconds: 5);
        Get.to(() => OtpVerificationScreen(emailId: email));
      } else {
        // Handling other status codes
        HelperFunctions.showSnackBar(
            context: ctx,
            message: "Unexpected response: ${response.statusCode}",
            seconds: 5);
      }
    } on DioError catch (dioError) {
      if (dioError.response != null && dioError.response!.statusCode == 400) {
        // Extract the message from the error response
        String errorMessage = dioError.response!.data['message'];
        HelperFunctions.showSnackBar(
            context: ctx, message: errorMessage, seconds: 5);
      } else {
        // Handle unexpected Dio errors
        HelperFunctions.showSnackBar(
            context: ctx,
            message: "Account already exists please login",
            seconds: 5);
        Get.toNamed(AppRoutes.signInMobileRoute);
      }
    } catch (error) {
      Get.back();
      // Handle any other types of errors
      HelperFunctions.showSnackBar(
          context: ctx,
          message: "Account already exists please login",
          seconds: 5);
      Get.toNamed(AppRoutes.signInMobileRoute);
    }
  }

  //
  Future<void> otpMobileVerification({
    required BuildContext ctx,
    dynamic mobileNo,
    dynamic otp,
  }) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}users/verify_otp/",
        data: {"signup_method": "phone", "mobile_number": mobileNo, "otp": otp},
      );
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        int isProfileCompleted = jsonData['is_profile_completed'];
        int userId = jsonData['user_id'];

        await loginAction(userId);

        if (isProfileCompleted == 0) {
          await loginAction(userId, navigateToHome: false);
          final userProfileResponse = await Dio().get(
              'https://notespaedia.deienami.com/api/users/profile/?user_id=$userId');
          if (userProfileResponse.statusCode == 200) {
            var userData = userProfileResponse.data['data'];

            bool mobileNumberExists =
                userData['mobile_number']?.isNotEmpty ?? false;
            bool emailExists = userData['email']?.isNotEmpty ?? false;

            Get.to(() => PersonalInformationScreen(
                  hidePhoneNumber: mobileNumberExists,
                  hideEmail: emailExists,
                ));
          } else {
            print(
                'Failed to fetch user profile: ${userProfileResponse.statusCode}');
          }
        } else {
          await loginAction(userId);
        }
      } else {
        DebugLogger.warning('${response.statusCode}');
      }
    } catch (error) {
      Get.back();
      showSnackbarFunction(
          context: ctx, message: "Invalid OTP, Check internet connection..");
      DebugLogger.error(error.toString());
    }
  }

  Future<void> otpEmailVerification({
    required BuildContext ctx,
    dynamic emailAddress,
    dynamic otp,
  }) async {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    try {
      final response = await HttpService.dioPostRequest(
        url: "${ApiConstants.baseUrl}users/verify_otp/",
        data: {"signup_method": "email", "email": emailAddress, "otp": otp},
      );
      Get.back();
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        int isProfileCompleted = jsonData['is_profile_completed'];
        int userId = jsonData['user_id'];

        if (isProfileCompleted == 0) {
          await loginAction(userId, navigateToHome: false);
          final userProfileResponse = await Dio().get(
              'https://notespaedia.deienami.com/api/users/profile/?user_id=$userId');
          if (userProfileResponse.statusCode == 200) {
            var userData = userProfileResponse.data['data'];

            bool mobileNumberExists =
                userData['mobile_number']?.isNotEmpty ?? false;
            bool emailExists = userData['email']?.isNotEmpty ?? false;

            Get.to(() => PersonalInformationScreen(
                  hidePhoneNumber: mobileNumberExists,
                  hideEmail: emailExists,
                ));
          } else {
            print(
                'Failed to fetch user profile: ${userProfileResponse.statusCode}');
          }
        } else {
          await loginAction(userId);
        }
      } else {
        DebugLogger.warning('${response.statusCode}');
      }
    } catch (error) {
      Get.back();
      showSnackbarFunction(
          context: ctx, message: "Invalid OTP, Check internet connection..");
      DebugLogger.error(error.toString());
    }
  }

  Future<void> countryCodePicker(context) async {
    final picked = await countryPicker?.showPicker(context: context);
    if (picked != null) {
      countryCode = picked;
      update();
    }
  }
}
