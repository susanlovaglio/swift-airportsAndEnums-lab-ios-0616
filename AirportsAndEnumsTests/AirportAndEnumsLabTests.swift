//
//  AirportAndEnumsTests.swift
//  AirportsAndEnums
//

import Quick
import Nimble
import Foundation
@testable import AirportsAndEnums

class ViewControllerSpec: QuickSpec {
    //SpecBegin(ValidatorViewController)
    override func spec() {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewControllerWithIdentifier("vcIdentifier") as! ViewController
        vc.loadView()
        
        describe("airport code enum") {
            beforeEach {
                vc.airportDictionary = AirportStatus.getTestDataDictionary()
            }
            it("should have a raw value equal to the first enum case") {
                if let airportCode = vc.airportCode {
                   expect(airportCode.rawValue).to(equal("ATL"))
                }
                
            }
            
        }
        
        describe("user first swipe") {
            beforeEach {
                vc.changeStatusWithAnimation()
            }
            it("should update view using airport code enum and airport status object") {
                if let airportCode = vc.airportCode {
                    expect(airportCode.rawValue).to(equal("DFW"))
                }
                if let airportStatus = vc.airportStatus {
                    expect(airportStatus.airportCode).to(equal("DFW"))
                }
                
            }
        }
            
        describe("user second swipe") {
            beforeEach {
                vc.changeStatusWithAnimation()
            }
            it("should update view using airport code enum and airport status object") {
                if let airportCode = vc.airportCode {
                    expect(airportCode.rawValue).to(equal("JFK"))
                }
                if let airportStatus = vc.airportStatus {
                    expect(airportStatus.airportCode).to(equal("JFK"))
                }
                
            }
        }
        
        describe("user third swipe") {
            beforeEach {
                vc.changeStatusWithAnimation()
            }
            it("should update view using airport code enum and airport status object") {
                if let airportCode = vc.airportCode {
                    expect(airportCode.rawValue).to(equal("LAX"))
                }
                if let airportStatus = vc.airportStatus {
                    expect(airportStatus.airportCode).to(equal("LAX"))
                }
                
            }
        }
        
        describe("user fourth swipe") {
            beforeEach {
                vc.changeStatusWithAnimation()
            }
            it("should update view using airport code enum and airport status object") {
                if let airportCode = vc.airportCode {
                    expect(airportCode.rawValue).to(equal("ORD"))
                }
                if let airportStatus = vc.airportStatus {
                    expect(airportStatus.airportCode).to(equal("ORD"))
                }
                
            }
        }
        
        describe("user fifth swipe") {
            beforeEach {
                vc.changeStatusWithAnimation()
            }
            it("should update view using airport code enum and airport status object") {
                if let airportCode = vc.airportCode {
                    expect(airportCode.rawValue).to(equal("ATL"))
                }
                if let airportStatus = vc.airportStatus {
                    expect(airportStatus.airportCode).to(equal("ATL"))
                }
                
            }
        }


        
        
    }
}