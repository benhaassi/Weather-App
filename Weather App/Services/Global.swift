//
//  Global.swift
//  Weather App
//
//  Created by Simo on 3/31/20.
//  Copyright © 2020 A. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Dark Sky Api
class Config{
    static let baseLink = "https://api.darksky.net/forecast/"
    static let ApiKey = "09e8e244326837f3038ae2e78dcb88f1"
    static let GOOGLE_API_KEY = "AIzaSyB6gnpbKmaonbhC9bv4RFW56nZ3hrzzSHY"
}

// MARK: viewControllers identifiers
enum VCIdendifier {
    static let idVCDetail = "detailVC"
    static let idVCHourly = "hourlyVC"
    static let idVCDaily = "dailyVC"
}


typealias success = (Weather) -> ()
typealias error = (Error) -> ()


// MARK: get weather from API
func getWeather(lati : Double, long : Double, success :  @escaping success, error : @escaping error){
   
    let forecastUrl = "\(Config.baseLink)\(Config.ApiKey)/\(lati),\(long)?lang=en"
    AF.request(forecastUrl).responseJSON { (response) in
        let result = response.result
        switch result {
        case .success(let data):
            if  let jsonData = try? JSONSerialization.data(withJSONObject:data){
                do {
                let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                        ///TODO :
                        success(weather)
                    
                }catch let eror {
                    print("errooor \(eror)")
                }
                
            }
        case .failure( let err):
            print("failure \(err)")
            error(err)
        }
    }
    
}




