//
//  TableViewCell.swift
//  CookingBook
//
//  Created by Miras Maratov on 07.09.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    private let cellView: UIView = {
        let element = UIView()
        element.backgroundColor = .systemCyan
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(cellView)
//        NSLayoutConstraint.activate([
//            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
//            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        addSubview(cellView)
//        NSLayoutConstraint.activate([
//            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
//            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
//        ])
//    }
    
    func setUpCell() {
        let label = UILabel()
        label.text = "smdkvn"
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellView)
        cellView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
