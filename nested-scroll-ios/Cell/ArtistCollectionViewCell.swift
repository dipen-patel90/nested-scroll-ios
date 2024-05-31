//
//  ArtistCollectionViewCell.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 31/05/24.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    public static var identifier : String {
        get{
            return "ArtistCollectionViewCell"
        }
    }
    
    //    public static func register() -> UINib{
    //        UINib(nibName: "ArtistCollectionViewCell", bundle: nil)
    //    }
    
    var title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        
        initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        
        title.backgroundColor = UIColor.init(hex: "#EED95990")
        title.layer.cornerRadius = 16
        title.layer.masksToBounds = true
        title.textAlignment = .center
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
                title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            ]
        )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        title.isUserInteractionEnabled = true
        title.addGestureRecognizer(tap)
    }
    
    func setData(artist:String) {
        title.text = artist
    }
    
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        print("tap working")
    }
}
