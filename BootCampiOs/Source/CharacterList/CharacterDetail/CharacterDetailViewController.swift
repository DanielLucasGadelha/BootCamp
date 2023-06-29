//
//  CharacterDetailsController.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 22/05/23.
//

import UIKit

final class CharacterDetailsController: UIViewController, CoordinatedViewController {
    var coordinator: Coordinator?
    
    
    private let character: Characters
    
    lazy var rootView: CharacterDetailView = CharacterDetailView(character: character)
    
    ///Initializers
    init(character: Characters){
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
}

