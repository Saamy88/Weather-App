//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Samuel Cordova on 8/14/15.
//  Copyright © 2015 Samuel Cordova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        var flag = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl
        {
            
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error ) -> Void in
                
                if let urlContent = data
                {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let websiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if websiteArray!.count > 1
                    {
                        let weatherArray = websiteArray![1].componentsSeparatedByString("</span>")
                        
                        if weatherArray.count > 1
                        {
                            flag = true
                            
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg", withString: "°")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                self.resultLabel.text = weatherSummary
                                
                            })
                            
                        }
                        
                    }
                    
                }
                if flag == false
                {
                    self.resultLabel.text = "Couldn't find that city. Please try again!"
                }
            }
            task?.resume()

        }
        else
        {
            self.resultLabel.text = "Couldn't find that city. Please try again!"

        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

