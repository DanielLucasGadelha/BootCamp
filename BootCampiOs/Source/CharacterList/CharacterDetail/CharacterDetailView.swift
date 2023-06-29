//
//  CharacterDetailView.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 21/06/23.
//

import UIKit

class CharacterDetailView: UIView {
    
    let character: Characters
    
    init(character: Characters) {
        self.character = character
        super.init(frame: .zero)
        downloadImage()
        addSubview()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
        
    }()
    
    lazy var characterLabel: UILabel = {
        let label = UILabel()
        label.text = character.name
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    lazy var speciesRow: UIView = makeAtributeRow(
        title: "Raça",
        content: "\(character.species)"
    )
    lazy var statusRow: UIView = makeAtributeRow(
        title: "Status",
        content: "\(character.status)"
    )
    lazy var originRow: UIView = makeAtributeRow(
        title: "Origin",
        content: character.origin.name
    )
    
    
    func downloadImage() {
        let placeHolderImage = UIImage(named: "LaunchScreen")
        characterImageView.image = placeHolderImage
        ///Verificação da URL
        guard
            let imageUrlString = character.image,
            let imageURL = URL(string: imageUrlString)
        else { return }
        ///Dowload da imagem
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageURL),
               let characterImage = UIImage(data: imageData) {
                ///Atribuindo a imagem a thread principal para melhor feedback do usuário.
                DispatchQueue.main.async {
                    self.characterImageView.image = characterImage
                }
            }
        }
    }
    
    
    func configureConstraints() {
        
        NSLayoutConstraint.activate([
            
            characterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 12.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0),
        ])
    }
    
    func addSubview() {
        addSubview(characterImageView)
        addSubview(stackView)
        stackView.addArrangedSubview(characterLabel)
        stackView.addArrangedSubview(speciesRow)
        stackView.addArrangedSubview(statusRow)
        stackView.addArrangedSubview(originRow)
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

    
}
