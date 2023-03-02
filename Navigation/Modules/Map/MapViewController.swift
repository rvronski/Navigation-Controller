//
//  MapViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 22.02.2023.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private var lon = 0.0
    private var lat = 0.0
    private var locations = [AnyLocations]()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isUserInteractionEnabled = true
        return mapView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearPins), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location()
        checkAuthorization()
        setupView()
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(foundTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(mapView)
        self.view.addSubview(clearButton)
        
        NSLayoutConstraint.activate([
        
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.clearButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.clearButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.clearButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            self.clearButton.heightAnchor.constraint(equalTo: self.clearButton.widthAnchor),
        ])
    }

    private func setupMap() {
        mapView.mapType = .standard

        let center = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        addPin()
    }
    
    private func addPin() {
        
        let bar: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat + 0.01, longitude: self.lon), name: "Bar")
        let market: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat - 0.002, longitude: self.lon - 0.04), name: "Market")
        let job: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat - 0.012, longitude: self.lon - 0.023), name: "Job")
        let home: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat + 0.0145, longitude: self.lon + 0.0034), name: "Home")
        let myLocation: AnyLocations = AnyLocations(coordinate: CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon), name: "My location")
        self.locations.append(bar)
        self.locations.append(market)
        self.locations.append(job)
        self.locations.append(home)
        self.locations.append(myLocation)
        mapView.addAnnotations(locations)
    }
    
    private func checkAuthorization() {
        switch locationManager.authorizationStatus {
            
       case .notDetermined:
           break
       case .restricted:
           break
       case .denied:
           locationAlert()
       case .authorizedAlways:
           break
       case .authorizedWhenInUse:
            location()
            self.mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError()
        }
    }
    
    private func location() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
    }
    
   
    
    private func locationAlert() {
        let alert = UIAlertController(title: "У вас выключена геолокация", message: "Хотите включить", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelActtion = UIAlertAction(title: "Отмена", style: .default)
        
        alert.addAction(cancelActtion)
        alert.addAction(settingsAction)
        present(alert, animated: true)
    }
    
    @objc private func clearPins() {
        if mapView.overlays.isEmpty {
            self.mapView.removeAnnotations(locations)
        } else {
            self.mapView.removeOverlay(mapView.overlays[0])
            self.mapView.removeAnnotations(locations)
        }
    }
    
    private func createAnyLocation(coordinate: CLLocationCoordinate2D) {
        let alertController = UIAlertController(title: "Введите имя локации", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Имя"
        }
        
        let saveAction = UIAlertAction(title: "Ввести", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            guard let name = firstTextField.text else {return}
            let newLocation = AnyLocations(coordinate: coordinate, name: name)
            self.locations.append(newLocation)
            self.mapView.addAnnotation(newLocation)
            
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil )
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
   @objc func foundTap(recognizer: UILongPressGestureRecognizer) {
        let point: CGPoint = recognizer.location(in: mapView)
        let tapPoint: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: mapView)
       createAnyLocation(coordinate: tapPoint)
    }
    
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = manager.location?.coordinate.latitude ?? 0
        let lon = manager.location?.coordinate.longitude ?? 0
        manager.stopUpdatingLocation()
        self.mapView.showsUserLocation = true
        self.lat = lat
        self.lon = lon
        self.setupMap()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("Can't get location")
         
    }
   
}
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = .blue
        renderer.lineWidth = 2.0
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AnyLocations else { return nil }
        var viewMarker: MKMarkerAnnotationView
        let idView = "Marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 3.0)
            viewMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return viewMarker
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let coordinate = locationManager.location?.coordinate else {return}
       
        let location = view.annotation as! AnyLocations
        let startPoint = MKPlacemark(coordinate: coordinate)
        let endPoint = MKPlacemark(coordinate: location.coordinate)
        
        let request = MKDirections.Request()
       
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: endPoint)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response else {
               return
            }
            let route = response.routes[0]
            if mapView.overlays.isEmpty {
                self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
            } else {
                self?.mapView.removeOverlay(mapView.overlays[0])
                self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
            }
            
        }
    }
    
}
