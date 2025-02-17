//
//  BmiBasedSizeCalculator.swift
//  SizeAdviserKit
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import Foundation

enum BmiCalculationError: Error {
    case innvalidInput
}

struct BmiBasedSizeCalculator {
    
    struct InputData: Sendable {
        let height: Double
        let weight: Double
    }
    
    func calculate(_ data: InputData) -> Result<ProposedSize, BmiCalculationError> {
        guard
            data.weight > 0, data.height > 0,
            let result = sizeBasedOnBmi(data.bmiIndex)
        else {
            return .failure(.innvalidInput)
        }
        
        return .success(result)
    }
    
    //we can propably move values to constants
    private func sizeBasedOnBmi(_ index: Double) -> ProposedSize? {
        switch(index) {
        case 0..<18.5: return .s
        case 18.5..<25: return .m
        case 25..<30: return .l
        case 30...: return .xl
        default: return nil
        }
    }
}

extension BmiInputView.InputData {
    func toCalculatorInput() -> BmiBasedSizeCalculator.InputData {
        return .init(height: self.height, weight: self.weight)
    }
}

private extension BmiBasedSizeCalculator.InputData {
    var bmiIndex: Double {
        return weight / (height * height)
    }
}
