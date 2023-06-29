//
//    Coordinator.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 23/06/23.
//

import UIKit

enum Event  {
    case showHome
    case showCharacterList
    case showLocationList
    case showCharacterDetail
    case showLocationDetail
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func eventOccurred(with type: Event)
    func start()
    
}
///Criar a VC do mesmo tipo desse protocolo
protocol CoordinatedViewController {
    var coordinator: Coordinator? { get set }
}
