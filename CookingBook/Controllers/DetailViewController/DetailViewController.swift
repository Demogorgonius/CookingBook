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
    
    private var stackViewSize: CGSize?
    private var mainImageSize: CGSize?
    private let identifier = "detailCell"
    private let model: Results
    private var cellModel = [Ent]()
    private let networkManager = NetworkManager()
    
    //MARK: - UI Elements
    
    private lazy var contentView = UIView()
    private lazy var headerView = UIView()
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = "How to make Tasty Fish (point & Kill)"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSize(size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.text = "777 K"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var instructionHeader: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ingredientsHeader: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var itemsLabel: UILabel = {
        let label = UILabel()
        label.text = "5 items"
        label.font = UIFont.regular14()
        label.textColor = .systemGray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var instructionList: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont.regular16()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "onboardingImagePage1")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart.fill")
        image.tintColor = .primary50
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.spacing = 10
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.allowsSelection = false
        view.dataSource = self
        view.delegate = self
        view.register(DetailViewCell.self, forCellReuseIdentifier: identifier)
        view.headerView(forSection: 0)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        stackViewSize = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        mainImageSize = mainImage.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()
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
    
    private func setupHeader() {
        
        headerView.addSubview(contentView)
        
        stackView.addArrangedSubview(instructionHeader)
        stackView.addArrangedSubview(instructionList)
        
        contentView.addSubview(header)
        contentView.addSubview(mainImage)
        contentView.addSubview(ratingImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(ingredientsHeader)
        contentView.addSubview(itemsLabel)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).inset(-10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(view.bounds.height / 4)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
            
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).inset(-16)
            make.left.equalTo(ratingImage.snp.right).inset(-4)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(ratingImage.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        ingredientsHeader.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(stackView.snp.bottom).inset(-16)
        }
        
        itemsLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(stackView.snp.bottom).inset(-16)
        }
    }
    
    private func createIngrigients() {
        
        var ingridients = 0
        var steps = ""
        
        guard let model = model.analyzedInstructions?.first?.steps else { return }
        
        itemsLabel.text = model.count.description
        
        for item in model {
            
            ingridients += item.ingredients?.count ?? 0
            steps += "\(item.number?.description ?? "0"). \(item.step ?? "non") \n"
            
            item.ingredients?.forEach { ingridient in
                cellModel.append(ingridient)
            }
        }
        
        itemsLabel.text = ingridients.description
        instructionList.text = steps
        header.text = self.model.title
        ratingLabel.text = self.model.aggregateLikes?.description
        
        networkManager.loadImage(from: self.model.image) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.mainImage.image = image }
        }
    }
}


//MARK: - Extension UITableViewDataSource

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? DetailViewCell
        cell?.configure(model: cellModel[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let height1 = stackViewSize?.height ?? 0
        let height2 = mainImageSize?.height ?? 0
        return (view.frame.height)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


