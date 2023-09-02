//
//  HeaderCreators.swift
//  CookingBook
//
//  Created by sidzhe on 01.09.2023.
//

import UIKit
import SnapKit

final class HeaderCreators: UICollectionReusableView {
    
    //MARK: - UI Elements
    
    var recentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var recentButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all ->", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.addTarget(self, action: #selector(tapTrendButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        return view
    }()
    
    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(recentLabel)
        stackView.addArrangedSubview(recentButton)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview()
        }
    }
    
    @objc private func tapTrendButton() {
        
    }
}
