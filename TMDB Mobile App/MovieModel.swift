//
//  TopRatedListModel.swift
//  TMDB Mobile App
//
//  Created by Maximiliano Riquelme Vera on 17/03/2025.
//

import Foundation
import SwiftData

@Model
class TopRatedListModel: Identifiable {
    
    /*@Attribute(.unique)*/ var id: Int
    var results: [TopRatedMovie]
    var totalPages: Int
    var totalResults: Int
    
    init(id: Int, results: [TopRatedMovie], totalPages: Int, totalResults: Int) {
        self.id = id
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    
    convenience init(_ page: TopRatedListPage) {
        self.init(id: page.id,
                  results: page.results,
                  totalPages: page.totalPages,
                  totalResults: page.totalResults)
    }
}

struct TopRatedListPage: Identifiable, Codable {
    
    let id: Int
    let results: [TopRatedMovie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id = "page"
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TopRatedMovie: Identifiable, Codable
{
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
}
