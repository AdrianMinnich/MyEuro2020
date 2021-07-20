//
//  MatchBracket.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 24/06/2021.
//

import Foundation
import RealmSwift

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
    var matchResult: MatchResult
    
    var homeTeam: Team?
    var awayTeam: Team?
    var stadium: Stadium?
    
    var predictedHomeResult: Int?
    var predictedAwayResult: Int?
    var predictedResult: MatchResult?
    var isPredicted: Bool = false
}

class MatchBracketPredictedRealm: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var predictedHome: Int = -1
    @objc dynamic var predictedAway: Int = -1
    @objc dynamic var isPredicted: Bool = false
}

enum MatchResult {
    case HomeWin
    case AwayWin
    case Draw
}
