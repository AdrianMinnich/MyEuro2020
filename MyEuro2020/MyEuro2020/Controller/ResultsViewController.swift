//
//  ResultsViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 12/06/2021.
//

import UIKit

class ResultsViewController: UIViewController {

    static let identifier = "ResultsViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var matches = [Match]()
    var teams = [Team]()
    var stadiums = [Stadium]()
    
    var matchdayOne = [Match]()
    var matchdayTwo = [Match]()
    var matchdayThree = [Match]()
    
    var matchdays = [[Match]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        fetchDataFromDatabase()
        reloadTableView()
        
    }
    
    // MARK: - Helper functions
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helper functions
    
    private func printMatches() {
        print("before printing")
        for match in matches {
            print("\(match.date)  \(match.home) - \(match.away)  \(match.homeResult) : \(match.awayResult)")
        }
        print(matches.count)
        print("after printing")
    }
    
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
                
                self?.getMatchesFromDatabase()
                
            case .failure(let error):
                print("failed to get stadiums: \(error)")
            }
        })
    }
    
    private func getMatchesFromDatabase() {
        
        DatabaseManager.shared.getMatches(completion: { [weak self] result in
            switch result {
            case .success(let matchesCollection):
                guard !matchesCollection.isEmpty else {
                    return
                }
                self?.matches = matchesCollection
                print("got all matches!")
                
                self?.reloadTableView()
                
                self?.assignTeamsToMatches()
                self?.assignStadiumsToMatches()
                self?.assignMatchesToMatchdays()
                
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
            if matches[i].matchday == "1" {
                matchdayOne.append(matches[i])
            } else if matches[i].matchday == "2" {
                matchdayTwo.append(matches[i])
            } else if matches[i].matchday == "3" {
                matchdayThree.append(matches[i])
            }
        }
        matchdays.append(matchdayOne)
        matchdays.append(matchdayTwo)
        matchdays.append(matchdayThree)
    }
}

// MARK: - Table View Methods

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: MatchTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchdays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchdays[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = matchdays[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.identifier, for: indexPath) as! MatchTableViewCell
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = matchdays[indexPath.section][indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: MatchDetailsViewController.identifier) as! MatchDetailsViewController
        vc.match = model
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Matchday 1"
        } else if section == 1 {
            return "Matchday 2"
        } else if section == 2 {
            return "Matchday 3"
        }
        return ""
    }
}
