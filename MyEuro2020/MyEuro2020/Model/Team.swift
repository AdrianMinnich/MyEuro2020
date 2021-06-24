//
//  Team.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 13/06/2021.
//

import Foundation

struct Team: Equatable {
    var id: Int
    var name: String
    var short: String
    var logo: String
    var matchesPlayed: Int
    var wins: Int
    var draws: Int
    var losses: Int
    var goalsScored: Int
    var goalsConceded: Int
    var goalDiff: Int {
        goalsScored - goalsConceded
    }
    var points: Int
    var group: String
    var position: Int
}
