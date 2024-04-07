import 'package:notespedia/src/features/account/friends_profile_screen.dart';
import 'package:notespedia/src/features/authentication/sign_in_with_email_screen.dart';
import 'package:notespedia/src/features/authentication/sign_in_with_mobile_screen.dart';
import 'package:notespedia/src/features/authentication/sign_up_with_email_screen.dart';
import 'package:notespedia/src/features/authentication/sign_up_with_mobile_screen.dart';
import 'package:notespedia/src/features/cart/cart_screen.dart';
import 'package:notespedia/src/features/detailed/transaction_list_screen.dart';
import 'package:notespedia/src/features/home/categories_based_books_screen.dart';
import 'package:notespedia/src/features/home/continue_reading_books_screen.dart';
import 'package:notespedia/src/features/home/explore_detailed_screen.dart';

import 'package:notespedia/src/features/home/fresh_released_books_screen.dart';
import 'package:notespedia/src/features/intro/onboarding_screen.dart';
import 'package:notespedia/src/features/intro/splash_screen.dart';
import 'package:notespedia/src/features/navigation/home_screen.dart';
import 'package:notespedia/src/features/notifications/notification_screen.dart';
import 'package:notespedia/src/features/offline/offline_screen.dart';
import 'package:notespedia/src/features/search/search_screen.dart';
import 'package:notespedia/src/features/settings/settings_screen.dart';
import 'package:notespedia/src/features/shelf/downloads_screen.dart';
import 'package:notespedia/src/features/shelf/remixes_books_screen.dart';
import 'package:notespedia/src/features/shelf/save_for_later_books_screen.dart';
import 'package:notespedia/utils/bindings/home_bindings.dart';
import 'package:notespedia/utils/constants/app_export.dart';

