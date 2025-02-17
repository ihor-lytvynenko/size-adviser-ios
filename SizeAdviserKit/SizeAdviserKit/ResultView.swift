//
//  ResultView.swift
//  SizeAdviserKit
//
//  Created by Igor Litvinenko on 17.02.2025.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    let size: ProposedSize
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Recommended Size: \(size.stringValue)")
                .padding(.bottom, 8)
            
            Text("Based on your info, size \(size.stringValue) is recommended.")
                .padding(.bottom, 8)
            
            Button("OK") {
                dismiss()
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(size: .m)
    }
}
