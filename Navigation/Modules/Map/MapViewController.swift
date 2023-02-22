//
//  MapViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 22.02.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
        
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        
        
        ])
    }

}