import '../src/features/detailed/address_list_screen.dart';
import '../src/features/detailed/personal_information_screen.dart';
import '../src/features/detailed/settings_screen.dart';
import '../src/features/detailed/subscription_page.dart';
import '../src/features/shelf/fragment/written_notes_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const splashRoute = "/";
  static const onboardingRoute = "/onboarding";
  static const addressesRoute = "/addresses";
  static const signInMobileRoute = "/signInMobile";
  static const signInEmailRoute = "/signInEmail";
  static const signUpMobileRoute = "/signUpMobile";
  static const signUpEmailRoute = "/signUpEmail";
  static const otpVerificationRoute = "/otpVerification";
  static const personalInformationRoute = "/personalInformation";
  static const premiumPlansRoute = "/premiumPlans";
  static const transactionsRoute = "/transactionsList";

  static const homeRoute = "/home";
  static const searchRoute = "/search";
  static const cartRoute = "/cart";
  static const notificationRoute = "/notification";
  static const freshReleasedBooksRoute = "/freshReleasedBooks";
  static const continueReadingBooksRoute = "/continueReadingBooks";
  static const staffBasedBooksRoute = "/staffBasedBooks";
  static const categoryBasedBooksRoute = "/categoryBasedBooks";
  static const exploreDetailedRoute = "/exploreDetailed";
  static const saveForLaterRoute = "/saveForLater";
  static const DownloadsRoute = "/downloads";
  static const remixesBooksRoute = "/remixesBooks";
  static const writtenNotesRoute = "/writtenNotes";
  static const friendsProfileRoute = "/friendsProfile";
  static const settingsRoute = "/settings";
  static const offlineRoute = "/offline";

  static List<NavigatorObserver> navigatorObservers = [];

  static GetPageRoute<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return GetPageRoute(
          routeName: splashRoute,
          page: () => const SplashScreen(),
          settings: const RouteSettings(name: splashRoute),
        );
      case onboardingRoute:
        return GetPageRoute(
          routeName: onboardingRoute,
          page: () => OnboardingScreen(),
          settings: const RouteSettings(name: onboardingRoute),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 800),
        );
      case signInMobileRoute:
        return GetPageRoute(
          routeName: signInMobileRoute,
          page: () => const SignInWIthMobileScreen(),
          settings: const RouteSettings(name: signInMobileRoute),
        );
      case signInEmailRoute:
        return GetPageRoute(
          routeName: signInEmailRoute,
          page: () => const SignInWithEmailScreen(),
          settings: const RouteSettings(name: signInEmailRoute),
        );
      case personalInformationRoute:
        return GetPageRoute(
          routeName: personalInformationRoute,
          page: () => PersonalInformationScreen(),
          settings: const RouteSettings(name: personalInformationRoute),
        );
      case premiumPlansRoute:
        return GetPageRoute(
          routeName: premiumPlansRoute,
          page: () => PremiumPlansPage(),
          settings: const RouteSettings(name: premiumPlansRoute),
        );
      case signUpMobileRoute:
        return GetPageRoute(
          routeName: signUpMobileRoute,
          page: () => const SignUpWithMobileScreen(),
          settings: const RouteSettings(name: signUpMobileRoute),
        );
      case signUpEmailRoute:
        return GetPageRoute(
          routeName: signUpEmailRoute,
          page: () => const SignUpWithEmailScreen(),
          settings: const RouteSettings(name: signUpEmailRoute),
        );
      case transactionsRoute:
        return GetPageRoute(
          routeName: transactionsRoute,
          page: () => TransactionListScreen(),
          settings: const RouteSettings(name: transactionsRoute),
        );
      case homeRoute:
        return GetPageRoute(
          routeName: homeRoute,
          page: () => HomeScreen(),
          settings: const RouteSettings(name: homeRoute),
          binding: HomeBindings(),
        );
      case addressesRoute:
        return GetPageRoute(
          routeName: addressesRoute,
          page: () => AddressesScreen(),
          settings: const RouteSettings(name: addressesRoute),
        );
      case searchRoute:
        return GetPageRoute(
          routeName: searchRoute,
          page: () => SearchScreen(),
          settings: const RouteSettings(name: searchRoute),
        );
      case cartRoute:
        return GetPageRoute(
          routeName: cartRoute,
          page: () => CartScreen(),
          settings: const RouteSettings(name: cartRoute),
        );
      case notificationRoute:
        return GetPageRoute(
          routeName: notificationRoute,
          page: () => const NotificationScreen(),
          settings: const RouteSettings(name: notificationRoute),
        );
      case freshReleasedBooksRoute:
        return GetPageRoute(
          routeName: freshReleasedBooksRoute,
          page: () => FreshReleasedBooksScreen(),
          settings: const RouteSettings(name: freshReleasedBooksRoute),
        );
      case continueReadingBooksRoute:
        return GetPageRoute(
          routeName: continueReadingBooksRoute,
          page: () => const ContinueReadingBooksScreen(),
          settings: const RouteSettings(name: continueReadingBooksRoute),
        );
      case DownloadsRoute:
        return GetPageRoute(
          routeName: cartRoute,
          page: () => DownloadsScreen(),
          settings: const RouteSettings(name: cartRoute),
        );
      case categoryBasedBooksRoute:
        return GetPageRoute(
          routeName: categoryBasedBooksRoute,
          page: () => CategoryBasedBooksScreen(),
          settings: const RouteSettings(name: categoryBasedBooksRoute),
        );
      case exploreDetailedRoute:
        return GetPageRoute(
          routeName: exploreDetailedRoute,
          page: () => const ExploreDetailedScreen(),
          settings: const RouteSettings(name: exploreDetailedRoute),
        );
      case friendsProfileRoute:
        return GetPageRoute(
          routeName: friendsProfileRoute,
          page: () => FriendsProfileScreen(),
          settings: const RouteSettings(name: friendsProfileRoute),
        );
      case saveForLaterRoute:
        return GetPageRoute(
          routeName: saveForLaterRoute,
          page: () => SaveForLaterBooksScreen(),
          settings: const RouteSettings(name: saveForLaterRoute),
        );
      case remixesBooksRoute:
        return GetPageRoute(
          routeName: remixesBooksRoute,
          page: () => const RemixesBooksScreen(),
          settings: const RouteSettings(name: remixesBooksRoute),
        );
      case settingsRoute:
        return GetPageRoute(
          routeName: settingsRoute,
          page: () => SettingsScreen(),
          settings: const RouteSettings(name: settingsRoute),
        );

      case writtenNotesRoute:
        return GetPageRoute(
          routeName: writtenNotesRoute,
          page: () => const WrittenNotesScreen(),
          settings: const RouteSettings(name: writtenNotesRoute),
        );
      default:
        return GetPageRoute(
          page: () => const OfflineScreen(),
          settings: const RouteSettings(name: offlineRoute),
        );
    }
  }

  // static final List<GetPage> pages = [
  //   GetPage(
  //     name: splashRoute,
  //     page: () => const SplashScreen(),
  //   ),
  //   GetPage(
  //     name: onboardingRoute,
  //     page: () => const OnboardingScreen(),
  //   ),
  //   GetPage(
  //     name: homeRoute,
  //     page: () => const NavigationScreen(),
  //   ),
  //   GetPage(
  //     name: searchRoute,
  //     page: () => SearchScreen(),
  //   ),
  //   GetPage(
  //     name: cartRoute,
  //     page: () => CartScreen(),
  //   ),
  //   GetPage(
  //     name: notificationRoute,
  //     page: () => const NotificationScreen(),
  //   ),
  //   GetPage(
  //     name: bookDetailsRoute,
  //     page: () => const BooksDetailsScreen(),
  //   ),
  //   GetPage(
  //     name: freshReleasedBooksRoute,
  //     page: () => const FreshReleasedBooksScreen(),
  //   ),
  //   GetPage(
  //     name: continueReadingBooksRoute,
  //     page: () => const ContinueReadingBooksScreen(),
  //   ),
  //   GetPage(
  //     name: staffBasedBooksRoute,
  //     page: () => const StaffBasedBooksScreen(),
  //   ),
  //   GetPage(
  //     name: categoryBasedBooksRoute,
  //     page: () => const CategoryBasedBooksScreen(),
  //   ),
  //   GetPage(
  //     name: "/exploreDetailed",
  //     page: () => const ExploreDetailedScreen(),
  //   ),
  //   GetPage(
  //     name: friendsProfileRoute,
  //     page: () => FriendsProfileScreen(),
  //   ),
  //   GetPage(
  //     name: "/saveForLater",
  //     page: () => const SaveForLaterBooksScreen(),
  //   ),
  //   GetPage(
  //     name: "/remixesBooks",
  //     page: () => const RemixesBooksScreen(),
  //   ),
  //   GetPage(
  //     name: "/writtenNotes",
  //     page: () => const WrittenNotesScreen(),
  //   ),
  //   GetPage(
  //     name: settingsRoute,
  //     page: () => const SettingsScreen(),
  //   ),
  // ];
}
