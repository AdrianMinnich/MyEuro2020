//
//  MatchBracket.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 24/06/2021.
//

import Foundation

struct MatchBracket {
    var id: Int
    var home: String
    var away: String
    var date: String
    var place: String
    var stage: String
    var homeResult: Int
    var awayResult: Int
    var matchStatus: String
    
    var homeTeam: Team?
    var awayTeam: Team?
    var stadium: Stadium?
    
    var predictedHomeResult: Int?
    var predictedAwayResult: Int?
    var predictedResult: PredictedResult?
}

enum PredictedResult {
    case HomeWin
    case AwayWin
    case Draw
}
