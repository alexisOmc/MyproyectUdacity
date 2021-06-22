//
//  ApiManager.swift
//  Mynewproyect
//
//  Created by Alexis Omar Marquez Castillo on 04/02/21.
//  Copyright © 2021 udacity. All rights reserved.
//

import UIKit

class ApiManager: NSObject {
    enum Res<T> {
          case Success(T)
          case Error(String)
      }
      var firstName : String?
      var lastName : String?
      var locationStudent : Result?
     
      static let sharedInstance = ApiManager()
    
     func login(email: String, password: String, completion:@escaping (Res<Seession>)->Void){
             
             var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
             request.httpMethod = "POST"
             request.addValue("application/json", forHTTPHeaderField: "Accept")
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             // encoding a JSON body from a string, can also use a Codable struct
             request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
             
             let session = URLSession.shared
             
             let task = session.dataTask(with: request) { data, response, error in
                 if error != nil {
                     completion(.Error(error?.localizedDescription ?? "Unknown error"))
                     return
                 }
                 let range = (5..<data!.count)
                 let newData = data?.subdata(in: range) /* subset response data! */
                 print(String(data: newData!, encoding: .utf8)!)
                 
                 let session = try?  JSONDecoder().decode(Seession.self, from: newData!)
                 
                 
                 if let successSession = session {
                     completion(.Success(successSession))
                     ViewController.self.finishedSession = successSession
                     
                 } else {
                     let range = (5..<data!.count)
                     let newData = data?.subdata(in: range)
                     
                     let dataNew = (String(data: newData!, encoding: .utf8)!)
                     
                     var dictonary:NSDictionary?
                     
                     if let data = dataNew.data(using: String.Encoding.utf8) {
                         
                         do {
                             dictonary =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                             
                             
                             if let myDictionary = dictonary
                             {
                                 
                                 if let myError = myDictionary["error"] as? String {
                                     completion(.Error(myError))
                                     
                                 }
                                 
                             }
                         } catch let error as NSError {
                             completion(.Error(error.localizedDescription ))
                         }
                         
                         completion(.Error(error?.localizedDescription ?? ""))
                     }
                 }
             }
             task.resume()
             
             
         }
         
     }
