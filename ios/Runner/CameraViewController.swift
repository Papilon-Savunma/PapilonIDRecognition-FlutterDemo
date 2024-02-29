//
//  CameraViewController.swift
//  Runner
//
//  Created by macmini on 24.02.2024.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    var previewView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewView()
        // Other camera configuration codes will be here
    }

    func setupPreviewView() {
        previewView = UIView(frame: self.view.bounds)
        self.view.addSubview(previewView)
        // Configure `previewView` to display the camera feed
    }
}
