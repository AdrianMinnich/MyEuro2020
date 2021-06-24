//
//  TeamDetailsViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 19/06/2021.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    static let identifier = "TeamDetailsViewController"
    
    var team: Team?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let goalsScoredLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Goals scored"
        return label
    }()
    
    private let goalsScoredLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let goalsConcededLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Goals conceded"
        return label
    }()
    
    private let goalsConcededLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let goalsDiffLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Goals difference"
        return label
    }()
    
    private let goalsDiffLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let matchesPlayedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Matches played"
        return label
    }()
    
    private let matchesPlayedLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let winsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Wins"
        return label
    }()
    
    private let winsLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let drawsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Draws"
        return label
    }()
    
    private let drawsLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let lossesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Losses"
        return label
    }()
    
    private let lossesLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let groupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Group"
        return label
    }()
    
    private let groupLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Position"
        return label
    }()
    
    private let positionLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Points"
        return label
    }()
    
    private let pointsLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(goalsScoredLabel)
        scrollView.addSubview(goalsConcededLabel)
        scrollView.addSubview(goalsDiffLabel)
        scrollView.addSubview(matchesPlayedLabel)
        scrollView.addSubview(winsLabel)
        scrollView.addSubview(drawsLabel)
        scrollView.addSubview(lossesLabel)
        scrollView.addSubview(groupLabel)
        scrollView.addSubview(positionLabel)
        scrollView.addSubview(pointsLabel)
        scrollView.addSubview(goalsScoredLabelVal)
        scrollView.addSubview(goalsConcededLabelVal)
        scrollView.addSubview(goalsDiffLabelVal)
        scrollView.addSubview(matchesPlayedLabelVal)
        scrollView.addSubview(winsLabelVal)
        scrollView.addSubview(drawsLabelVal)
        scrollView.addSubview(lossesLabelVal)
        scrollView.addSubview(groupLabelVal)
        scrollView.addSubview(positionLabelVal)
        scrollView.addSubview(pointsLabelVal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = view.width / 3
        
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.roundedImage()
        
        nameLabel.frame = CGRect(x: 30,
                                 y: imageView.bottom + 10,
                                 width: scrollView.width - 60,
                                 height: 40)
        
        positionLabel.frame = CGRect(x: 30, y: nameLabel.bottom + 20, width: scrollView.width - 60, height: 30)
        
        positionLabelVal.frame = CGRect(x: 30, y: positionLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        pointsLabel.frame = CGRect(x: 30, y: positionLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        pointsLabelVal.frame = CGRect(x: 30, y: pointsLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        groupLabel.frame = CGRect(x: 30, y: pointsLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        groupLabelVal.frame = CGRect(x: 30, y: groupLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        matchesPlayedLabel.frame = CGRect(x: 30, y: groupLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        matchesPlayedLabelVal.frame = CGRect(x: 30, y: matchesPlayedLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        winsLabel.frame = CGRect(x: 30, y: matchesPlayedLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        winsLabelVal.frame = CGRect(x: 30, y: winsLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        drawsLabel.frame = CGRect(x: 30, y: winsLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        drawsLabelVal.frame = CGRect(x: 30, y: drawsLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        lossesLabel.frame = CGRect(x: 30, y: drawsLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        lossesLabelVal.frame = CGRect(x: 30, y: lossesLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        goalsScoredLabel.frame = CGRect(x: 30, y: lossesLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        goalsScoredLabelVal.frame = CGRect(x: 30, y: goalsScoredLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        goalsConcededLabel.frame = CGRect(x: 30, y: goalsScoredLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        goalsConcededLabelVal.frame = CGRect(x: 30, y: goalsConcededLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        goalsDiffLabel.frame = CGRect(x: 30, y: goalsConcededLabelVal.bottom + 10, width: scrollView.width - 60, height: 30)
        
        goalsDiffLabelVal.frame = CGRect(x: 30, y: goalsDiffLabel.bottom + 2, width: scrollView.width - 60, height: 20)
        
        scrollView.contentSize = CGSize(width: view.width, height: goalsDiffLabelVal.bottom)
        
        guard let team = team else {
            return
        }
        
        imageView.image = UIImage(named: "\(team.logo)_circle")
        nameLabel.text = team.name
        positionLabelVal.text = "\(team.position)"
        pointsLabelVal.text = "\(team.points)"
        groupLabelVal.text = "\(team.group)"
        matchesPlayedLabelVal.text = "\(team.matchesPlayed)"
        winsLabelVal.text = "\(team.wins)"
        drawsLabelVal.text = "\(team.draws)"
        lossesLabelVal.text = "\(team.losses)"
        goalsScoredLabelVal.text = "\(team.goalsScored)"
        goalsConcededLabelVal.text = "\(team.goalsConceded)"
        if team.goalDiff > 0 {
            goalsDiffLabelVal.text = "+\(team.goalDiff)"
        } else {
            goalsDiffLabelVal.text = "\(team.goalDiff)"
        }
    }
}
