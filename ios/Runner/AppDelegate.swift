import UIKit
import Flutter
import PapilonIDRecognitioniOS

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CameraManagerDelegate {
    func didEvaluateDistance(evaluation: PapilonIDRecognitioniOS.IDRecognizer.DistanceEvaluation) {
        
    }
    
    func didUpdateMarkerImage(_ image: UIImage) {
        
    }
    
    func didCaptureImages(_ images: [PapilonIDRecognitioniOS.IDRecognizer.ImageResult]) {
        
    }
    
    // MARK: Properties
    private var cameraManager: CameraManager?
    private var flutterResult: FlutterResult?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.yourcompany.papilonidrecognition/channel",
                                           binaryMessenger: controller.binaryMessenger)
        
        // MARK: Method Channel Handling
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            self?.flutterResult = result
            if call.method == "showCameraView" {
                self?.showCameraViewController()
            }
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: Methods
    private func showCameraViewController() {
        if let rootViewController = window?.rootViewController {
            let cameraViewController = CameraViewController()
            rootViewController.present(cameraViewController, animated: true, completion: {
                self.cameraManager = CameraManager()
                self.cameraManager?.delegateCameraManager = self
                self.cameraManager?.configureCameraManager(idType: "", token: "", licenseID: "", in: cameraViewController.previewView)
            })
        } else {
            flutterResult?(FlutterError(code: "UNAVAILABLE",
                                        message: "Root view controller is not available.",
                                        details: nil))
        }
    }
    
    
    // MARK: CameraManagerDelegate Methods
    func didDetectIDDocument(results: [String: Any]) {
        flutterResult?(results)
        print(results)
    }
}
