//
//  PredictorTableViewCell.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 24/06/2021.
//

import UIKit

class PredictorTableViewCell: UITableViewCell {

    static let identifier = "PredictorTableViewCell"
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let homeFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let awayFlagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(placeLabel)
        contentView.addSubview(homeFlagImageView)
        contentView.addSubview(awayFlagImageView)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(resultLabel)
        contentView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeLabel.text = nil
        homeTeamLabel.text = nil
        awayTeamLabel.text = nil
        resultLabel.text = nil
        dateLabel.text = nil
        homeFlagImageView.image = nil
        awayFlagImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeLabel.frame = CGRect(x: 10,
                                  y: 10,
                                  width: contentView.width - 20,
                                  height: 20)
        
        homeFlagImageView.frame = CGRect(x: contentView.width / 5 - contentView.width / 16,
                                         y: placeLabel.bottom + 5,
                                         width: contentView.width / 8,
                                         height: contentView.width / 8)
        homeFlagImageView.roundedImage()
        
        awayFlagImageView.frame = CGRect(x: contentView.width - contentView.width / 5 - contentView.width / 16,
                                         y: placeLabel.bottom + 5,
                                         width: contentView.width / 8,
                                         height: contentView.width / 8)
        awayFlagImageView.roundedImage()
        
        resultLabel.frame = CGRect(x: homeFlagImageView.right,
                                   y: placeLabel.bottom + 5,
                                   width: contentView.width - 2 * (homeFlagImageView.frame.origin.x + homeFlagImageView.width),
                                   height: homeFlagImageView.height)
        
        homeTeamLabel.frame = CGRect(x: contentView.width / 5 - contentView.width / 16 - contentView.width / 16 - contentView.width / 32,
                                     y: homeFlagImageView.bottom + 5,
                                     width: contentView.width / 8 + contentView.width / 8 + contentView.width / 16,
                                     height: 50)
        
        awayTeamLabel.frame = CGRect(x: contentView.width - contentView.width / 5 - contentView.width / 16 - contentView.width / 16 - contentView.width / 32,
                                     y: awayFlagImageView.bottom + 5,
                                     width: contentView.width / 8 + contentView.width / 8 + contentView.width / 16,
                                     height: 50)
        
        dateLabel.frame = CGRect(x: homeTeamLabel.right,
                                 y: resultLabel.bottom + 5,
                                 width: contentView.width - 2 * (homeTeamLabel.frame.origin.x + homeTeamLabel.width),
                                 height: 20)
    }

    public func configure(with model: MatchBracket) {
        guard let homeTeam = model.homeTeam,
              let awayTeam = model.awayTeam,
              let stadium = model.stadium else {
            return
        }
        
        placeLabel.text = "\(stadium.name), \(stadium.city)"
        
        homeFlagImageView.image = UIImage(named: "\(homeTeam.logo)_circle")
        awayFlagImageView.image = UIImage(named: "\(awayTeam.logo)_circle")
        homeTeamLabel.text = model.home
        awayTeamLabel.text = model.away
        
        if model.matchStatus == "not_played" {
            if model.isPredicted == true {
                if let predictedHomeResult = model.predictedHomeResult,
                   let predictedAwayResult = model.predictedAwayResult {
                    resultLabel.text = "\(predictedHomeResult) - \(predictedAwayResult)"
                }
            }
            else {
                resultLabel.text = "Predict the score!"
                resultLabel.font = .systemFont(ofSize: 16, weight: .bold)
            }
            
            dateLabel.text = formatDateString(date: model.date)
            
        } else {
            if model.isPredicted == true {
                if let predictedHomeResult = model.predictedHomeResult,
                   let predictedAwayResult = model.predictedAwayResult,
                   let predictedResult = model.predictedResult {
                    dateLabel.text = "Your bet: \(predictedHomeResult)-\(predictedAwayResult)"
                    
                    if model.matchStatus == "played" {
                        if model.homeResult == predictedHomeResult && model.awayResult == predictedAwayResult {
                            dateLabel.textColor = .systemGreen
                        }
                        else if model.matchResult == predictedResult {
                            dateLabel.textColor = .systemYellow
                        }
                        else {
                            dateLabel.textColor = .systemRed
                        }
                    }
                    else {
                        dateLabel.textColor = .gray
                    }
                    
                }
            }
            else {
                dateLabel.text = formatDateString(date: model.date)
            }
            
            resultLabel.text = "\(model.homeResult) - \(model.awayResult)"
            resultLabel.font = .systemFont(ofSize: 30, weight: .bold)
        }
    }
    
    private func formatDateString(date: String) -> String {
        var safeDate = date.replacingOccurrences(of: "_", with: ".")
        safeDate = safeDate.replacingOccurrences(of: ".2021", with: "")
        return safeDate
    }
}
