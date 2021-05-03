//
//  HomeRestManger.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import Foundation
import Moya
class HomeRestManager : NSObject {
    let userId : String = "045928ba-cc75-481a-b1ee-9f1196917e45"
    static let apiProvider = MoyaProvider<HomeAPI>()
    static let shared = HomeRestManager()
    
    func getHomeRails(handler: ((Result<Rails,Error>) -> Void)?){
        HomeRestManager.apiProvider.request(.getHomeRails) { (reponse) in
            switch reponse {
            case .success(let response):
                do{
                    let data = try  JSONDecoder().decode(Rails.self, from: response.data)
                    handler?(.success(data))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getCollection(page :Int, psize: Int , collectionName : String , handler : ((Result<Collection,Error>) -> Void)?){
        HomeRestManager.apiProvider.request(.getCollection(page: page, psize: psize, collectionName: collectionName)) { (response) in
            switch response {
            
            case .success(let response):
                do{
                    let data = try  JSONDecoder().decode(Collection.self, from: response.data)
                    handler?(.success(data))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getPromotion(promoName: String, handler: ((Result<Promotion,Error>) -> Void)?) {
        HomeRestManager.apiProvider.request(.getPromotion(promoName: promoName)) { (response) in
            switch response{
            case .success(let response):
                do{
                    let data = try  JSONDecoder().decode(Promotion.self, from: response.data)
                    handler?(.success(data))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getContinueReading(page: Int, psize: Int, handler: ((Result<ContinueReading,Error>) -> Void)?) {
        HomeRestManager.apiProvider.request(.getContinueReading(page: page, psize: psize, userId: self.userId)) { (response) in
            switch response {
            case .success(let response):
                do{
                    let data = try  JSONDecoder().decode(ContinueReading.self, from: response.data)
                    handler?(.success(data))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
    
    func getRecommneded(page: Int, psize: Int, handler: ((Result<Recommended, Error>) -> Void)?) {
        HomeRestManager.apiProvider.request(.getRecommended(page: page, psize: psize, userId: self.userId)) { (response) in
            switch response{
            case .success(let response):
                do{
                    let data = try  JSONDecoder().decode(Recommended.self, from: response.data)
                    handler?(.success(data))
                }catch let error {
                    handler?(.failure(error))
                }
            case .failure(let error):
                handler?(.failure(error))
            }
        }
    }
}
