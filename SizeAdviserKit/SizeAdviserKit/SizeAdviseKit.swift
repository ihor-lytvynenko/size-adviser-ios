//
//  SizeAdviseKit.swift
//  SizeAdviserKit
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import Foundation

public final class SizeAdviceKit {
    
    /// Display a prompt view and results
    /// The calculated size also returned as a result
    @MainActor
    public static func promptForAdvice() async -> ProposedSize? {
        guard let data = await UIHelper.displayInputDialog() else {
            return nil
        }
        
        switch(BmiBasedSizeCalculator().calculate(data.toCalculatorInput())) {
        case .failure(let error):
            print("failed to calclulate size based on bmi. \(error)")
            return nil
        case .success(let result):
            UIHelper.displayResult(result)
            return result
        }
    }
    
}

/// Proposed size based on the input parameters
public enum ProposedSize {
    case s, m, l, xl
    
    var stringValue: String {
        switch(self) {
        case .s: return "S"
        case .m: return "M"
        case .l: return "L"
        case .xl: return "XL"
        }
    }
}
