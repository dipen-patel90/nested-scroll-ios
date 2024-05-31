//
//  SongTableViewCell.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 31/05/24.
//

import UIKit

protocol SongTableViewCellDelegate : AnyObject {
    func onArtistTap(song:Song?, artist:String) -> Void
}

class SongTableViewCell: UITableViewCell {
    
    weak var delegate: SongTableViewCellDelegate?
    
    public static var identifier : String {
        get{
            return "SongTableViewCell"
        }
    }
    
    //    public static func register() -> UINib{
    //        UINib(nibName: "SongTableViewCell", bundle: nil)
    //    }
    
    
    var imgView = UIImageView()
    var title = UILabel()
    var collectionView: UICollectionView!
    
    var maxCellHeight: CGFloat = 0
    var song: Song?
    var artist: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imgView)
        addSubview(title)
        
        initViews()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initViews() {
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
                imgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                imgView.heightAnchor.constraint(equalToConstant: 100),
                imgView.widthAnchor.constraint(equalToConstant: 100),
            ]
        )
        
        
        title.numberOfLines = 1
        title.adjustsFontSizeToFitWidth = true
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                title.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 20),
                title.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 8),
                title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            ]
        )
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 20),
                collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                collectionView.bottomAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -8),
            ]
        )
    }
    
    func setupCell() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.layer.cornerRadius = 4
        
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: ArtistCollectionViewCell.identifier)
    }
    
    func setData(song:Song) {
        self.song = song
        artist = song.artist
        
        imgView.image = UIImage(named: song.image)
        title.text = song.title
        
        let id = Int(song.uniquId) ?? 0
        if(id%2 == 0){
            backgroundColor = UIColor.init(hex: "#3CA99F90")
            collectionView.backgroundColor = UIColor.init(hex: "#FFD3D390")
        }else {
            backgroundColor = UIColor.init(hex: "#FFD3D390")
            collectionView.backgroundColor = UIColor.init(hex: "#3CA99F90")
        }
    }
}


extension SongTableViewCell : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SongTableViewCell : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCollectionViewCell.identifier, for: indexPath) as! ArtistCollectionViewCell
        let title = artist[indexPath.item]
        cell.setData(artist: title)
        cell.delegate = self
        
        return cell
    }
}

extension SongTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension SongTableViewCell : ArtistCollectionViewCellDelegate {
    func onArtistTap(artist: String) {
        delegate?.onArtistTap(song: song, artist: artist)
    }
}
