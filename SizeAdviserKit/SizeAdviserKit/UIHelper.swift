//
//  UIHelper.swift
//  SizeAdviserKit
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import UIKit
import SwiftUI

enum UIHelper {
    @MainActor
    static func displayInputDialog() async -> BmiInputView.InputData? {
        guard let controller = Self.getRootViewController() else {
            return nil
        }
        
        return await withCheckedContinuation { continuation in
            let content = UIHostingController(rootView: BmiInputView(onFinished: { result in
                continuation.resume(with: .success(result))
            }))
            
            controller.present(content, animated: true)
        }
    }
    
    @MainActor
    static func displayResult(_ size: ProposedSize) {
        guard let controller = Self.getRootViewController() else {
            return
        }
        
        controller.present(UIHostingController(rootView: ResultView(size: size)), animated: true)
    }
    
    @MainActor
    private static func getRootViewController() -> UIViewController? {
        guard
            let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene,
            let window = scene.windows.first(where: { $0.isKeyWindow }),
            let controller = window.rootViewController
        else {
            return nil
        }
        
        return controller
    }
}
