//
//  Match.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 12/06/2021.
//

import Foundation

struct Match {
    var id: Int
    var home: String
    var away: String
    var date: String
    var matchday: String
    var group: String
    var place: String
    var homeResult: Int
    var awayResult: Int
    var matchStatus: String
    
    var homeTeam: Team?
    var awayTeam: Team?
    var stadium: Stadium?
}
