//
//  MovieViewMode.swift
//  Rest API
//
//  Created by mohammadreza on 2/23/1402 AP.
//

import Foundation
import UIKit

protocol MoviesViewModelDelegate: AnyObject {
    func fetchMovies()
    func fetchingDone(data: [Movie])
}

typealias MoviesViewModelDelegateType = UIViewController & MoviesViewModelDelegate

class MovieViewMode {
    
    weak var delegate: MoviesViewModelDelegateType?
    private var apiService = ApiService()
    private var popularMovies = [Movie]()
    
    public func setViewDelegate(delegate: MoviesViewModelDelegateType) {
        self.delegate = delegate
    }
    
    func fetchPopularMoviesData(completion: @escaping () -> ()){
        apiService.getPopularMoviesData { [weak self](result) in
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                self?.delegate?.fetchingDone(data: listOf.movies)
                completion()
            case .failure(let error):
                print("Error processing json data :\(error)")
                
            }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    func cellForRowAt (indexPath : IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}
