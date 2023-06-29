//
//  ViewController.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 09/04/23.
//

import UIKit

class HomeViewController: UIViewController, CoordinatedViewController {
    
    var coordinator: Coordinator?
    
    private lazy var rootView: HomeView = HomeView(showCharacterList: showCharacterList, showLocationList: showLocationList)
    
    
    //MARK: - Life cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = .white
        
        
    }
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    func showCharacterList() {
        coordinator?.eventOccurred(with: .showCharacterList)
    }
    
    func showLocationList() {
        coordinator?.eventOccurred(with: .showLocationList)
      
    }
    
}
