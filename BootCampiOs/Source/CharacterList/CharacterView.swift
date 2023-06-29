//
//  CharacterListView.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 21/06/23.
//

import UIKit

class CharacterListView: UIView {
    
    var didTapRow: (Characters) -> Void
    var characters: [Characters] = [] {
        ///Trigga assim que a propriedade é populada.
        didSet {
            tableView.reloadData()
        }
    }

    init(didTapRow: @escaping (Characters) -> Void) {
        self.didTapRow = didTapRow
        super.init(frame: .zero)
        addSubviews()
        configureContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CharacterListCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    ///Label error
    lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "There was an error"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
        
    }()
    
    //MARK: - PRIVATE METHODS
    func addSubviews() {
        addSubview(tableView)
        addSubview(errorLabel)
        addSubview(activityIndicator)
    }
    
    func configureContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: topAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
    
extension CharacterListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///Casting para poder realizar a conversão de célula.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterListCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = characters[indexPath.row].name
        cell.speciesLabel.text = characters[indexPath.row].species
        return cell
    }
}

extension CharacterListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterSelected = characters[indexPath.row]
        didTapRow(characterSelected)
    }
    
}
