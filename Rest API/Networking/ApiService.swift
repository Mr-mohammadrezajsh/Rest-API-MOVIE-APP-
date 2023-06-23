//
//  ApiService.swift
//  Rest API
//
//  Created by mohammadreza on 2/23/1402 AP.
//

import Foundation

class ApiService{
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void){
        
        let popularMoviesURL =
                "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesURL) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //handle error
            if let error = error {
                completion(.failure(error))
                print("Data Task Error\(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else{
                //handle Empty Respose
                print("Empty Response")
                return
                
            }
            print("Response status code :\(response.statusCode)")
            guard let data = data else {
                //Handle Empty Data
                print("Empty Data")
                return
            }
            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
        
    }
}
