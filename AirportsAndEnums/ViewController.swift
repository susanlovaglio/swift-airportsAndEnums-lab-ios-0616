//
//  ViewController.swift
//  Enums
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties 
    
    // Aiport ImageViews
    @IBOutlet weak var airportImageView: UIImageView!
    @IBOutlet weak var airportBlurImageView: UIImageView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    // Airport Code Header Label
    @IBOutlet weak var airportCodeLabel: UILabel!
    
    // Aiport Status Labels
    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var airportLocationLabel: UILabel!
    @IBOutlet weak var delayStatusLabel: UILabel!
    @IBOutlet weak var typeStatusLabel: UILabel!
    @IBOutlet weak var reasonStatusLabel: UILabel!
    @IBOutlet weak var avgDelayStatusLabel: UILabel!
    
    // Weather Labels, ImageViews (Temperature, Condition)
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionColorView: UIView!
    @IBOutlet weak var conditionTypeLabel: UILabel!
    @IBOutlet weak var weatherStatusIcon: UIImageView!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    
    // Weather Labels, ImageViews (Wind, Visibility)
    @IBOutlet weak var windStatusLabel: UILabel!
    @IBOutlet weak var windDirectionIcon: UIImageView!
    @IBOutlet weak var visibilityStatusLabel: UILabel!
    
    // Enums
    var feltTemp: FeltTemp = .None
    var windDirection: WindDirection = .V
    var weatherCondition: WeatherCondition = .None
    
    // Airport Status Dictionary
    var airportDictionary: NSDictionary? {
        didSet {
            if let airportDict = airportDictionary {
                let sortedKeys = (airportDict.allKeys as! [String]).sort(<)
                if let code = sortedKeys.first {
                    
                }
            }
        }
    }
    
    // Airport Status
    var statusReceived: Bool = false
    var airportStatus: AirportStatus? {
        didSet {
            statusReceived = true
            if let status = airportStatus {
                setViewElementsFrom(status: status)
            }
            
        }
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        airportDictionary = AirportStatus.getTestDataDictionary()
        
    }
}

// MARK: Enums
extension ViewController {
    
    func setWeatherEnumsFrom(status s:AirportStatus, success: (FeltTemp, WindDirection, WeatherCondition) -> Void) {
        feltTemp = FeltTemp(rawValue: s.tempFNum)
        windDirection = WindDirection(rawValue: s.windDirection)
        weatherCondition = WeatherCondition.getWeatherConditionFor(s.weather)
        success(feltTemp, windDirection, weatherCondition)
    }
    
    // Airport Code Enum

    
    // Weather Condition Enum
    enum WeatherCondition: String {
        
        case Cloudy, Fair, Fog, Smoke, Rain, Snow, Thunderstorm, Windy, Dust, Tornado, None
        
        static func getWeatherConditionFor(status: String) -> WeatherCondition {
            
            var weatherConditions: NSDictionary?
            if let path = NSBundle.mainBundle().pathForResource("WeatherConditions", ofType: "plist") {
                weatherConditions = NSDictionary(contentsOfFile: path)
            }
            if let conditions = weatherConditions {
                
                for (key, value) in conditions {
                    
                    let condition = value as! NSArray
                    if condition.containsObject(status) {
                        
                        switch String(key) {
                        case "Cloudy":
                            return .Cloudy
                        case "Fair":
                            return .Fair
                        case "Fog":
                            return .Fog
                        case "Smoke":
                            return .Smoke
                        case "Rain":
                            return .Rain
                        case "Snow":
                            return .Snow
                        case "Thunderstorm":
                            return .Thunderstorm
                        case "Windy":
                            return .Windy
                        case "Dust":
                            return .Dust
                        case "Tornado":
                            return .Tornado
                        default:
                            return .None
                        }
                    }
                }
            }
            return .None
        }
        
    }
    
    // Felt Temperature Enum
    enum FeltTemp: Int { // depiction
        
        case Cold, Cool, Warm, Hot, None
        
        init(rawValue: Int) {
            switch rawValue {
            case Int.min..<30:
                self = .Cold
            case 30...59:
                self = .Cool
            case 60...85:
                self = .Warm
            case let x where x > 85:
                self = .Hot
            default:
                self = .None
            }
        }
        
