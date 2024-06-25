//
//  APODListViewModel.swift
//  APOD
//
//  Created by Brayden Harris on 6/25/24.
//

import Foundation

final class APODListViewModel: ObservableObject {
    @Published var apods = [APOD]()
    private let networkingService = APODNetworkingService()
    
    func viewAppeared() async {
        do {
            apods = try await networkingService.getAPOD()
        } catch {
            print("There was a problem: \(error)")
        }
    }
}
