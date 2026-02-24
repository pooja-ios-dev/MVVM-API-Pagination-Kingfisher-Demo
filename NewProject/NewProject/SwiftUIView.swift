//
//  SwiftUIView.swift
//  NewProject
//
//  Created by Pooja Chaudhari on 12/02/26.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        asd
    }
    
    @ViewBuilder
    var asd: some View {
            Text("Hello")
            Text("World")
           // ❌ error — multiple returns
    }
    
}

#Preview {
    SwiftUIView()
}
