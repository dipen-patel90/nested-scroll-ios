//
//  SongDetailViewController.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 01/06/24.
//

import UIKit

class SongDetailViewController: UIViewController {
    
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
        
    }
}
