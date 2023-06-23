//
//  TopMoviesTableViewCell.swift
//  Rest API
//
//  Created by Hooma7n on 5/16/23.
//

import UIKit
import Kingfisher

class TopMoviesTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    private var urlString: String = ""


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //setup movie values
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?,overview: String? , poster: String?){
        self.movieTitle?.text = title
        self.movieYear?.text = convertDateFormater(releaseDate)
        guard let rate  = rating else  {return}
        self.movieRate?.text = String(rate)
        self.movieOverView?.text = overview
        
        
        
        guard poster != nil else {return}
        urlString = "https://image.tmdb.org/t/p/w300\(poster ?? "")"
        
        print(poster)
        
        let url = URL(string: urlString)
        moviePoster.kf.setImage(with: url)
        
//        guard let posterImageURL = URL(string: urlString) else  {
//            self.moviePoster?.image = UIImage(named: "image")
//            return
//        }
//        //Before Download the image we clear
//        self.moviePoster?.image = nil
//        getImageDataFrom(url: posterImageURL)
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
                    self.moviePoster.image = image
                    
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
