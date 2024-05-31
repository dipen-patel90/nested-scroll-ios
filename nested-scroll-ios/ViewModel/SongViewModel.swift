//
//  SongViewModel.swift
//  nested-scroll-ios
//
//  Created by Dipen Patel on 31/05/24.
//

import Foundation

class SongViewModel{
    
    var songList : Observable<[Song]> = Observable(nil)
    
    let songDummyData = [
        Song(uniquId: "1", image: "SongIcon", title: "A Song 1", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "2", image: "SongIcon", title: "B Song 2", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "3", image: "SongIcon", title: "C Song 3", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "4", image: "SongIcon", title: "D Song 4", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "5", image: "SongIcon", title: "E Song 5", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "6", image: "SongIcon", title: "F Song 6", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "7", image: "SongIcon", title: "G Song 7", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "8", image: "SongIcon", title: "H Song 8", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "9", image: "SongIcon", title: "I Song 9", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
        Song(uniquId: "10", image: "SongIcon", title: "J Song 10", artist: ["KK", "Sonu", "Badshah", "Arijit", "Sunidhi", "Alka", "Lata", "RD", "Mukesh"]),
    ]
    
    
    func getSongList() {
        self.songList.value = songDummyData
    }
    
    func filterSongs(searchKey:String?) {
        
        if let sk = searchKey{
            if(sk.isEmpty){
                self.songList.value = songDummyData
            } else{
                self.songList.value = songDummyData.filter({ model in
                    model.title.contains(sk)
                })
            }
        } else {
            self.songList.value = songDummyData
        }
    }
}
