//
//  StandingsViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 12/06/2021.
//

import UIKit

class StandingsViewController: UIViewController {

    static let identifier = "StandingsViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    var teams: [Team] = [Team]()
    
    var groupA: [Team] = [Team]()
    var groupB: [Team] = [Team]()
    var groupC: [Team] = [Team]()
    var groupD: [Team] = [Team]()
    var groupE: [Team] = [Team]()
    var groupF: [Team] = [Team]()
    var thirdPlace: [Team] = [Team]()
    
    var groups = [[Team]]()
    
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
                print("got all teams in standings!")
                
                self?.assignTeamsToGroups()
                
                self?.reloadTableView()
                
            case .failure(let error):
                print("failed to get teams: \(error)")
            }
        })
    }
    
    private func assignTeamsToGroups() {
        for i in 0..<self.teams.count {
            if teams[i].group == "A" {
                groupA.append(teams[i])
            } else if teams[i].group == "B" {
                groupB.append(teams[i])
            } else if teams[i].group == "C" {
                groupC.append(teams[i])
            } else if teams[i].group == "D" {
                groupD.append(teams[i])
            } else if teams[i].group == "E" {
                groupE.append(teams[i])
            } else if teams[i].group == "F" {
                groupF.append(teams[i])
            }
            
            if teams[i].position == 3 {
                thirdPlace.append(teams[i])
            }
        }

        sortTeamsInGroups()
        
        groups.append(groupA)
        groups.append(groupB)
        groups.append(groupC)
        groups.append(groupD)
        groups.append(groupE)
        groups.append(groupF)
        groups.append(thirdPlace)
    }
    
    private func sortTeamsInGroups() {
        groupA = groupA.sorted(by: {
            return $0.position < $1.position
        })
        groupB = groupB.sorted(by: {
            return $0.position < $1.position
        })
        groupC = groupC.sorted(by: {
            return $0.position < $1.position
        })
        groupD = groupD.sorted(by: {
            return $0.position < $1.position
        })
        groupE = groupE.sorted(by: {
            return $0.position < $1.position
        })
        groupF = groupF.sorted(by: {
            return $0.position < $1.position
        })
        thirdPlace = thirdPlace.sorted(by: {
            if $0.points != $1.points {
                return $0.points > $1.points
            }
            else if $0.goalDiff == $1.goalDiff{
                return $0.goalsScored > $1.goalsScored
            }
            else {
                return $0.goalDiff > $1.goalDiff
            }
        })
    }
}

extension StandingsViewController: UITableViewDataSource, UITableViewDelegate {
    func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model = groups[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.identifier, for: indexPath) as! TeamTableViewCell
        if indexPath.section == 6 {
            model.position = thirdPlace.firstIndex( where: { $0.name == model.name})! + 1
            cell.configure(with: model)
        } else {
            cell.configure(with: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = groups[indexPath.section][indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: TeamDetailsViewController.identifier) as! TeamDetailsViewController
        vc.team = model
        print(model.name)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Group A"
        } else if section == 1 {
            return "Group B"
        } else if section == 2 {
            return "Group C"
        } else if section == 3 {
            return "Group D"
        } else if section == 4 {
            return "Group E"
        } else if section == 5 {
            return "Group F"
        } else if section == 6 {
            return "Third place standings"
        }
        return ""
    }
}
