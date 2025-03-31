//
//  MovieController.swift
//  TMDB Mobile App
//
//  Created by Maximiliano Riquelme Vera on 17/03/2025.
//

import Foundation
import SwiftData

@MainActor class MovieController: ObservableObject {
    
    @Published var movieList = [TopRatedMovie]()
    
    var apiConsumer = APIConsumer()
    
    func getTopRatedMovies() async {
        guard let newList: TopRatedListPage = await apiConsumer.getTopRatedMovies()
        else {
            return
        }
        movieList = newList.results
    }
    
    func updateDataInDatabase(modelContext: ModelContext) async {
        guard let newData: TopRatedListPage = await apiConsumer.getTopRatedMovies()
        else {
            return
        }
        let newList = TopRatedListModel(newData)
        modelContext.insert(newList)
        do {
            try modelContext.save()
        } catch {
            return
        }
    }
}
