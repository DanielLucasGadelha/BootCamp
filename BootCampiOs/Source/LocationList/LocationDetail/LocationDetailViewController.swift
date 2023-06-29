//
//  LocationDetailController.swift
//  BootCamp
//
//  Created by Daniel Gadelha on 12/05/23.
//

import UIKit

final class LocationDetailController: UIViewController {
    
    
    lazy var rootView: LocationDetailView = LocationDetailView(location: location)
    
    private let location: Location
    
    init(location: Location ){
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
    }
    
}
