//
//  ForecastAPI.swift
//  Enums
//

import Foundation

class FAAServicesAPI {
    
    class func getAirportStatusForAirports(airportCodes: [String], completionHandler: (status: NSDictionary?) -> Void) {
        
        let airportDict: NSMutableDictionary = [:]
        
        let group = dispatch_group_create()
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        for airportCode in airportCodes {
            dispatch_group_enter(group)
            dispatch_async(queue, { 
                getStatusForAirport(airportCode, completionHandler: { status in
                    if let aStatus = status {
                        airportDict[aStatus.airportCode] = aStatus
                    }
                    dispatch_group_leave(group)
                })
            })
        }
        
        dispatch_group_notify(group, queue) {
            if airportDict.count == airportCodes.count {
                completionHandler(status: airportDict)
            } else {
                completionHandler(status: nil)
            }
        }
    }
    
    class func getStatusForAirport(airportCode: String, completionHandler: (status: AirportStatus?) -> Void) {
        
        let statusEndpoint = "http://services.faa.gov/airport/status/" + airportCode + "?format=application/json"
        
        guard let url = NSURL(string: statusEndpoint) else {
            print("Error: cannot create URL")
            completionHandler(status: nil)
            return
        }
        
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            
            if data == nil {
                completionHandler(status: nil)
                return
            }
            
            do {
                if let status = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject] {
                    
                    let airportStatus = AirportStatus(status: status)
                    if airportStatus.complete {
                        completionHandler(status: airportStatus)
                    } else {
                        print("Error: data received is not valid")
                        completionHandler(status: nil)
                    }
                    
                }
                
            } catch {
                print("Error: cannot get JSON data")
                completionHandler(status: nil)
                
            }
        }.resume()
        
    }
    
}

