//
//  InfoDictonary.swift
//  CSE355-LAB4
//
//  Created by Harwinder Singh on 9/25/23.
//

import Foundation

class InfoDictionary: ObservableObject {
    @Published var infoRepository : [String: MovieRecord] = [String: MovieRecord]()
    init(){}
    
    func add(movieTitle:String, movieGenre:String, ticketPrice:Int64) {
        let mRecord = MovieRecord(movieTitle: movieTitle, movieGenre: movieGenre, ticketPrice: ticketPrice)
        infoRepository[mRecord.movieTitle!] = mRecord
    }
    
    func getCount() -> Int {
        return infoRepository.count
    }
    
    func add(movieRecord: MovieRecord) {
        infoRepository[movieRecord.movieTitle!] = movieRecord
    }
    
    func delete(movieToBeDeleted: String) {
        infoRepository[movieToBeDeleted] = nil
    }
    
    func search(movieSearch:String) -> MovieRecord? {
        for (movieTitle, _) in infoRepository {
            if movieTitle == movieSearch {
                return infoRepository[movieSearch]
            }
        }
        return nil
    }
    
    func edit(movieTitle: String, movieGenreUpdated: String, ticketPriceUpdated: Int64) {
        if let movieFound = search(movieSearch: movieTitle) {
            infoRepository[movieFound.movieTitle!]?.movieGenre = movieGenreUpdated
            infoRepository[movieFound.movieTitle!]?.ticketPrice = ticketPriceUpdated
        }
    }
}
