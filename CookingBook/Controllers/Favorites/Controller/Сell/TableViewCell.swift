//
//  TableViewCell.swift
//  CookingBook
//
//  Created by Miras Maratov on 07.09.2023.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
// MARK: - properties
    private let cellView: UIView = {
        let element = UIView()
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let imgView: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 16
        element.backgroundColor = .systemMint
        element.image = UIImage(named: "SC")
        element.contentMode = .scaleToFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let ratingStack: UIView = {
        let element =  UIView()
        element.layer.cornerRadius = 8
        element.backgroundColor = .lightGray
        element.alpha = 1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let ratingStar: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "star.fill")
        element.tintColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let ratingLabel: UILabel = {
        let element = UILabel()
        element.text = "5,0"
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let saveButton: UIButton = {
        let element = UIButton()
        element.layer.cornerRadius = 16
        element.backgroundColor = .white
        element.setImage(UIImage(named: "bookmark.selected"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameLabel: UILabel = {
        let element = UILabel()
        element.text = "How to make shawarma at home?"
        element.tintColor = .black
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let moreButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = .clear
        element.setImage(UIImage(named: "more"), for: .normal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let nameStack: UIStackView = {
        let element = UIStackView()
        element.backgroundColor = .clear
        element.axis = .horizontal
        element.spacing = 2
        element.alignment = .center
        element.distribution = .fillEqually
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let authorStack: UIStackView = {
        let element = UIStackView()
        element.backgroundColor = .clear
        element.axis = .horizontal
        element.spacing = 2
        element.alignment = .center
        element.distribution = .fillEqually
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let avatar: UIImageView = {
        let element = UIImageView()
        element.layer.cornerRadius = 16
        element.image = UIImage(systemName: "person.circle.fill")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let authorName: UILabel = {
        let element = UILabel()
        element.text = "By Vinsmoke Sanji"
        element.textColor = .darkGray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

// MARK: - flow funcs
    func setUpCell() {
        addViews()
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            imgView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 0),
            imgView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0),
            imgView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0),
            imgView.heightAnchor.constraint(equalToConstant: 200),
            imgView.bottomAnchor.constraint(equalTo: nameStack.topAnchor, constant: -5),
            
            nameStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0),
            nameStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0),
            nameStack.bottomAnchor.constraint(equalTo: authorStack.topAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: nameStack.leadingAnchor, constant: 5),
            moreButton.trailingAnchor.constraint(equalTo: nameStack.trailingAnchor, constant: 0),
            
            authorStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0),
            authorStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0),
            authorStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -2),
            avatar.leadingAnchor.constraint(equalTo: authorStack.leadingAnchor, constant: 2),
            avatar.centerYAnchor.constraint(equalTo: authorStack.centerYAnchor),
            authorName.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 5),
            authorName.centerYAnchor.constraint(equalTo: authorStack.centerYAnchor),
            
            ratingStack.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 8),
            ratingStack.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: 8),
            ratingStack.heightAnchor.constraint(equalToConstant: 27.6),
            ratingStack.widthAnchor.constraint(equalToConstant: 58),
            ratingStar.leadingAnchor.constraint(equalTo: ratingStack.leadingAnchor,constant: 5),
            ratingStar.centerYAnchor.constraint(equalTo: ratingStack.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingStack.trailingAnchor,constant: -5),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingStack.centerYAnchor),
            
            saveButton.topAnchor.constraint(equalTo: imgView.topAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: -8),
            saveButton.widthAnchor.constraint(equalToConstant: 32),
            saveButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func addViews(){
        addSubview(cellView)
        cellView.addSubview(imgView)
        cellView.addSubview(nameStack)
        cellView.addSubview(authorStack)
        
        imgView.addSubview(ratingStack)
        imgView.addSubview(saveButton)
        
        ratingStack.addSubview(ratingStar)
        ratingStack.addSubview(ratingLabel)
        
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addSubview(moreButton)
        
        authorStack.addSubview(avatar)
        authorStack.addSubview(authorName)
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.translatesAutoresizingMaskIntoConstraints = false
//        blurView.frame = ratingStack.bounds
//        ratingStack.addSubview(blurView)
    }
}
