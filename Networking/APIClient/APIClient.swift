//
//  APIClient.swift
//  Networking
//

import Alamofire

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter,
                                                    decoder: JSONDecoder = JSONDecoder(),
                                                    completion:@escaping (AFResult<T>) -> Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                            completion(response.result)
        }
    }
    
    static func login(email: String, password: String, completion:@escaping (AFResult<User>)->Void) {
        performRequest(route: APIRouter.login(email: email, password: password), completion: completion)
    }
    
    static func getArticles(completion:@escaping (AFResult<[Article]>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: APIRouter.articles, decoder: jsonDecoder, completion: completion)
    }
    

}

