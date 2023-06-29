//
//  MainCoordinator.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 23/06/23.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    ///Representa o início do Coordinator
    func start() {
        let controller = HomeViewController()
        controller.coordinator = self
        ///Recebe uma lista de controller dependendo da dash e do menu inicial ou não do projeto.
        navigationController?.setViewControllers([controller], animated: true)
    }
    
    func eventOccurred(with type: Event) {
        switch type {
            
        case .showHome: start()
        case .showCharacterList: showCharacterList()
        case .showLocationList:showLocationList()
        case .showCharacterDetail:
                break
            
        case .showLocationDetail:
            break
        }
    }
    
    
    
}
extension MainCoordinator {
    private func showCharacterList() {
        
        let controller: CharacterListController & CoordinatedViewController = CharacterListController()
        controller.coordinator = self
        controller.navigationItem.title = "Personagens"
        navigationController?.pushViewController(controller, animated: false)
    }
    
    private func showLocationList() {
        let controller: LocationListController & CoordinatedViewController = LocationListController()
        controller.coordinator = self
        controller.navigationItem.title = "Lugares"
        navigationController?.pushViewController(controller, animated: true)
        
    }
    private func showCharacterDetail() {
      //Manipulação dos dados, a outra CC precisa
        let controller = CharacterDetailsController(character: Characters)
        controller.coordinator = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
