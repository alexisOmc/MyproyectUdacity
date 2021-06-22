//
//  ViewController.swift
//  Mynewproyect
//
//  Created by Alexis Omar Marquez Castillo on 03/02/21.
//  Copyright © 2021 udacity. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import MapKit
import CoreLocation
class ViewController: UIViewController, UITextFieldDelegate {

var window: UIWindow?
var urlMsgError: String = ""
static var finishedSession : Seession?
   

    @IBOutlet weak var imagenPin: UIImageView!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!

    @IBOutlet weak var passwordLabel: UITextField!
     
    @IBOutlet weak var signup: UIButton!
    let reachability = Reachability()!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 12
        signup.layer.cornerRadius = 12
        signup.layer.borderColor = UIColor.blue.cgColor
        signup.layer.borderWidth = 1
        
        
  reachability.whenReachable = { reachability in
          if reachability.connection == .wifi{
              print("Reachable via wifi")
          }else{
              print("Rechable via cellular ")
          }
          
      }
      reachability.whenReachable = { _ in
          print("Not reachable")
          
      }
      do{
          try reachability.startNotifier()
      }catch{
          print("No notification")
      }
      
      
      emailLabel.delegate = self
      passwordLabel.delegate = self
      
      
        self.confirmButton.center.y += self.view.bounds.height
        self.imagenPin.isHidden = true
        self.loginButton.isHidden = true
        emailLabel.isHidden = true
        passwordLabel.isHidden = true
        UIView.animate(withDuration: 2.0, delay: 0.2, options: .transitionCurlDown, animations: {self.confirmButton.center.y -= self.view.bounds.height
    }, completion: nil)
}
    
    
    
    @IBAction func confirmButton(_ sender: Any) {
    
        self.imagenPin.isHidden = false
        self.loginButton.isHidden = false
        emailLabel.isHidden = false
        passwordLabel.isHidden = false
        self.imagenPin.center.y -= self.view.bounds.height
        self.emailLabel.center.x -= self.view.bounds.width
        self.passwordLabel.center.x += self.view.bounds.width
        self.loginButton.center.y += self.view.bounds.height
        
        self.view.backgroundColor = .white
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .transitionCurlDown, animations: {self.loginButton.center.y -= self.view.bounds.height
        }, completion: nil)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .transitionCurlDown, animations: {self.emailLabel.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .transitionCurlDown, animations: {self.passwordLabel.center.x -= self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 3.0, initialSpringVelocity: 9.0, options: .transitionCrossDissolve, animations:{ self.imagenPin.center.y += self.view.bounds.height }, completion: nil)
        confirmButton.isHidden = true
        
    }
    
    @IBAction func log(_ sender: Any) {
        if isValidEmail(emailLabel.text!) == true {
    
ApiManager.sharedInstance.login(email: emailLabel.text!, password: passwordLabel.text!) { (response) in
        switch response {
        case .Success( _):
        DispatchQueue.main.async{
        //pásalo de pantalla
            if let VC = (self.storyboard?.instantiateViewController(withIdentifier: "miVc")) {
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
            }
        }
       case .Error(let error ):
        DispatchQueue.main.async {
        let alert = UIAlertController(title: "Ups", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
            }
            }
        }
    
            } else {
                
        func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "The internet connection appears to be offline", preferredStyle: .alert)
        alert.addAction(UIAlertAction (title: NSLocalizedString("Ok", comment: "Default Action"), style: .default, handler: {_ in
        NSLog("The \"ok\" alert ocurred.")
        }))
        self.present(alert, animated: true, completion: nil)
                    
                }
            }
        
        //self.confirmButton.isHidden = false
        //ailLabel.isHidden = true
        //self.view.backgroundColor = .white
        //confirmButton.isHidden = true
        //UIView.animate(withDuration: 2.3, delay: 0.0, options: .transitionCurlDown, animations: {self.passwordLabel.center.y -= 100
        //}, completion: nil)
        
    }
    
     func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           
           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
           
       }
       func textFieldDidBeginEditing(_ textField: UITextField) {
           
           if textField == emailLabel {
               emailLabel.text = ""
               
           } else if textField == passwordLabel {
               passwordLabel.text = ""
               self.view.frame.origin.y = -150 // Move view 150 points upward
           }
           
       }
       func textFieldDidEndEditing(_ textField: UITextField) {
           self.view.frame.origin.y = 0
           
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
    
    @IBAction func signUp(_ sender: Any) {
         guard let url = URL(string: "https://www.udacity.com/account/auth#!/signup") else {
                   return
               }
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           }

    
        func isMediaURLFormat() -> Bool {
               if let typedURL = self.emailLabel.text, !typedURL.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "please enter a valid email address", preferredStyle: .alert)
                alert.addAction(UIAlertAction (title: NSLocalizedString("Ok", comment: "Default Action"), style: .default, handler: {_ in
                    NSLog("The \"ok\" alert ocurred.")
                           }))
                self.present(alert, animated: true, completion: nil)
                
           }
           return false
    }
    
    
}
        
        
        
       


 






