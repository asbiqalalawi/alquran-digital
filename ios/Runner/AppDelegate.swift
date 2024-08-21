import Flutter
import UIKit
import LocalAuthentication

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let channelName = "samples.invertase.io/biometrics"
    var biometricsChannel: FlutterMethodChannel?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Get the root controller for the Flutter view.
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

        // Initialize the method channel once the Flutter engines is attached.s
        biometricsChannel = FlutterMethodChannel(name: channelName,
                                                 binaryMessenger: controller.binaryMessenger)

        // Set a method call handler, whenever we invoke a method from Flutter on "samples.invertase.io/biometrics" channel,
            // this handler will be triggered.
        biometricsChannel?.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            // Handle calls to biometrics channel.
            guard call.method == "authenticateWithBiometrics" else {
                // If the requested method is not `authenticate`, throw.
                result(FlutterMethodNotImplemented)
                return
            }

            self.authenticateWithBiometrics(result: result)
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func authenticateWithBiometrics(result: @escaping FlutterResult) -> Void  {
        let context = LAContext()

        if #available(iOS 10.0, *) {
            context.localizedCancelTitle = "Use Password"
        }

        var error: NSError?

        // Check for biometric authentication permissions
        let permissions = context.canEvaluatePolicy(
            .deviceOwnerAuthentication,
            error: &error
        )

        if permissions {
            let reason = "Log in with Face ID"
            context.evaluatePolicy(
                // .deviceOwnerAuthentication allows biometric or passcode authentication
                .deviceOwnerAuthentication,
                localizedReason: reason
            ) { success, error in
                // Send the authentication result to Flutter, either true or false.
                result(nil)
                self.biometricsChannel?.invokeMethod("authenticationResult", arguments: success)
            }
        } else {
            // If the biometrics permissions failed, throw a PlatformException to Flutter.
            let platformError = FlutterError(code: "AUTHFAILED",
                                             message: (error?.localizedDescription ?? "The authentication process has failed for an unknown reason"),
                                             details: nil)
            result(platformError)
        }

        return
    }
}
