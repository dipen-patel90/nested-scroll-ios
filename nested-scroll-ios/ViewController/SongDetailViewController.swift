//
//  SongDetailViewController.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 01/06/24.
//

import UIKit

class SongDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var detailViewModel : SongDetailViewModel
    
    init(detailViewModel: SongDetailViewModel) {
        self.detailViewModel = detailViewModel
        
        super.init(nibName: "SongDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    func initViews() {
        
        imageView.image = UIImage(named: detailViewModel.song.image)
        songLabel.text = detailViewModel.song.title
        let a = detailViewModel.song.artist.joined(separator: "\n")
        print(a)
        artistLabel.text = detailViewModel.song.artist.joined(separator: "\n")
    }
}
