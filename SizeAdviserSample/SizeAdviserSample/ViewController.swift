//
//  ViewController.swift
//  SizeAdviserSample
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import UIKit
import SizeAdviserKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onAdviceSizeTap(_ sender: Any) {
        Task { @MainActor in
            await SizeAdviceKit.promptForAdvice()
        }
    }
}

