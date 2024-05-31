//
//  ListViewController.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 31/05/24.
//

import UIKit

class ListViewController: UIViewController {

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
            
            vw.addSubview(songTableView)
                        
            songTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    songTableView.topAnchor.constraint(equalTo: vw.topAnchor),
                    songTableView.leadingAnchor.constraint(equalTo: vw.leadingAnchor),
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


extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
    }
}
