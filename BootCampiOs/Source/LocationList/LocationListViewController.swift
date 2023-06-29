//
//  LocationListController.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 13/04/23.
//

import UIKit

final class LocationListController: UIViewController, CoordinatedViewController{
    var coordinator: Coordinator?
    
    
    enum State {
        case main
        case loading
        case error
    }
    
    var state: State = .loading {
        didSet {
            updateState(state)
        }
    }
    
    //MARK: - Variável de propriedade
    lazy var rootView: LocationListView = LocationListView(
        didTapRow: { [weak self] location in
            self?.didtTapLocation(location: location)
        },
        getAllLocation: { [weak self] in
            self?.getAllLocations()
        }, closeLocationList: { [weak self] in
            self?.closeLocationList()
            
        }
    )
    
    // MARK: - BTN
    lazy var closeButton: UIBarButtonItem = {
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeLocationList))
        
        return closeButton
    }()
    
    //MARK: - Life Cycle
    
    override func loadView() {
        view = rootView
        navigationItem.setLeftBarButton(closeButton, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Lugares"
        getAllLocations()
      
    }
    ///Função de chamada de request
    @objc
    func getAllLocations() {
        //https://rickandmortyapi.com/api/location
        ///Construção da URL sem QueryItem.
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/location"
        
        ///Safe Unwrap of the URL components
        guard let url = components.url else {
            print("[Error] - Invalid URL from components: \(components)")
            state = .error
            
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        state = .loading
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                self?.state = .error
                print("[Error] - A requisição retornou um erro: \(error.localizedDescription)")
                
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)  else {
                print("[Error]- A requisição retornou um status code diferente de 2xx")
                self?.state = .error
                return
            }
            
            guard let data = data else {
                print("[Error] - A requisição retornou um erro de dados.)")
                self?.state = .error
                return
            }
            
            do {
                ///Safe unwrap of JSON data
                let locationResponse = try JSONDecoder().decode(LocationResponses.self, from: data)
                DispatchQueue.main.async {
                    self?.rootView.location = locationResponse.results
                    self?.state = .main
                    self?.rootView.tableView.reloadData()
                }
                
                
            } catch let error {
                
                print("[Error] - O objeto não pode ser iniciado corretamente: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    func updateState(_ state: State) {
        DispatchQueue.main.async { [weak self] in
            switch state {
                
            case .main:
                print("[Log] - main state")
                self?.rootView.tableView.isHidden = false
                self?.rootView.activityIndicator.isHidden = true
                self?.rootView.errorStackView.isHidden = true
                
            case .error:
                print("[Log] - error state")
                self?.rootView.tableView.isHidden = true
                self?.rootView.activityIndicator.isHidden = true
                self?.rootView.errorStackView.isHidden = false
                
            case .loading:
                self?.rootView.tableView.isHidden = true
                self?.rootView.activityIndicator.isHidden = false
                self?.rootView.errorStackView.isHidden = true
                print("[Log] - loading state")
            }
            
        }
    }
    
    @objc func closeLocationList () {
        navigationController?.popViewController(animated: true)
    }
    
    private func didtTapLocation(location: Location) {
        let locationDetailController = LocationDetailController(location: location)
        navigationController?.pushViewController(locationDetailController, animated: true)
    }
}
