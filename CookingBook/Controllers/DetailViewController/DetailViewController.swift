//
//  DetailViewController.swift
//  CookingBook
//
//  Created by sidzhe on 11.09.2023.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private let identifier = "detailCell"
    private let identifierHeader = "HederCell"
    private let model: Results
    private var cellModel = [Ent]()
    private let networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.allowsSelection = false
        view.dataSource = self
        view.delegate = self
        view.register(DetailViewCell.self, forCellReuseIdentifier: identifier)
        view.register(HeaderCell.self, forCellReuseIdentifier: identifierHeader)
        return view
    }()
    
    //MARK: - Inits
    
    init(model: Results) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        createIngrigients()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func createIngrigients() {
        
        guard let model = model.analyzedInstructions?.first?.steps else { return }
        for item in model { item.ingredients?.forEach { ingridient in
        
            if cellModel.isEmpty {
                cellModel.append(ingridient)
            } else {
                if !cellModel.contains(ingridient) {
                    cellModel.append(ingridient)
                }
            }
        }}
        
    }
}


//MARK: - Extension UITableViewDataSource, UITableViewDelegate

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifierHeader) as? HeaderCell
            cell?.configure(model: model, itemLabel: cellModel.count)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? DetailViewCell
            cell?.configure(model: cellModel[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row != 0 {
            return 70
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
}


