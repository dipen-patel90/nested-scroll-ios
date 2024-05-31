//
//  ListViewController.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 31/05/24.
//

import UIKit

class SongListViewController: UIViewController {
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Enter Song Title"
        return searchController
    }()
    
    let songTableView = UITableView()
    
    var songsList : [Song] = []
    
    let viewModel = SongViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        setupController()
        bindViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getSongList()
    }
    
    func initViews() {
        if let vw = self.view{
            
            vw.backgroundColor = .systemBackground
            title = "Song List"
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.searchController = searchController
            
            vw.addSubview(songTableView)
            
            
            songTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    songTableView.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
                    songTableView.topAnchor.constraint(equalTo: vw.topAnchor),
                    songTableView.trailingAnchor.constraint(equalTo: vw.trailingAnchor),
                    songTableView.bottomAnchor.constraint(equalTo: vw.bottomAnchor)
                ]
            )
            songTableView.rowHeight = 120
        }
    }
    
    func setupController() {
        songTableView.register(SongTableViewCell.self, forCellReuseIdentifier: SongTableViewCell.identifier)
        
        songTableView.delegate = self
        songTableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    func bindViews() {
        viewModel.songList.bind{ [weak self] results in
            
            guard let self = self, let songs = results else {
                return
            }
            
            self.songsList = songs
            self.songTableView.reloadData()
        }
    }
}


extension SongListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.identifier) as! SongTableViewCell
        
        let data = songsList[indexPath.row]
        cell.setData(song: data)
        
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songsList[indexPath.row]
        
        let vm = SongDetailViewModel(song: song)
        let vc = SongDetailViewController(detailViewModel: vm)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension SongListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterSongs(searchKey: searchText)
    }
}

extension SongListViewController : SongTableViewCellDelegate {
    func onArtistTap(song: Song?, artist: String) {
        showToast(message: "Song: \(song?.title ?? "") \n Artist: \(artist)")
    }
}
