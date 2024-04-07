import 'package:notespedia/utils/constants/app_export.dart';

import '../../widgets/reusable/reusable_textformfield.dart';

class SignInWithEmailScreen extends StatefulWidget {
  const SignInWithEmailScreen({super.key});

  @override
  State<SignInWithEmailScreen> createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends State<SignInWithEmailScreen> {
  //);
  final emailIdController = TextEditingController();
  final authController = Get.put(AuthenticationController());

  @override
  void dispose() {
    emailIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .30,
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(.2),
            child: Image.asset(
              AppImages.appLogoWithName,
              height: 200,
              width: 200,
              fit: BoxFit.contain,
            ),
          ),

          //
          const Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Sign in with email',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF4B4B4B),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
            ),
          ),

          //
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ReusableTextFormField(
              controller: emailIdController,
              hintText: "Email Address",
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              maxLines: 1,
              maxLength: 40,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.black.withOpacity(0.60),
                    ),
                    AnimatedGestureDetector(
                      onTap: () {
                        authController.emailLogin(
                          ctx: context,
                          emailAddress: emailIdController.text,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Get OTP',
                          style: TextStyle(
                            color: Color(0xFF0033B7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
