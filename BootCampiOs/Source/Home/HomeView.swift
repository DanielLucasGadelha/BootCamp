//
//  HomeView.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 20/06/23.
//

import UIKit

class HomeView: UIView {
    
    let showCharacterList: () -> Void
    let showLocationList: () -> Void
    
    init(showCharacterList: @escaping () -> Void, showLocationList: @escaping () -> Void) {
        self.showCharacterList = showCharacterList
        self.showLocationList = showLocationList
        super.init(frame: .zero)
        addSubViews()
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "HomeTitle2")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "O universo de Rick and Morty é composto por uma série de criaturas  bizarras e ambientes inóspitos."
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var charactersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Personagens", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 26.0
        
        button.addTarget(self, action: #selector(didTapCharacterList), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resumeLabel: UILabel = {
        let label = UILabel()
        label.text = "Este app foi feito para que você possa conhecer tudo isso de uma maneira simples e divertida."
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationsButton:UIButton = {
        let button = UIButton()
        button.setTitle("Lugares", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 26.0
        button.addTarget(self, action: #selector(didTapLocationList), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24.0
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func addSubViews()  {
        ///Hierarquia de visualização
        addSubview(stackView )
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(resumeLabel)
        stackView.addArrangedSubview(charactersButton)
        stackView.addArrangedSubview(locationsButton)
    }
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            ///Constraints de stackView
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
            ///Altura dos botões
            charactersButton.heightAnchor.constraint(equalToConstant: 52.0),
            locationsButton.heightAnchor.constraint(equalToConstant: 52.0),
        ])
    }
    @objc
    func didTapCharacterList() {
        showCharacterList()
    }
    @objc
    func didTapLocationList() {
       showLocationList()
    }
}
