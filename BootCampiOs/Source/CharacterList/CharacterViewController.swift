//
//  CharacterListController.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 10/04/23.
//

import UIKit

class CharacterListController: UIViewController, CoordinatedViewController {
    var coordinator: Coordinator?
    
    
    enum State {
        case main
        case error
        case loading
    }
    ///Pegando o estado da view.
    var state: State = .loading {
        didSet {
            updateState(state)
        }
    }
    
    lazy var rootView = CharacterListView(didTapRow: { [weak self] character in
            self?.didTapCharacter(character: character)
        }
    )
    
    ///TableView object.
    ///Close Button object.
    public lazy var close: UIBarButtonItem = {
        let closeButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self ,
            action: #selector(closeCharacterListController))
        return closeButton
    }()
    
    override func loadView() {
        view = rootView
    }
    
    //MARK: - Life Cycle
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setLeftBarButton(close, animated: true)
        title = "Personagens"
        getAllCharacters()
    }
    //MARK: - FUNC
    ///Button Selector.
    @objc func closeCharacterListController () {
        navigationController?.popViewController(animated: true)
    }
    ///Função para chamar a request
    func getAllCharacters() {
        //https://rickandmortyapi.com/api/character
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/character"
        
        ///Safe Unwrap of the URL optional.
        guard let urlComponents = components.url else {
            state = .error
            print("[Error] - Invalid URL from components: \(components)")
            
            return }
        var request = URLRequest(url: urlComponents)
        request.httpMethod = "GET"
        state = .loading
        
        ///O Weak self vem dentro de uma closure que precisa acessar o método self.
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error  in
            ///Interrompe o fluxo apenas se o erro existir
            if let error = error {
                self?.state = .error
                print("[Error] - A requisição retornou um erro: \(error.localizedDescription)")
                return
            }
            /// Usa o unwrap para verificar o statusCode da resposta da http. Num valor boleano.
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                self?.state = .error
                print("[Error]- A requisição retornou um status code diferente de 2xx")
                return
            }
            guard let data = data else {
                self?.state = .error
                print("[Error] - A requisição retornou um erro de dados.)")
                return }
            
            ///Conversão do JSON em objeto SWIFT
            do {
                
                ///Safe Unwrap of the JSON data.
                let characterResponse = try JSONDecoder().decode(CharacterResponses.self, from: data)
                DispatchQueue.main.async {
                    self?.rootView.characters = characterResponse.results
                    self?.state = .main
                    self?.rootView.tableView.reloadData()
                }
            } catch let error {
                self?.state = .error
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
                self?.rootView.errorLabel.isHidden = true
                
            case .error:
                print("[Log] - error state")
                self?.rootView.tableView.isHidden = true
                self?.rootView.activityIndicator.isHidden = true
                self?.rootView.errorLabel.isHidden = false
                
            case .loading:
                self?.rootView.tableView.isHidden = true
                self?.rootView.activityIndicator.isHidden = false
                self?.rootView.errorLabel.isHidden = true
                print("[Log] - loading state")
            }
            
        }
    }
    
   
    
    private func didTapCharacter(character: Characters) {
        coordinator?.eventOccurred(with: .showCharacterDetail)
    }
    
    
}

