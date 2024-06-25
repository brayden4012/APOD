//
//  APODListView.swift
//  APOD
//
//  Created by Brayden Harris on 6/25/24.
//

import SwiftUI

struct APODListView: View {
    @StateObject var viewModel = APODListViewModel()
    
    var body: some View {
        List(viewModel.apods) { apod in
            NavigationLink {
                APODDetailsView(apod: apod)
            } label: {
                row(for: apod)
            }
        }
        .task {
            await viewModel.viewAppeared()
        }
    }
    
    private func row(for apod: APOD) -> some View {
        HStack {
            if let url = apod.url {
                APODImageView(url: url)
                    .frame(width: 100, height: 100)
                    .clipped()
            }
            if let title = apod.title {
                Text(title)
            }
        }
    }
}

struct APODImageView: View {
    let url: URL
    @State var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
            } else {
                ZStack {
                    Rectangle().fill(Color.gray)
                }
                .overlay(alignment: .center) {
                    ProgressView()
                }
            }
        }
        .task {
            if let (data, _) = try? await URLSession.shared.data(from: url) {
                uiImage = UIImage(data: data)
            }
        }
    }
}

#Preview {
    APODListView()
}
