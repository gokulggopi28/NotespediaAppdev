import 'package:notespedia/utils/constants/app_export.dart';

import '../../../widgets/reusable/reusable_drag_handler.dart';

Future<void> cartScreenBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    showDragHandle: false,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26.0),
        topRight: Radius.circular(26.0),
      ),
    ),
    constraints: BoxConstraints.tight(
      Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * .4,
      ),
    ),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
        child: Column(
          children: [
            const CartDragHeader(),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Gap(22),
                  const PromoSection(),
                  const Gap(22),
                  const PaymentSection(),
                  const Gap(22),
                  ReusableMaterialButton(
                    text: AppTexts.proceedToPayment,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {},
                    color: AppColors.brightGreen,
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppTexts.paymentMethods,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.greyBrightIconColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(
          height: 50,
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              side: BorderSide(
                color: Colors.black.withOpacity(0.20),
              ),
            ),
            icon: SizedBox(
              height: 50,
              width: 32,
              child: Image.asset(
                AppImages.gPayIcon,
                fit: BoxFit.cover,
                isAntiAlias: true,
                filterQuality: FilterQuality.high,
              ),
            ),
            label: const Text(
              'Google Pay UPI',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PromoSection extends StatelessWidget {
  const PromoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            width: 120,
            height: 50,
            child: TextFormField(
              maxLines: 1,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.greyDimIconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
              decoration: InputDecoration(
                hintText: AppTexts.promoCode,
                hintTextDirection: TextDirection.ltr,
                contentPadding: const EdgeInsets.only(left: 16, right: 16),
                hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      color: AppColors.greyDimIconColor,
                      fontWeight: FontWeight.w600,
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.greyDimIconColor,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.greyDimIconColor,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.greyDimIconColor,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.greyDimIconColor,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.greyDimIconColor,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.greyDimIconColor,
                    width: .5,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: ReusableVerticalBar(height: 40),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextButton(
              onPressed: () {},
              child: Text(
                AppTexts.viewCoupons,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.brightGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CartDragHeader extends StatelessWidget {
  const CartDragHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.greyDimIconColor.withOpacity(.5),
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const ReusableDragHandler(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                '₹ 735.00',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
