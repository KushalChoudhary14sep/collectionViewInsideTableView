//
//  APIProvider.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 23/04/21.
//

import Foundation
import Moya

enum HomeAPI {
    case getHomeRails
    case getPromotion(promoName : String)
    case getCollection(page : Int, psize : Int, collectionName : String)
    case getContinueReading(page : Int, psize : Int, userId: String)
    case getRecommended(page : Int, psize : Int, userId: String)
}

extension HomeAPI : TargetType {
    var baseURL: URL {
        return URL(string: "http://snippet-alb-testing-422974023.us-east-2.elb.amazonaws.com/api/v1")!
    }
    
    var path: String {
        switch  self {
        
        case .getHomeRails:
            return "/rails/home"
        case .getPromotion(promoName: let promoName):
            return "/promos/\(promoName)"
        case .getCollection(page: _, psize: _, collectionName: let collectionName):
            return "/collections/\(collectionName)"
        case .getContinueReading(page: _, psize: _, userId: let userId):
            return "/users/\(userId)/inprogress"
        case .getRecommended(page: _, psize: _, userId: let userId):
            return "/users/\(userId)/recommendations"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default :
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        
        case .getHomeRails:
            return .requestPlain
        case .getPromotion(promoName: _):
            return .requestPlain
        case .getCollection(page: let page, psize: let psize, collectionName: _):
            return .requestParameters(parameters: ["page" : page,"psize" : psize], encoding: URLEncoding.queryString)
        case .getContinueReading(page: let page, psize: let psize, userId: _):
            return .requestParameters(parameters: ["page" : page, "psize" : psize], encoding: URLEncoding.queryString)
        case .getRecommended(page: let page, psize: let psize, userId: _):
            return .requestParameters(parameters: ["page" : page, "psize" : psize], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json", "Authorization": Token.accessToken]
    }
}

class Token {
    static var accessToken = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MjAwNDU4MDksImlhdCI6MTYyMDA0NDYwOSwianRpIjoiZDQ0NTQyODAtNzc3ZS00MThiLTljMmYtNGE4NmJhNjk4ZDU2IiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiMGI3YWFhOTUtZjVjZi00NmVkLWJlYzEtNjRjMjM0ODliODA4IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiZGl2ZXkgdGVzdCIsInByZWZlcnJlZF91c2VybmFtZSI6ImRpdmV5QHNuaXAuY29tIiwiZ2l2ZW5fbmFtZSI6ImRpdmV5IiwidXNlcmlkIjoiMDQ1OTI4YmEtY2M3NS00ODFhLWIxZWUtOWYxMTk2OTE3ZTQ1IiwiZmFtaWx5X25hbWUiOiJ0ZXN0IiwiZW1haWwiOiJkaXZleUBzbmlwLmNvbSJ9.N25MBGqBwXJ1gPf1WFd7v6Rxrbqs8wf2hkxlibfHcqowsi36VMmiAjHPOcDIdYRoMuIlJxr5zpM5v83FwVsd9zZ_OS0JendNZ8ph1XIrKzcteiJboMpUH7Ym4oaqdp3kkxnSisJWLOSyqICNwwBktV3Zrsp9YYNIeqINimxewcz_k98odbKJf2wg0Rmt8lTQ-QAci4LfZUjO3mBet0aEvLakGbVsGFh5VKknjo--x3GCA9qOuc2A_1U2XxNvxYkvhUWSadTwrUZduofWVt3ydcUG17GC69aXHMEAbX-0Gn8Y99kGveFJGjT3j3bhCNk2Ei6stqq4RhQAwwRuiMlfXw"
}

