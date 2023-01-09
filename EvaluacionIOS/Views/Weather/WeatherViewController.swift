//
//  WeatherViewController.swift
//  EvaluacionIOS
//
//  Created by Wilder Lopez on 12/23/22.
//

import UIKit
import CoreLocation
import MapKit

class WeatherViewController: UIViewController {

    var userInfo : UserInfo?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var titleWelcome: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblotherInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initInfo()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let location = locationManager.location else { return }
        self.callService(coordinate: location.coordinate)
    }
    
    
    private func initInfo() {
        
        guard let name = HelperApp.shared.getName(),
              let firstLastname = HelperApp.shared.getFirstLastname(),
              let secondLastname = HelperApp.shared.getSecondLastname(),
              let gender = HelperApp.shared.getGender()
        else { return }
        
        userInfo = UserInfo(name: name, firstLastname: firstLastname, secondLastname: secondLastname, gender: gender)
        
        guard let userInfo = userInfo else { return }
        titleWelcome.text = "Bienvenido \(userInfo.name)"
        title = "This Week"
        
    }
    
    func callService(coordinate: CLLocationCoordinate2D){
        WeatherNetworkLayer.shared.getWeather(coordinate: coordinate) { [unowned self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    
                self.lblLocation.text = weather.name
                    if let temp = weather.main?.temp {
                        self.lblTemp.text = "\(temp)"
                    }
                    if let description = weather.weather?.first?.description {
                        self.lblotherInfo.text = "\(description)"
                    }
                }
                break
            case .failure(let error):
                debugPrint("error de servicio: \(error)")
            }
        }
    }
    
}


//MARK: CoreLocation
extension WeatherViewController : CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            mapView.setRegion(region, animated: true)
        }
    }
}
