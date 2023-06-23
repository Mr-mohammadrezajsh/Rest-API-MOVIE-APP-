//
//  ViewController.swift
//  Rest API
//
//  Created by mohammadreza on 2/23/1402 AP.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    private var viewModel = MovieViewMode()
    private var model = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(cellType: TopMoviesTableViewCell.self)
//        tableview.register(MovieTableViewController.self, forCellReuseIdentifier: "MovieTableViewController")
        viewModel.delegate = self
        loadPopularMoviesData()
        

    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableview.dataSource = self
            self?.tableview.reloadData()
        }
    }


}
//TableView
extension MovieViewController : UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TopMoviesTableViewCell = tableview.dequeueReusableCell(for: indexPath)
        let movie = model[indexPath.row]
        cell.setCellWithValuesOf(movie)
        return cell
    }
}

extension MovieViewController: MoviesViewModelDelegate {
    
    func fetchMovies() {
        
    }
    
    func fetchingDone(data: [Movie]) {
        self.model = data
        self.tableview.reloadData()
    }
    
    
}
