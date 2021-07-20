//
//  DatabaseManager.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 12/06/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func getMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        database.child("matches").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.FailedToGetData))
                return
            }
            
            let matches: [Match] = value.compactMap({ dictionary in
                guard let id = dictionary["id"] as? Int,
                      let home = dictionary["home"] as? String,
                      let away = dictionary["away"] as? String,
                      let date = dictionary["date"] as? String,
                      let matchday = dictionary["matchday"] as? String,
                      let group = dictionary["group"] as? String,
                      let place = dictionary["place"] as? String,
                      let homeResult = dictionary["home_result"] as? Int,
                      let awayResult = dictionary["away_result"] as? Int,
                      let matchStatus = dictionary["match_status"] as? String else {
                        return nil
                }
                return Match(id: id, home: home, away: away, date: date, matchday: matchday, group: group, place: place, homeResult: homeResult, awayResult: awayResult, matchStatus: matchStatus)
                      
            })
            completion(.success(matches))
        })
    }
    
    public func getTeams(completion: @escaping(Result<[Team], Error>) -> Void) {
        database.child("teams").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.FailedToGetData))
                return
            }
            
            let teams: [Team] = value.compactMap({ dictionary in
                guard let id = dictionary["id"] as? Int,
                      let name = dictionary["name"] as? String,
                      let short = dictionary["short"] as? String,
                      let logo = dictionary["logo"] as? String,
                      let matchesPlayed = dictionary["matches_played"] as? Int,
                      let wins = dictionary["wins"] as? Int,
                      let draws = dictionary["draws"] as? Int,
                      let losses = dictionary["losses"] as? Int,
                      let goalsScored = dictionary["goals_scored"] as? Int,
                      let goalsConceded = dictionary["goals_conceded"] as? Int,
                      let points = dictionary["points"] as? Int,
                      let group = dictionary["group"] as? String,
                      let position = dictionary["position"] as? Int else {
                        return nil
                }
                return Team(id: id, name: name, short: short, logo: logo, matchesPlayed: matchesPlayed, wins: wins, draws: draws, losses: losses, goalsScored: goalsScored, goalsConceded: goalsConceded, points: points, group: group, position: position)
            })
            completion(.success(teams))
        })
    }
    
    public func getStadiums(completion: @escaping(Result<[Stadium], Error>) -> Void) {
        database.child("places").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.FailedToGetData))
                return
            }
            
            let stadiums: [Stadium] = value.compactMap({ dictionary in
                guard let id = dictionary["id"] as? Int,
                      let name = dictionary["stadium"] as? String,
                      let city = dictionary["city"] as? String,
                      let country = dictionary["country"] as? String,
                      let capacity = dictionary["capacity"] as? Int,
                      let photo = dictionary["photo"] as? String else {
                    return nil
                }
                return Stadium(id: id, name: name, city: city, county: country, capacity: capacity, photo: photo)
            })
            completion(.success(stadiums))
        })
    }
    
    public func getStandings(completion: @escaping(Result<[Group], Error>) -> Void) {
        database.child("standings").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.FailedToGetData))
                return
            }
            
            let groups: [Group] = value.compactMap({ dictionary in
                guard let teamOne = dictionary["1"] as? String,
                      let teamTwo = dictionary["2"] as? String,
                      let teamThree = dictionary["3"] as? String,
                      let teamFour = dictionary["4"] as? String,
                      let groupName = dictionary["group"] as? String else {
                    return nil
                }
                return Group(teamOneName: teamOne, teamTwoName: teamTwo, teamThreeName: teamThree, teamFourName: teamFour, groupName: groupName)
            })
            completion(.success(groups))
        })
    }
    
    public func getBracket(completion: @escaping (Result<[MatchBracket], Error>) -> Void) {
        database.child("brackets").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.FailedToGetData))
                return
            }
            
            let matches: [MatchBracket] = value.compactMap({ dictionary in
                guard let id = dictionary["id"] as? Int,
                      let home = dictionary["home"] as? String,
                      let away = dictionary["away"] as? String,
                      let date = dictionary["date"] as? String,
                      let stage = dictionary["stage"] as? String,
                      let place = dictionary["place"] as? String,
                      let homeResult = dictionary["home_result"] as? Int,
                      let awayResult = dictionary["away_result"] as? Int,
                      let matchStatus = dictionary["match_status"] as? String else {
                        return nil
                }
                
                let matchResult: MatchResult
                
                if homeResult > awayResult {
                    matchResult = MatchResult.HomeWin
                } else if homeResult < awayResult {
                    matchResult = MatchResult.AwayWin
                } else {
                    matchResult = MatchResult.Draw
                }
                
                return MatchBracket(id: id, home: home, away: away, date: date, place: place, stage: stage, homeResult: homeResult, awayResult: awayResult, matchStatus: matchStatus, matchResult: matchResult)
                      
            })
            completion(.success(matches))
        })
    }
    
    public enum DatabaseError: Error {
        case FailedToGetData
    }
}
