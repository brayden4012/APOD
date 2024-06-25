//
//  APODDetailsView.swift
//  APOD
//
//  Created by Brayden Harris on 6/25/24.
//

import SwiftUI

struct APODDetailsView: View {
    let apod: APOD
    
    var body: some View {
        ScrollView {
            if let url = apod.hdurl ?? apod.url {
                GeometryReader { geo in
                    APODImageView(url: url)
                        .frame(height: 300)
                        .clipped()
                }
                Text(apod.explanation ?? "")
                    .multilineTextAlignment(.leading)
                if let date = apod.date {
                    Text(date)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .navigationTitle(apod.title ?? "")
    }
}

//#Preview {
//    APODDetailsView()
//}
