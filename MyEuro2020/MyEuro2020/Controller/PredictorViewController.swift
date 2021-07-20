//
//  PredictorViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 12/06/2021.
//

import UIKit
import RealmSwift

class PredictorViewController: UIViewController {

    static let identifier = "PredictorViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var matches = [MatchBracket]()
    var teams = [Team]()
    var stadiums = [Stadium]()
    
    var roundOf16 = [MatchBracket]()
    var quaterFinals = [MatchBracket]()
    var semiFinals = [MatchBracket]()
    var final = [MatchBracket]()
    
    var matchdays = [[MatchBracket]]()
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        fetchDataFromDatabase()
        reloadTableView()
        
    }
    
    // 1. getting data from database (matches) (Database Manager method) DONE
    // 2. table view with matches ( 1/8, 1/4, 1/2...) (tableView methods) DONE
    // 3. possibility to predict exact score (PredictorDetailsViewController) DONE
    // 4. locking picks when match_status is played DONE
    // 5. saving picks in Realm (save models to Realm), while fetching data check isPredicted which are stored locally DONE
    // 6. showing which one is won and which one is lost (PredictdDetailsViewController UI) DONE
    // 7. refreshing tableview after coming back from predictor details view controller automatically NOTDONE
    // 8. update database DONE
    // 9. unit tests ...
    
    // MARK: - Helper functions
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("reload table view")
    }
    
    // MARK: - Helper functions
    
    private func printTeams() {
        for team in teams {
            print("\(team.name)")
        }
        print(teams.count)
    }
    
    // MARK: - Fetching data from Firebase Database
    
    private func fetchDataFromDatabase() {
        getTeamsFromDatabase()
    }
    
    private func getTeamsFromDatabase() {
        
        DatabaseManager.shared.getTeams(completion: { [weak self] result in
            switch result {
            case .success(let teamsCollection):
                guard !teamsCollection.isEmpty else {
                    return
                }
                self?.teams = teamsCollection
                print("got all teams!")
                
                self?.getStadiumsFromDatabase()
                
            case .failure(let error):
                print("failed to get teams: \(error)")
            }
        })
    }
    
    private func getStadiumsFromDatabase() {
        
        DatabaseManager.shared.getStadiums(completion: { [weak self] result in
            switch result {
            case .success(let stadiumsCollection):
                guard !stadiumsCollection.isEmpty else {
                    return
                }
                self?.stadiums = stadiumsCollection
                print("got all stadiums")
                
                self?.getBracketFromDatabase()
                
            case .failure(let error):
                print("failed to get stadiums: \(error)")
            }
        })
    }
    
    private func getBracketFromDatabase() {
        
        DatabaseManager.shared.getBracket(completion: { [weak self] result in
            switch result {
            case .success(let matchesCollection):
                guard !matchesCollection.isEmpty else {
                    return
                }
                self?.matches = matchesCollection
                print("got all matches!")
                
                self?.assignTeamsToMatches()
                self?.assignStadiumsToMatches()
                self?.getPredictedResultsFromCache()
                self?.assignMatchesToMatchdays()
                
                self?.reloadTableView()
                
            case .failure(let error):
                print("failed to get matches: \(error)")
            }
        })
    }
    
    private func assignTeamsToMatches() {
        for i in 0..<self.matches.count {
            matches[i].homeTeam = teams.first(where: { $0.name == self.matches[i].home})
            matches[i].awayTeam = teams.first(where: { $0.name == self.matches[i].away})
        }
    }
    
    private func assignStadiumsToMatches() {
        for i in 0..<self.matches.count {
            matches[i].stadium = stadiums.first(where: { $0.city == self.matches[i].place})
        }
    }
    
    private func assignMatchesToMatchdays() {
        for i in 0..<self.matches.count {
            if matches[i].stage == "1/8" {
                roundOf16.append(matches[i])
            } else if matches[i].stage == "1/4" {
                quaterFinals.append(matches[i])
            } else if matches[i].stage == "1/2" {
                semiFinals.append(matches[i])
            } else if matches[i].stage == "final" {
                final.append(matches[i])
            }
        }
        matchdays.append(roundOf16)
        matchdays.append(quaterFinals)
        matchdays.append(semiFinals)
        matchdays.append(final)
    }
    
    private func getPredictedResultsFromCache() {
        let predictedResults = realm.objects(MatchBracketPredictedRealm.self) // put as variable in ViewController and creates observer for changing that value
        print("GET PREDICTED RESULTS FROM CACHE")
        for i in 0..<predictedResults.count {
            let index = matches.firstIndex(where: { $0.id == predictedResults[i].id})
            print(index!)
            matches[index!].predictedHomeResult = predictedResults[i].predictedHome
            matches[index!].predictedAwayResult = predictedResults[i].predictedAway
            matches[index!].isPredicted = true
            matches[index!].predictedResult = assignPredictedResult(match: predictedResults[i])
        }
    }
    
    private func assignPredictedResult(match: MatchBracketPredictedRealm) -> MatchResult{
            
        if match.predictedHome > match.predictedAway {
            return .HomeWin
        } else if match.predictedHome < match.predictedAway {
            return .AwayWin
        } else {
            return .Draw
        }
    }
}

// MARK: - Table View Methods

extension PredictorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(PredictorTableViewCell.self, forCellReuseIdentifier: PredictorTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchdays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchdays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = matchdays[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PredictorTableViewCell.identifier, for: indexPath) as! PredictorTableViewCell
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = matchdays[indexPath.section][indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: PredictorDetailsViewController.identifier) as! PredictorDetailsViewController
        vc.match = model
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Round of 16"
        } else if section == 1 {
            return "Quater-finals"
        } else if section == 2 {
            return "Semi-finals"
        } else if section == 3 {
            return "Final"
        }
        return ""
    }
}

extension PredictorViewController: UpdateDataDelegate {
    
    func updateCacheData() {
        getPredictedResultsFromCache()
        assignMatchesToMatchdays()
        reloadTableView()
    }
 
}
