//
//  KanaConverter.swift
//  Hiragana
//
//  Created by hiroyuki tomiduka on 2019/09/28.
//  Copyright © 2019 ntuf. All rights reserved.
//

import Foundation

let urlString = String(Configuration.shared.goolabsAPI_hiragana_URL)
let app_id = String(Configuration.shared.goolabsAPI_app_id)

struct JsonData:Codable{
    let converted:String
}

class KanaConverter{
   
    func getKana(_ sentence: String, completion: @escaping (String)->Void){
        
       let request = NSMutableURLRequest(url: URL(string: urlString)!)
       request.httpMethod = "POST"
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")

       let params:[String:Any] = [
           "app_id": app_id,
           "sentence": sentence,
           "output_type": "hiragana"
       ]

       do{
           request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

           let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
                           
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    let data: JsonData = try decoder.decode(JsonData.self, from: data!)
                    completion(data.converted)
                } catch {
                    print("error:", error)
                    completion("")
                }
           })
           task.resume()
        }catch{
            print("error:\(error)")
            completion("")
        }
        
    }
    
    deinit {
        //print("deinit")
    }
    
}

