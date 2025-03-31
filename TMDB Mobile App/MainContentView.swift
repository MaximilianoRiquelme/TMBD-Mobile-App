//
//  MainContentView.swift
//  TMDB Mobile App
//
//  Created by Maximiliano Riquelme Vera on 17/03/2025.
//

import SwiftUI
import SwiftData

struct MainContentView: View {
    // For presistent data storage
    @Environment(\.modelContext) var context
    @Query(sort: \TopRatedListModel.id) var dataItem: [TopRatedListModel]
    
    // Non-Persistent data.
    @StateObject var movieController = MovieController()
    
    var body: some View {
        List() {
            HStack {
                Button("Make API Call Persistent"){
                    Task {
                        await movieController.updateDataInDatabase(modelContext: context)
                    }
                }
                .padding()
                .foregroundColor(.black)
                .background(.blue)
            }
            HStack {
                Button("Make API Call Non-Presistent"){
                    Task {
                        await movieController.getTopRatedMovies()
                    }
                }
                .padding()
                .foregroundColor(.black)
                .background(.blue)
            }
            VStack {
                Text("\(dataItem.description)")
                    .padding()
                    .foregroundColor(.black)
                    .background(.gray)
            }
            VStack {
                Text("\(movieController.movieList.description)")
                    .padding()
                    .foregroundColor(.black)
                    .background(.gray)
            }
        }
    }
}
