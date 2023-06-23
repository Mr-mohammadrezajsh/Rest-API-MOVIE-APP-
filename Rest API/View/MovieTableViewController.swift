//
//  MovieViewController.swift
//  Rest API
//
//  Created by mohammadreza on 2/23/1402 AP.
//

import UIKit


// in viewcontroller nis TableViewCell hast
class MovieTableViewController: UITableViewCell {

    @IBOutlet weak var MoviePoster: UIImageView!
    
    @IBOutlet weak var movieTittle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    private var urlString: String = ""
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    //setup movie values
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    //update the ui views
    private func updateUI(title: String?, releaseDate: String?, rating: Double?,overview: String? , poster: String?){
        self.movieTittle?.text = title
        self.movieYear?.text = convertDateFormater(releaseDate)
        guard let rate  = rating else  {return}
        self.movieRate?.text = String(rate)
        self.movieOverView?.text = overview
        
        guard poster != nil else {return}
        urlString = "https://image.tmdb.org/t/p/w300"
        
        guard let posterImageURL = URL(string: urlString) else  {
            self.MoviePoster?.image = UIImage(named: "image")
            return
        }
        //Before Download the image we clear
        self.MoviePoster?.image = nil
        getImageDataFrom(url: posterImageURL)
    }
    private func getImageDataFrom(url: URL){
        URLSession.shared.dataTask(with: url){ (data, respose,error ) in
            //Handle Error
            if let error  = error {
                print("Data TaskError\(error.localizedDescription)")
                return
            }
            guard let data = data else {
                //Handle Empty Error
                print("EMpty Error")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.MoviePoster.image = image
                    
                }
            }
        }.resume()
    }
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.mm.yyyy"
                fixDate = dateFormatter.string(from: newDate)
                
            }
        }
        
        return fixDate
        
    }
}
