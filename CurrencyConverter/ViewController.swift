//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Muaz Talha Bulut on 1.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func showButton(_ sender: Any) {
        
        // 1. request & session
        //2. response & data
        //3. parsing & Json serilization
       
        //1=
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=2780a3e76525a4c8a01fdc69598032ba")
        
        let session = URLSession.shared
        
        // closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert) // manuel error mesajı vermedik localized yaparak otomatik göstermesini sağladık.
                
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil) // handler butona dıkladığımda bir şey olmasını istemiyorum yaptık nil kullanarak.
                
                alert.addAction(okButton) // uyarı mesajımızı alert değişkenine ekledik
                self.present(alert, animated: true, completion: nil) // present geçiş için kullanılır.
            }else{
                //2=
                if data != nil {
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary <String, Any> // cast etmemiizn sebebi api den verileri çekebilmek
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                if let TRY = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY \(TRY)"
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
            }
        }
        task.resume() // yukarıda yarım kalan task a task.resume şeklinde devam etmeliyiz. Task ın bittiği parantezden sonra yazıyoruz kodumuzu.
    }
    

}

