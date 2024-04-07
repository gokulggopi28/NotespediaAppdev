import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:notespedia/src/widgets/reusable/reusable_textformfield.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class PhoneNumberSection extends StatelessWidget {
  PhoneNumberSection({
    super.key,
    required this.textController,
    required this.onTap,
  });

  final VoidCallback onTap;
  final TextEditingController textController;

  final authController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    //
    final authController = AuthenticationController(
      countryPicker: FlCountryCodePicker(
        countryTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ReusableTextFormField(
        controller: textController,
        hintText: "Phone Number",
        keyboardType: TextInputType.phone,
        autofillHints: const [AutofillHints.telephoneNumber],
        maxLines: 1,
        maxLength: 10,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: AnimatedGestureDetector(
            onTap: () async {
              authController.countryCodePicker(context);
            },
            child: GetBuilder<AuthenticationController>(builder: (logic) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(child: logic.countryCode.flagImage()),
                  const Gap(4),
                  Text(
                    logic.countryCode.dialCode,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              );
            }),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.black.withOpacity(0.60),
                ),
                const Padding(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