        var color: UIColor {
            switch self {
            case .Cold: return UIColor.blueColor().colorWithAlphaComponent(0.5)
            case .Cool: return UIColor.cyanColor().colorWithAlphaComponent(0.5)
            case .Warm: return UIColor.orangeColor().colorWithAlphaComponent(0.5)
            case .Hot: return UIColor.redColor().colorWithAlphaComponent(0.5)
            case .None: return UIColor.clearColor()
            }
        }
        
        var description: String {
            switch self {
            case .Cold: return "COLD"
            case .Cool: return "COOL"
            case .Warm: return "WARM"
            case .Hot: return "HOT"
            case .None: return ""
            }
        }
        
    }
    
    // Wind Direction Enum
    enum WindDirection: String {
        
        case N, NNE, NE, E, SE, SSE, S, SSW, SW, W, NW, NNW, V
        
        init(rawValue: String) {
            
            switch rawValue {
            case "North":
                self = .N
            case "North-Northeast":
                self = .NNE
            case "Northeast":
                self = .NE
            case "East":
                self = .E
            case "Southeast":
                self = .SE
            case "South-Southeast":
                self = .SSE
            case "South":
                self = .S
            case "South-Southwest":
                self = .SSW
            case "Southwest":
                self = .SW
            case "West":
                self = .W
            case "Northwest":
                self = .NW
            case "North-Northwest":
                self = .NNW
            default:
                self = .V
            }
        }
        
        var radians: Double {
            switch self {
            case .N: return 0
            case .NNE: return M_PI/6
            case .NE: return M_PI/3
            case .E: return M_PI_2
            case .SE: return 2*M_PI/3
            case .SSE: return 5*M_PI/6
            case .S: return M_PI
            case .SSW: return -5*M_PI/6
            case .SW: return -2*M_PI/3
            case .W: return -M_PI_2
            case .NW: return -M_PI/3
            case .NNW: return -M_PI/6
            case .V: return 0
            }
        }

    }

}

// MARK: View Set Up
extension ViewController {
    
    func setUpView() {
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(_:)))
        leftSwipeGesture.direction = .Left
        view.addGestureRecognizer(leftSwipeGesture)
        
        self.conditionColorView.layer.cornerRadius = 8
    
    }
    
}

// MARK: Gesture 
extension ViewController {
    
    // Handle left swipe gesture
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        changeStatusWithAnimation()
    }
    
    // Change status for view
    func changeStatusWithAnimation() {
        if statusReceived {
            
            UIView.transitionWithView(view, duration: 0.5, options: .TransitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
}

// MARK: View Elements
extension ViewController {
    
    func setViewElementsFrom(status s:AirportStatus) {
        setWeatherEnumsFrom(status: s) { ft, wd, wc in
            self.rotateWindCompassUsing(windDirection: wd)
            self.setConditionViewElementsFrom(feltTemp: ft, condition: wc)
        }
        
        setWeatherLabelsFrom(status: s)
        setStatusLabelsFrom(status: s)
        setAirportLabelsFrom(status: s)
        
        setAirportImagesFrom(status: s)
    }
    
    func setWeatherLabelsFrom(status s:AirportStatus) {
        temperatureLabel.text = s.tempF
        weatherStatusLabel.text = s.weather
        windStatusLabel.text = s.windSpeed
        visibilityStatusLabel.text = s.visibility
    }
    
    func setStatusLabelsFrom(status s:AirportStatus) {
        delayStatusLabel.text = s.delay
        typeStatusLabel.text = s.type
        reasonStatusLabel.text = s.reason
        avgDelayStatusLabel.text = s.avgDelay
    }
    
    func setAirportLabelsFrom(status s:AirportStatus) {
        airportCodeLabel.text = s.airportCode
        airportNameLabel.text = s.name
        airportLocationLabel.text = s.city + ", " + s.state
    }
    
    func setAirportImagesFrom(status s:AirportStatus) {
        airportImageView.image = UIImage(named: s.airportCode)
        airportBlurImageView.image = UIImage(named: s.airportCode)
    }
    
    func rotateWindCompassUsing(windDirection wd: WindDirection) {
        windDirectionIcon.transform = CGAffineTransformIdentity
        windDirectionIcon.transform = CGAffineTransformMakeRotation(CGFloat(wd.radians))
    }
    
    func setConditionViewElementsFrom(feltTemp ft:FeltTemp, condition c:WeatherCondition) {
        conditionColorView.backgroundColor = ft.color
        conditionTypeLabel.text = ft.description
        weatherStatusIcon.image = UIImage(named: c.rawValue)
    }

}

