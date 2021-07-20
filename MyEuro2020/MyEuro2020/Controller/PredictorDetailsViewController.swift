//
//  PredictorDetailsViewController.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 24/06/2021.
//

import UIKit
import RealmSwift

protocol UpdateDataDelegate {
    func updateCacheData()
}

class PredictorDetailsViewController: UIViewController {

    static let identifier = "PredictorDetailsViewController"
    
    var match: MatchBracket?
    
    let realm = try! Realm()
    
    var delegate: UpdateDataDelegate?
    
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
    
    private let stageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Stage"
        return label
    }()
    
    private let stageLabelVal: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let predictScoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Predict score", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    private let predictedScoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Your prediction"
        return label
    }()
    
    private let predictedScoreLabelVal: UILabel = {
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
        scrollView.addSubview(stageLabel)
        scrollView.addSubview(dateLabelVal)
        scrollView.addSubview(placeLabelVal)
        scrollView.addSubview(stageLabelVal)
        scrollView.addSubview(predictScoreButton)
        scrollView.addSubview(predictedScoreLabel)
        scrollView.addSubview(predictedScoreLabelVal)
        
        navigationController?.edgesForExtendedLayout = []
        
        let tapHome = UITapGestureRecognizer(target: self, action: #selector(PredictorDetailsViewController.tapHomeFunction))
        homeImageView.isUserInteractionEnabled = true
        homeImageView.addGestureRecognizer(tapHome)
        
        let tapAway = UITapGestureRecognizer(target: self, action: #selector(PredictorDetailsViewController.tapAwayFunction))
        awayImageView.isUserInteractionEnabled = true
        awayImageView.addGestureRecognizer(tapAway)
        
        predictScoreButton.addTarget(self, action: #selector(predictResultButtonTapped), for: .touchUpInside)

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

    @objc func predictResultButtonTapped(sender: UITapGestureRecognizer) {
        print("tapped")
        
        guard let match = match,
              let homeTeam = match.homeTeam,
              let awayTeam = match.awayTeam else {
            return
        }
        
        let msg = "\(homeTeam.name) - \(awayTeam.name)"
        
        let alert = UIAlertController(title: "Predict the score", message: msg, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { field in
            field.returnKeyType = .next
            field.keyboardType = .decimalPad
            field.placeholder = "\(homeTeam.name)"
        })
        
        alert.addTextField(configurationHandler: { field in
            field.returnKeyType = .done
            field.keyboardType = .decimalPad
            field.placeholder = "\(awayTeam.name)"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] action in
            
            guard let fields = alert.textFields, fields.count == 2 else {
                return
            }
            let homeField = fields[0]
            let awayField = fields[1]
            
            guard let homeResult = homeField.text, !homeResult.isEmpty,
                  let awayResult = awayField.text, !awayResult.isEmpty else {
                print("bad data in alert")
                return
            }
        
            
            self?.match?.predictedHomeResult = Int(homeResult)
            self?.match?.predictedAwayResult = Int(awayResult)
            
            guard let predictedHome = self?.match?.predictedHomeResult,
                  let predictedAway = self?.match?.predictedAwayResult else {
                return
            }
            
            if predictedHome > predictedAway {
                self?.match?.predictedResult = .HomeWin
            } else if predictedHome > predictedAway {
                self?.match?.predictedResult = .AwayWin
            } else {
                self?.match?.predictedResult = .Draw
            }
            
            self?.match?.isPredicted = true
            print("\(String(describing: self?.match?.predictedHomeResult!))")
            print("\(String(describing: self?.match?.predictedAwayResult!))")
            
            self?.highlightPredictedScore()
            
            self?.savePredictedScoreToCache()
            
            self?.delegate?.updateCacheData()
            
        }))
        
        present(alert, animated: true, completion: nil)
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
        
        predictScoreButton.frame = CGRect(x: 10, y: homeNameLabel.bottom + 15, width: scrollView.width - 20, height: 40)
        
        predictedScoreLabel.frame = CGRect(x: 10, y: predictScoreButton.bottom + 10, width: scrollView.width - 20, height: 30)
        
        predictedScoreLabelVal.frame = CGRect(x: 10, y: predictedScoreLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        dateLabel.frame = CGRect(x: 10, y: predictedScoreLabelVal.bottom + 10, width: scrollView.width - 20, height: 30)
        
        dateLabelVal.frame = CGRect(x: 10, y: dateLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        placeLabel.frame = CGRect(x: 10, y: dateLabelVal.bottom + 10, width: scrollView.width - 20, height: 30)
        
        placeLabelVal.frame = CGRect(x: 10, y: placeLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        stageLabel.frame = CGRect(x: 10, y: placeLabelVal.bottom + 10, width: scrollView.width - 20, height: 30)
        
        stageLabelVal.frame = CGRect(x: 10, y: stageLabel.bottom + 2, width: scrollView.width - 20, height: 20)
        
        scrollView.contentSize = CGSize(width: view.width, height: stageLabelVal.bottom)
        
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
        stageLabelVal.text = "\(match.stage)"
        
        highlightPredictedScore()

    }
    
    private func formatDateString(date: String) -> String {
        var safeDate = date.replacingOccurrences(of: "_", with: ".")
        safeDate = safeDate.replacingOccurrences(of: ".2021", with: "")
        return safeDate
    }
    
    private func highlightPredictedScore() {
        
        guard let match = match else {
            return
        }
        
        if match.isPredicted == false {
            if match.matchStatus == "played" {
                predictedScoreLabelVal.text = "You didn't make a prediction"
                predictedScoreLabelVal.textColor = .systemBlue
                predictScoreButton.isEnabled = false
                predictScoreButton.setTitle("Cannot make a prediction anymore", for: .normal)
            }
            else {
                predictedScoreLabelVal.text = "Make a prediction!"
                predictedScoreLabelVal.textColor = .systemBlue
                predictScoreButton.isEnabled = true
            }
            
        } else {
            predictedScoreLabelVal.text = "\(match.predictedHomeResult!) - \(match.predictedAwayResult!)"
            if match.matchStatus == "played" {
                predictScoreButton.isEnabled = false
                
                if match.homeResult == match.predictedHomeResult! && match.awayResult == match.predictedAwayResult! {
                    predictedScoreLabelVal.textColor = .systemGreen
                    predictScoreButton.setTitle("You've predicted an exact score!", for: .normal)
                    predictScoreButton.backgroundColor = .systemGreen
                }
                else if match.matchResult == match.predictedResult! {
                    predictedScoreLabelVal.textColor = .systemYellow
                    predictScoreButton.setTitle("You've predicted a winner!", for: .normal)
                    predictScoreButton.backgroundColor = .systemYellow
                }
                else {
                    predictedScoreLabelVal.textColor = .systemRed
                    predictScoreButton.setTitle("You've made an incorrect prediction.", for: .normal)
                    predictScoreButton.backgroundColor = .systemRed
                }
            }
            else {
                predictedScoreLabelVal.textColor = .systemBlue
            }
        }
    }
    
    private func savePredictedScoreToCache() {
        
        guard let match = match,
              let predictedHomeResult = match.predictedHomeResult,
              let predictedAwayResult = match.predictedAwayResult else {
            return
        }
        
        let results = realm.objects(MatchBracketPredictedRealm.self)
        
        let objectsToDelete = results.filter{ $0.id == match.id}
        
        realm.beginWrite()
        
        if objectsToDelete.count > 0 {
            realm.delete(objectsToDelete)
        }
        
        let game = MatchBracketPredictedRealm()
        game.id = match.id
        game.predictedHome = predictedHomeResult
        game.predictedAway = predictedAwayResult
        game.isPredicted = true
        
        realm.add(game)
        
        try! realm.commitWrite()
        
    }
}
