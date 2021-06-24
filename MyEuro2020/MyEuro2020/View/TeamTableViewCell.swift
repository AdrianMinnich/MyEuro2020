//
//  TeamTableViewCell.swift
//  MyEuro2020
//
//  Created by Adrian Minnich on 19/06/2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    static let identifier = "TeamTableViewCell"
    
    var thirdPlacePosition: Int?
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private let matchesPlayedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let goalDiffLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(positionLabel)
        contentView.addSubview(flagImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(matchesPlayedLabel)
        contentView.addSubview(goalDiffLabel)
        contentView.addSubview(pointsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        positionLabel.text = nil
        flagImageView.image = nil
        nameLabel.text = nil
        matchesPlayedLabel.text = nil
        goalDiffLabel.text = nil
        pointsLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        positionLabel.frame = CGRect(x: 5,
                                     y: 5,
                                     width: 15,
                                     height: 50)
        
        flagImageView.frame = CGRect(x: positionLabel.right + 10,
                                     y: 15,
                                     width: 30,
                                     height: 30)
        flagImageView.roundedImage()
        
        pointsLabel.frame = CGRect(x: contentView.width - 25,
                                   y: 5,
                                   width: 20,
                                   height: 50)
        
        goalDiffLabel.frame = CGRect(x: pointsLabel.frame.origin.x - 45,
                                     y: 5,
                                     width: 40,
                                     height: 50)
        
        matchesPlayedLabel.frame = CGRect(x: goalDiffLabel.frame.origin.x - 30,
                                          y: 5,
                                          width: 20,
                                          height: 50)
        
        let nameWidth = contentView.width - positionLabel.width - flagImageView.width - pointsLabel.width - goalDiffLabel.width - matchesPlayedLabel.width - 45
        
        nameLabel.frame = CGRect(x: flagImageView.right + 10,
                                 y: 0,
                                 width: nameWidth,
                                 height: 60)
    }
    
    public func configure(with model: Team) {
        
        positionLabel.text = "\(model.position)"
        flagImageView.image = UIImage(named: "\(model.logo)_circle")
        nameLabel.text = model.name
        matchesPlayedLabel.text = "\(model.matchesPlayed)"
        if model.goalDiff > 0 {
            goalDiffLabel.text = "+\(model.goalDiff)"
        } else {
            goalDiffLabel.text = "\(model.goalDiff)"
        }
        pointsLabel.text = "\(model.points)"
    }
}
