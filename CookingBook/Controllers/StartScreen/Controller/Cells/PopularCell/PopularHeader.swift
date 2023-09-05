//
//  PopularHeader.swift
//  CookingBook
//
//  Created by sidzhe on 31.08.2023.
//

import UIKit
import SnapKit

final class PopularHeader: UICollectionReusableView {
    
    //MARK: - UI Elements
    
    var trendLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        return label
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
        
        stackView.addArrangedSubview(trendLabel)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
    }
}
