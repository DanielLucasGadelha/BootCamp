//
//  LocationListCell.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 13/04/23.
//

import UIKit

final class LocationListCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        return label
    }()
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        return label
    }()
    
    ///StackView relacionado as labels da célula.
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    ///Iniciador da célula.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubView()
        addConstraint()
        accessoryType = .disclosureIndicator
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
    }
    
    func setup(name: String, type: String) {
        nameLabel.text = name
        typeLabel.text = type
    }
    func addConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.0),
        ])
    }
}
