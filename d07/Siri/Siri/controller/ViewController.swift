//
//  ViewController.swift
//  Siri
//
//  Created by Njabulo MAJOZI on 2018/10/11.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI

class ViewController: UIViewController {
    private var bot:RecastAIClient?
    private var weatherProviderClient:DarkSkyClient?
    @IBOutlet weak var requestText: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token : SiriData.getRecastBotAPIToken())
        self.weatherProviderClient = DarkSkyClient(apiKey: SiriData.getForecastIOAPIToken())
        self.weatherProviderClient?.units = .si
    }
    
    @IBAction func makeRequest(_ sender: UIButton) {
        print("CLICK: Request")
        if let request = self.requestText.text {
            if (request.count > 0){
                print("RECAST: Request")
                self.bot?.textRequest(request, successHandler: self.recastRequestDone, failureHandle: self.recastRequestError)
            } else {
                self.resultsLabel.text = "Please enter request"
            }
        }
    }
    
    private func recastRequestDone(_ response : Response)
    {
        print("RECAST: Done")
        if let intentSlug = response.intent()?.slug {
            if intentSlug == "weather" {
                if let location = response.get(entity: "location") {
                    if let latitude = location["lat"] as? Double  , let longitude = location["lng"] as? Double {
                        self.getForecast(latitude: latitude, logitude: longitude)
                    } else {
                        self.resultsLabel.text = "Place doesn't exist"
                    }
                } else {
                    self.resultsLabel.text = "Place doesn't exist"
                }
            } else {
                self.resultsLabel.text = "Can't process input information"
            }
        } else {
            self.resultsLabel.text = "Can't perform request at a memont"
        }
    }
    
    private func getForecast(latitude _latitude: Double, logitude _logitude: Double) {
        print("FORECAST: request")
        self.weatherProviderClient?.getForecast(latitude: _latitude, longitude: _logitude, completion: self.forecastResponseHandler)
    }
    
    private func forecastResponseHandler(_ response: Result<Forecast>) {
        print("FORECAST: Handle")
        switch response {
        case .success(let currentForecast, let requestMetadata):
            print("FORECAST: Success")
            if let currentForecastData = currentForecast.currently {
                if let weatherSummary = currentForecastData.summary, let degrees = currentForecastData.temperature {
                    DispatchQueue.main.async {
                        self.resultsLabel.text = ("\(weatherSummary) \(degrees) Celsius")
                    }
                    print("FORECAST: \(requestMetadata)")
                }
            }
            
        case .failure(let error):
            print("FORECAST: Failure")
            DispatchQueue.main.async {
                print(error.localizedDescription)
                self.resultsLabel.text = ("Can't perform request at a memont")
            }
        }
    }
    
    private func recastRequestError(_ error: Error) {
        print("RECAST: \(error.localizedDescription)")
        self.resultsLabel.text = "Can't perform request at a memont"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
