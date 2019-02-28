//
//  SplashViewController.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/1/30.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit
import CoreLocation

class SplashViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager();
    var locationString: String = "";
    var locationFail = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization();
        locationManager.requestWhenInUseAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation();
        if let location = locations.first {
            let geoCoder = CLGeocoder();
            geoCoder.reverseGeocodeLocation(location, completionHandler: {
                placemarks, error in
                if error == nil && (placemarks?.count)! > 0 {
                    if (self.locationString.isEmpty) {
                        let placeMark = (placemarks?.last)! as CLPlacemark;
                        if let country = placeMark.country {
                            self.locationString.append(country + ",");
                        }
                        if let province = placeMark.administrativeArea {
                            self.locationString.append(province + ",");
                        }
                        if let city = placeMark.locality {
                            self.locationString.append(city + ",");
                        }
                        if let district = placeMark.subLocality {
                            self.locationString.append(district);
                        }
                        self.performSegue(withIdentifier: MainViewController.SEGUE, sender: nil);
                    }
                } else {
                    if (!self.locationFail) {
                        self.locationFail = true;
                        self.performSegue(withIdentifier: MainViewController.SEGUE, sender: nil);
                    }
                }
            });
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)");
        self.performSegue(withIdentifier: MainViewController.SEGUE, sender: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainViewController.SEGUE {
            if let mainView = segue.destination as? MainViewController {
                mainView.location = self.locationString;
            }
        }
    }
    

}
