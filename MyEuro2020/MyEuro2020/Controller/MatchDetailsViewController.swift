//
//  MatchDetailsViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 15/06/2021.
//

import UIKit

class MatchDetailsViewController: UIViewController {
    
    static let identifier = "MatchDetailsViewController"
    
    var match: Match?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let homeImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let awayImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let homeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let awayNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Date"
        return label
    }()
    
    private let dateLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Place"
        return label
    }()
    
    private let placeLabelVal: UILabel = {
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

    private let matchdayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Matchday"
        return label
    }()
    
    private let matchdayLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(homeImageView)
        scrollView.addSubview(awayImageView)
        scrollView.addSubview(homeNameLabel)
        scrollView.addSubview(awayNameLabel)
        scrollView.addSubview(resultLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(groupLabel)
        scrollView.addSubview(matchdayLabel)
        scrollView.addSubview(dateLabelVal)
        scrollView.addSubview(placeLabelVal)
        scrollView.addSubview(groupLabelVal)
        scrollView.addSubview(matchdayLabelVal)
        
        navigationController?.edgesForExtendedLayout = []
        
        let tapHome = UITapGestureRecognizer(target: self, action: #selector(MatchDetailsViewController.tapHomeFunction))
        homeImageView.isUserInteractionEnabled = true
        homeImageView.addGestureRecognizer(tapHome)
        
        let tapAway = UITapGestureRecognizer(target: self, action: #selector(MatchDetailsViewController.tapAwayFunction))
        awayImageView.isUserInteractionEnabled = true
        awayImageView.addGestureRecognizer(tapAway)
    }
    
    @objc func tapHomeFunction(sender:UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(identifier: TeamDetailsViewController.identifier) as! TeamDetailsViewController
        guard let homeTeam = match?.homeTeam else {
            return
        }
        vc.team = homeTeam
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapAwayFunction(sender:UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(identifier: TeamDetailsViewController.identifier) as! TeamDetailsViewController
        guard let awayTeam = match?.awayTeam else {
            return
        }
        vc.team = awayTeam
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        
        let size = view.width / 5
        
        homeImageView.frame = CGRect(x: scrollView.width / 5 - size / 2, y: 30, width: size, height: size)
        homeImageView.roundedImage()
        
        awayImageView.frame = CGRect(x: scrollView.width - scrollView.width / 5 - size / 2, y: 30, width: size, height: size)
        awayImageView.roundedImage()
        
        homeNameLabel.frame = CGRect(x: scrollView.width / 5 - size, y: homeImageView.bottom + 5, width: scrollView.width / 5 * 2, height: 60)
        
        awayNameLabel.frame = CGRect(x: scrollView.width - scrollView.width / 5 - size, y: awayImageView.bottom + 5, width: scrollView.width / 5 * 2, height: 60)
        
        resultLabel.frame = CGRect(x: scrollView.width / 5 + size / 2, y: 30, width: scrollView.width - 2 * (homeImageView.frame.origin.x + homeImageView.width), height: size)
        
        dateLabel.frame = CGRect(x: 10, y: homeNameLabel.bottom + 15, width: scrollView.width - 20, height: 30)
        
        dateLabelVal.frame = CGRect(x: 10, y: dateLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        placeLabel.frame = CGRect(x: 10, y: dateLabelVal.bottom + 10, width: scrollView.width - 20, height: 30)
        
        placeLabelVal.frame = CGRect(x: 10, y: placeLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        groupLabel.frame = CGRect(x: 10, y: placeLabelVal.bottom + 10, width: scrollView.width - 20, height: 30)
        
        groupLabelVal.frame = CGRect(x: 10, y: groupLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        matchdayLabel.frame = CGRect(x: 10, y: groupLabelVal.bottom + 10, width: scrollView.width - 20, height: 30)
        
        matchdayLabelVal.frame = CGRect(x: 10, y: matchdayLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        scrollView.contentSize = CGSize(width: view.width, height: matchdayLabelVal.bottom)
        
        guard let match = match,
              let homeTeam = match.homeTeam,
              let awayTeam = match.awayTeam,
              let stadium = match.stadium else {
            return
        }
        
        homeImageView.image = UIImage(named: "\(homeTeam.logo)_circle")
        awayImageView.image = UIImage(named: "\(awayTeam.logo)_circle")

        homeNameLabel.text = homeTeam.name
        awayNameLabel.text = awayTeam.name
        
        if match.matchStatus == "not_played" {
            resultLabel.text = "TBP"
        } else {
            resultLabel.text = "\(match.homeResult) - \(match.awayResult)"
        }
        
        dateLabelVal.text = "\(formatDateString(date: match.date))"
        placeLabelVal.text = "\(stadium.name), \(stadium.city)"
        groupLabelVal.text = "\(match.group)"
        matchdayLabelVal.text = "\(match.matchday)"
    }
    
    private func formatDateString(date: String) -> String {
        var safeDate = date.replacingOccurrences(of: "_", with: ".")
        safeDate = safeDate.replacingOccurrences(of: ".2021", with: "")
        return safeDate
    }
}
