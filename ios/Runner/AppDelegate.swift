import UIKit
import Flutter
import PSPDFKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    GeneratedPluginRegistrant.register(with: self)
      PSPDFKit.SDK.setLicenseKey("VQaitiu+v1AUpAMiAICHv4rql8wvF3+Bf+DYMy+WWp6NcbDUuQhxR/VIFRZAveiJuMfS9VM258UbmH2jFew8NZP5hjtHQk1Bo41LRXc3QZwwv5lcAgZdj4u68DTLll8o/6Z7ryPevofR50KIrped/m+ctCrARsgAhJo3+hMA5JCx2T7SMi0/hdhmje0ogQUpfMFvNQVPd1Abragmo5Rm9qC38tCXRKwSHlKbevgC7uttoeM1sGdBpn2fe28b7BHJudAGwCzYqW/2wysLydJf48xGrGudJXxQtgSUm42ntyH/OEKIWnXogzGHHuqi2KOOA0hDKySTlEJ53D0SHHpU2GkHxdSO+9mrbezcnJbQZBfuJFBbVCdZnwdVM+Sb9CUKuzlPS/CWmH87lNElg6cW9T5dH2I7iktgmSYEWPYeziDXHDoxwl0UiMBTjqg6awXhB4fi9yD8/wwT/Oh46N/jXIqOgfKcGDh5q/yVQce8O4KHuS6KeVyP6U3lift82ZVZxNgIO0QWbSiDfpmgR4ZXS7tgSKuq5pZf6UsZGU2o1X8uASsk1ME2L5Lj2FtAUUU9n2egE9WQW6VzigBsrao4Zbsxj0rDbk8fuX4i6+zgYjcfdmaHCzFXbJ7V13Pk6CgBtMyliU6k/ra8F+Pe1zuDJwcNsOyKmIMS2lfRpNzEUS8=")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

