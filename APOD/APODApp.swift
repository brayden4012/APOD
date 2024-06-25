//
//  APODApp.swift
//  APOD
//
//  Created by Brayden Harris on 6/25/24.
//

import SwiftUI

@main
struct APODApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                APODListView()
            }
        }
    }
}
