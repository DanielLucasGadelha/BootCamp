//
//  LocationListView.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 22/06/23.
//

import UIKit

class LocationListView: UIView {
    
    let getAllLocation: () -> Void
    let didTapRow: (Location) -> Void
    let closeLocationList: () -> Void
//    let btn = UIBarButtonItem(customView: closeButton)

    
    var location: [Location] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    init(didTapRow: @escaping (Location) -> Void, getAllLocation: @escaping () -> Void, closeLocationList: @escaping () -> Void) {
        self.getAllLocation = getAllLocation
        self.didTapRow = didTapRow
        self.closeLocationList = closeLocationList
        super.init(frame: .zero)
        addSubviews()
        configureContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
     
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(LocationListCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    //MARK: - ERROR
    
    lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "There was an error"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24.0)
        
        return label
    }()
    
    lazy var retryButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Try Again", for: .normal)
        button.addTarget(self, action: #selector(didTapRetryButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var errorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 16.0
        
    
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()


   
    
    //MARK: - Loading
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - Func
    func addSubviews() {
//        addSubview(closeButton)
        addSubview(tableView)
        addSubview(errorStackView)
        addSubview(activityIndicator)
        
        errorStackView.addArrangedSubview(errorLabel)
        errorStackView.addArrangedSubview(retryButton)
    }
    func configureContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            errorStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            retryButton.heightAnchor.constraint(equalToConstant: 52.0),
            retryButton.widthAnchor.constraint(equalToConstant: 200.0),
            
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    @objc
    func didTapRetryButton() {
        getAllLocation()
    }
    @objc
    func close() -> Void {
        
    }
}


extension LocationListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LocationListCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = location[indexPath.row].name
        cell.typeLabel.text = location[indexPath.row].type
        
        return cell
    }
}

extension LocationListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedLocations = location[indexPath.row]
        didTapRow(selectedLocations)
    }
    
}
