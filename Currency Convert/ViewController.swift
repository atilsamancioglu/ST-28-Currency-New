//
//  ViewController.swift
//  Currency Convert
//
//  Created by Atil Samancioglu on 15.04.2018.
//  Copyright © 2018 Atil Samancioglu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func getRates(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=5aca0ebe96f3b4a12e865d6ce1dad0ad&format=1")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                if data != nil {
                    
                    do {
                        
                    let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>
                        
                        DispatchQueue.main.async {
                            //print(jSONResult)
                            
                            let rates = jSONResult["rates"] as! [String:AnyObject]
                            
                            //print(rates)
                            
                            let turkish = String(describing: rates["TRY"]!)
                            self.tryLabel.text = "TRY: \(turkish)"
                            
                            let cad = String(describing: rates["CAD"]!)
                            self.cadLabel.text = "CAD: \(cad)"
                            
                            let chf = String(describing: rates["CHF"]!)
                            self.chfLabel.text = "CHF: \(chf)"
                            
                            let gbp = String(describing: rates["GBP"]!)
                            self.gbpLabel.text = "GBP: \(gbp)"
                            
                            let jpy = String(describing: rates["JPY"]!)
                            self.jpyLabel.text = "JPY: \(jpy)"
                            
                            let usd = String(describing: rates["USD"]!)
                            self.usdLabel.text = "USD: \(usd)"
                        }
                        
                        
                    } catch {
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        task.resume()
    }
    
}

