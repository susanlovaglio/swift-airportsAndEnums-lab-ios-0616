//
//  AirportStatus.swift
//  Enums
//

import Foundation

class AirportStatus {
    
    private(set) var airportCode: String
    private(set) var city: String
    private(set) var delay: String
    private(set) var name: String
    private(set) var state: String
    private(set) var avgDelay: String
    private(set) var type: String
    private(set) var reason: String
    private(set) var tempF: String
    private(set) var tempFNum: Int
    private(set) var visibility: String
    private(set) var weather: String
    private(set) var windSpeed: String
    private(set) var windDirection: String
    private(set) var complete = false
    
    init(status: [String: AnyObject]) {
        
        airportCode = status["IATA"] as? String ?? "NO AIRPORT CODE"
        city = status["city"] as? String ?? "NO CITY"
        delay = status["delay"] as? String ?? "NO DELAY STATUS"
        name = status["name"] as? String ?? "NO NAME"
        state = status["state"] as? String ?? "NO STATE"
        avgDelay = status["status"]!["avgDelay"] as? String ?? "NO AVG DELAY"
        type = status["status"]!["type"] as? String ?? "NO TYPE"
        reason = status["status"]!["reason"] as? String ?? "NO REASON"
        tempF = status["weather"]!["temp"] as? String ?? "NO TEMPERATURE"
        visibility = "\(status["weather"]!["visibility"] as? Int ?? 999)"
        weather = status["weather"]!["weather"] as? String ?? "NO WEATHER"
        windSpeed = status["weather"]!["wind"] as? String ?? "NO WIND SPEED"
        windDirection = "NO WIND DIRECTION"
        tempFNum = 999
        
        editReceivedStatus()
        complete = verifyStatusComplete()
    }
    
}

// MARK: Edit/Verify Status
extension AirportStatus {
    
    func editReceivedStatus() {
        
        if delay == "true" {
            delay = "Delays"
        } else {
            delay = "No delays"
        }
        
        if reason == "No known delays for this airport." {
            reason = ""
        }
        
        if tempF != "NO TEMPERATURE" {

            let tempFSplit = tempF.characters.split(".")
            tempFNum = Int(String(tempFSplit.first!))!
            tempF = "\(tempFNum)" + "° F"
            
        }
        
        if visibility != "999" {
           visibility = "Visbility: " + "\(visibility)" + "mi."
        }
        
        if windSpeed != "NO WIND SPEED" {
            let windArray = windSpeed.componentsSeparatedByString(" ")
            if let windVelocity = windArray.last {
                let windVelocityArray = windVelocity.characters.split(".")
                windSpeed = String(windVelocityArray.first!) + "mph"
            }
            if let windAngle = windArray.first {
                windDirection = windAngle
            }
        }
    }

    func verifyStatusComplete() -> Bool {
        

        if airportCode == "NO AIRPORT CODE" {
            print("NO AIRPORT CODE")
            return false
        }
        if city == "NO CITY" {
            print("NO CITY")
            return false
        }
        if delay == "NO DELAY STATUS" {
            print("NO DELAY STATUS")
            return false
        }
        if name == "NO NAME" {
            print("NO NAME")
            return false
        }
        if state == "NO STATE" {
            print("NO STATE")
            return false
        }
        if avgDelay == "NO AVG DELAY" {
            print("NO AVG DELAY")
            return false
        }
        if type == "NO TYPE" {
            print("NO TYPE")
            return false
        }
        if reason == "NO REASON" {
            print("NO REASON")
            return false
        }
        if tempF == "NO TEMPERATURE" {
            print("NO TEMPERATURE")
            return false
        }
        if tempFNum == 999 {
            print("NO TEMP NUMBER")
            return false
        }
        if visibility == "999" {
            print("NO VISIBILITY")
            return false
        }
        if weather == "NO WEATHER" {
            print("NO WEATHER")
            return false
        }
        if windSpeed == "NO WIND SPEED" {
            print("NO WIND SPEED")
            return false
        }
        if windDirection == "NO WIND DIRECTION" {
            print("NO WIND DIRECTION")
            return false
        }
        return true
    }

}


// MARK: Test Data
extension AirportStatus {
    
    class func getTestDataDictionary() -> NSDictionary? {
        
        let airportStatusDictionary: NSMutableDictionary = [:]
        
        let statusATL: [String: AnyObject] = [
            "IATA": "ATL",
            "city": "Atlanta",
            "delay": "false",
            "name": "Hartsfield-Jackson Atlanta International Airport",
            "state": "Georgia",
            "status": ["avgDelay" : "", "type": "", "reason": ""],
            "weather": ["temp": "83.0 F (28.3 C)", "visibility": 10.00, "weather": "Mostly Cloudy", "wind": "North at 5.8mph"]]
        
        let statusDFW: [String: AnyObject] = [
            "IATA": "DFW",
            "city": "Dallas",
            "delay": "true",
            "name": "Dallas/Ft Worth International",
            "state": "Texas",
            "status": ["avgDelay" : "10 minutes", "type": "Departure", "reason": "TM Initiatives:STOP:RWY"],
            "weather": ["temp": "83.0 F (28.3 C)", "visibility": 10.00, "weather": "A Few Clouds", "wind": "West at 10.4mph"]]
        
        let statusJFK: [String: AnyObject] = [
            "IATA": "JFK",
            "city": "New York",
            "delay": "false",
            "name": "John F Kennedy International",
            "state": "New York",
            "status": ["avgDelay" : "", "type": "", "reason": ""],
            "weather": ["temp": "81.0 F (27.2 C)", "visibility": 2.00, "weather": "Rain", "wind": "West at 15.0mph"]]
        
        let statusLAX: [String: AnyObject] = [
            
            "IATA": "LAX",
            "city": "Los Angeles",
            "delay": "true",
            "name": "Los Angeles International",
            "state": "California",
            "status": ["avgDelay" : "20 minutes", "type": "Thunderstorms", "reason": "TSTMS"],
            "weather": ["temp": "74.0 F (23.3 C)", "visibility": 1.00, "weather": "Thunderstorm", "wind": "West at 10.4mph"]]
        
        let statusORD: [String: AnyObject] = [
            "IATA": "ORD",
            "city": "Chicago",
            "delay": "true",
            "name": "Chicago OHare International",
            "state": "Illinois",
            "status": ["avgDelay" : "120 minutes", "type": "Emergency", "reason": "WX / EMERG"],
            "weather": ["temp": "74.0 F (23.3 C)", "visibility": 8.00, "weather": "Funnel Cloud", "wind": "South at 50.5mph"]]
        
        let statusArray = [statusATL, statusDFW, statusJFK, statusLAX, statusORD]
    
        for status in statusArray {
            let airportStatus = AirportStatus(status: status)
            airportStatusDictionary[airportStatus.airportCode] = airportStatus
        }
        
        return airportStatusDictionary
        
    }
    
}







































