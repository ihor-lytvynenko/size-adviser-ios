//
//  InputDataView.swift
//  SizeAdviserKit
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import Foundation
import SwiftUI
import Combine

struct BmiInputView: View {
    @Environment(\.dismiss) private var dismiss
    
    struct InputData {
        let height: Double
        let weight: Double
    }
    
    @ObservedObject
    private var viewModel = ViewModel()
    @State
    private var displayDialog = true
    
    let onFinished: (InputData?) -> Void
    
    var body: some View {
        VStack {
            Text("Find Your Perfect Fit")
            
            HStack {
                Text("Height")
                    .padding(.trailing, 8)
                
                TextField("cm", text: $viewModel.height)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Weight")
                    .padding(.trailing, 8)
                
                TextField("kg", text: $viewModel.weight)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Spacer()
                
                Button("Cancel", role: .cancel) {
                    reportFinished(nil)
                }
                
                Spacer()
                
                Button("Get Size Recommendation") {
                    reportFinished(viewModel.inputData)
                }
                .disabled(!viewModel.isValid)
                
                Spacer()
            }
            .padding(.top, 16)
        }
        .padding(.horizontal, 16)
    }
    
    private func reportFinished(_ data: InputData?) {
        onFinished(data)
        dismiss()
    }
}

private class ViewModel: ObservableObject {
    
    @Published private(set) var isValid: Bool = false
    @Published var height: String = ""
    @Published var weight: String = ""
    
    var inputData: BmiInputView.InputData? = nil
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $height
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.parseAndUpdateValues() }
            .store(in: &subscriptions)

        $weight.receive(on: RunLoop.main)
            .sink { [weak self] _ in self?.parseAndUpdateValues() }
            .store(in: &subscriptions)
    }
    
    private func parseAndUpdateValues() {
        guard
            let heightValue = Double(height),
            let weightValue = Double(weight)
        else {
            isValid = false
            return
        }

        self.inputData = BmiInputView.InputData(
            height: heightValue,
            weight: weightValue
        )
        
        isValid = true
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        BmiInputView { _ in }
    }
}
