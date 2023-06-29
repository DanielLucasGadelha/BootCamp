//
//  LocationDetailView.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 21/06/23.
//

import UIKit

class LocationDetailView: UIView {
    
    private let location: Location
    
    init(location: Location){
        self.location = location
        super.init(frame: .zero)
        addSubviews()
        configureContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var locationLabel: UILabel = {
       
        let label = UILabel()
        label.text = location.name
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        
        
        return label
    }()
    
    lazy var idRow: UIView = makeAtributeRow(
        title: "Id",
        content: "\(location.id)"
    )
    lazy var typeRow: UIView = makeAtributeRow(
        title: "Content",
        content: location.type
    )
    lazy var dimensionRow: UIView = makeAtributeRow(
        title: "Dimension",
        content: location.dimension
    )
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
   
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(idRow)
        stackView.addArrangedSubview(typeRow)
        stackView.addArrangedSubview(dimensionRow)
    }
    func configureContraints() {
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
        ])
    }
}


private func makeAtributeRow(title: String, content: String) -> UIView {
    
    let stackView = UIStackView()
    stackView.axis = .vertical
    
    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = .systemFont(ofSize: 12.0)
    titleLabel.textColor = .lightGray
    
    
    let contentLabel = UILabel()
    contentLabel.font = .systemFont(ofSize: 15.0)
    contentLabel.textColor = .black
    contentLabel.numberOfLines = 0
    contentLabel.text = content
    
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(contentLabel)
    
    
    return stackView
}


