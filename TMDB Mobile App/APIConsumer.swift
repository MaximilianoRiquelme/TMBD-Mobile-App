//
//  APIConsumer.swift
//  TMDB Mobile App
//
//  Created by Maximiliano Riquelme Vera on 17/03/2025.
//

import Foundation

enum APIClientError: Error
{
    case serverError
    case urlError
    case parsingError
}

class APIConsumer
{
    let baseURL: String = "api.themoviedb.org"
    
    let apiKey: String = "fb517ff4ec44e482ab1fa55f2570b173"
    
    func getTopRatedMovies<TopRatedList: Codable>() async -> TopRatedList? {
        do {
            guard let url = URL(string: "https://\(baseURL)/3/movie/top_rated?api_key=\(apiKey)&page=1")
            else {
                throw APIClientError.urlError
            }
            
            let (jsonData, response) = try await URLSession.shared.data(from: url)
            
            guard let responseCheck = response as? HTTPURLResponse
            else {
                throw APIClientError.serverError
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(TopRatedList.self, from: jsonData)
            else {
                throw APIClientError.parsingError
            }
            
            return decodedResponse
        }
        catch APIClientError.urlError {
            print("The operation failed creating the URL")
        } catch APIClientError.serverError {
            print("The operation did not get a valid response")
        } catch APIClientError.parsingError {
            print("The operation failed failed to decode the response")
        } catch {
            print("An error happened!")
        }
        
        return nil
    }
    
    func getTopRatedMovies(completion: @escaping (Result<TopRatedListPage, Error>) -> Void) {
        //Sets the URL
        guard let myUrl = URL(string: "https://\(baseURL)/3/movie/top_rated?api_key=\(apiKey)&page=1")
        else {
            completion(.failure(APIClientError.urlError))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: myUrl) {
            (data, urlResponse, error) in
            
            guard let myData = data, let myResponse = urlResponse as? HTTPURLResponse, myResponse.statusCode == 200, error == nil
            else {
                completion(.failure(APIClientError.serverError))
                return
            }
            
            do {
                let myMovies = try JSONDecoder().decode(TopRatedListPage.self, from: myData)
                completion(.success(myMovies))
            }
            catch {
                completion(.failure(APIClientError.parsingError))
            }
        }
        
        dataTask.resume()
    }
}
