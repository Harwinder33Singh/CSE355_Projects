//
//  MovieRecord.swift
//  CSE355-LAB4
//
//  Created by Harwinder Singh on 9/25/23.
//

import Foundation
class MovieRecord {
    var movieTitle: String? = nil
    var movieGenre: String? = nil
    var ticketPrice: Int64? = nil
    
    init(movieTitle: String, movieGenre: String, ticketPrice: Int64) {
        self.movieTitle = movieTitle
        self.movieGenre = movieGenre
        self.ticketPrice = ticketPrice
    }
    func setTicketSale(newTicketPrice:Int64) {
        self.ticketPrice = newTicketPrice
    }
}
