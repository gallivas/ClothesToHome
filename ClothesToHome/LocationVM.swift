//
//  LocationVM.swift
//  ClothesToHome
//
//  Created by Stephen Gallivan on 6/11/25.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

func getCoordinate( addressString : String,
        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
        if error == nil {
            if let placemark = placemarks?[0] {
                let location = placemark.location!
                print(location.coordinate.latitude)
                completionHandler(location.coordinate, nil)
                return
            }
        }
            
        completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
    }
}




//func downloadData(completionHandler: (_ data: String) -> Void) {
//    completionHandler("New data!")
//}
//
//func getData() {
//    downloadData { returnedData in
//        print(returnedData)
//    }
//}
