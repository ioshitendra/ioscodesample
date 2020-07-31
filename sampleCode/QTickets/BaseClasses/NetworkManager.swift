
import UIKit
import Alamofire
import SwiftyJSON


struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}


public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}


// Network manager Class for API Calling Methods
class NetworkManager : NSObject {
    
    public static let shared = NetworkManager()
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()

     //MARK: POST ROW MEthod For API Calls
    
    func requestRawPOSTURL(apiUrl: String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
           
           if !Connectivity.isConnectedToInternet {
               Global.showAlertWithMessage(message: ConstantsMessages.kConnectionFailed)
           } else {
                      let ulr =  NSURL(string: apiUrl)
                      var request = URLRequest(url: ulr! as URL)
                      request.httpMethod = "POST"
                      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                      let data = try! JSONSerialization.data(withJSONObject: params!, options: JSONSerialization.WritingOptions.prettyPrinted)
                      let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                      if let json = json {
                          print(json)
                      }
               request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
               Alamofire.request(request as URLRequestConvertible)
               .responseJSON { (responseObject) -> Void in
                   switch responseObject.result {
                   case .success(_):
                       let resJson = JSON(responseObject.result.value!)
                       debugPrint(responseObject.request ?? "")
                       debugPrint(resJson)
                       success(resJson)
                   case .failure(_):
                       let error : Error = responseObject.result.error!
                       debugPrint(error)
                       failure(error)
                   }
               }
           }
       }

    //MARK: POST MEthod For API Calls
    
    func requestPOSTURL(apiUrl: String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
         
        if !Connectivity.isConnectedToInternet {
            Global.showAlertWithMessage(message: ConstantsMessages.kConnectionFailed)
        } else {
            Alamofire.SessionManager.default.request(apiUrl, method: .post, parameters: params!, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
                switch responseObject.result {
                case .success(_):
                    let resJson = JSON(responseObject.result.value!)
                    debugPrint(responseObject.request ?? "")
                    debugPrint(resJson)
                    success(resJson)
                case .failure(_):
                    let error : Error = responseObject.result.error!
                    debugPrint(error)
                    failure(error)
                }
            }
        }
    }
    
    //MARK: GET method for API Calls
    
    func requestGETURL(apiUrl: String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        
        if !Connectivity.isConnectedToInternet {
            Global.showAlertWithMessage(message: ConstantsMessages.kConnectionFailed)
        } else {
            Alamofire.SessionManager.default.request(apiUrl, method: .get, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseJSON { (responseObject) -> Void in
                switch responseObject.result {
                case .success(_):
                    let resJson = JSON(responseObject.result.value!)
                    debugPrint(responseObject.request ?? "")
                    debugPrint(resJson)
                    success(resJson)
                case .failure(_):
                    let error : Error = responseObject.result.error!
                    debugPrint(error)
                    failure(error)
                }
            }
        }
    }
    
  
    public func getData(from endpoint: String, result: @escaping (Swift.Result<Type, APIServiceError>) -> Void) {
        //let url = URL(string: endpoint)!
       // self.fetchResources(url1: endpoint, completion: result)
      //  self.fetchResources(url: url, completion: result)
      //  fetchResources(url: movieURL, completion: result)
    }
  
    private func fetchResources<T: Decodable>(url1: String, completion: @escaping (Swift.Result<T, APIServiceError>) -> Void) {
        let url2 = URL(string: url1)!

        guard let urlComponents = URLComponents(url: url2, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: url) { (result, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let jsonData = result else{
                completion(.failure(.noData))
                return
            }
            do {
                let values = try self.jsonDecoder.decode(T.self, from: jsonData)
                completion(.success(values))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}
