//
//  FavoritesViewController.swift
//  CookingBook
//
//  Created by Sergey on 28.08.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
// MARK: - ui constants
    private let labelView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemCyan
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let mainLabel: UILabel = {
        let element = UILabel()
        element.text = "Saved recipes"
        element.font = UIFont(name: "Poppins-SemiBold", size: 24)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let recipeTable: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .systemGreen
        return element
    }()
    
// MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
        setConstraints()
    }
    
// MARK: - flow funcs
    private func setUpView() {
        view.addSubview(labelView)
        labelView.addSubview(mainLabel)
        view.addSubview(recipeTable)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            labelView.heightAnchor.constraint(equalToConstant: 69),
            
            mainLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
            mainLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 16),
            mainLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -16),
            mainLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -20),
            
            recipeTable.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 0),
            recipeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            recipeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recipeTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
