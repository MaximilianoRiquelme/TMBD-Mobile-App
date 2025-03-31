//
//  TMDB_Mobile_AppApp.swift
//  TMDB Mobile App
//
//  Created by Maximiliano Riquelme Vera on 17/03/2025.
//

import SwiftUI
import SwiftData

@main
struct TMDB_Mobile_AppApp: App {
    var body: some Scene {
        WindowGroup {
            MainContentView()
        }
        .modelContainer(for: TopRatedListModel.self)
    }
}
