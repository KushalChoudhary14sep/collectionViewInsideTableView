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
    static var accessToken = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MjAwNDI5NjYsImlhdCI6MTYyMDA0MTc2NiwianRpIjoiNTc4MzgxMzEtOTU3Ni00MDUzLTljNDEtNWY1YzBhOTZjYzc4IiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiYjNkYzk2ZmEtNmIyYy00MGVkLWJkNzMtMjExMTI2MzRlMTVlIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiMjk4NDRkYmYtNDU2ZS00ZDBjLWEwYWEtZjRmMjJkY2EwZGNmIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiRGlrc2hhIFNhd2FybiIsInByZWZlcnJlZF91c2VybmFtZSI6InRlc3RAc25pcHBldC5jb20iLCJnaXZlbl9uYW1lIjoiRGlrc2hhIiwidXNlcmlkIjoiYjNkYzk2ZmEtNmIyYy00MGVkLWJkNzMtMjExMTI2MzRlMTVlIiwiZmFtaWx5X25hbWUiOiJTYXdhcm4iLCJlbWFpbCI6InRlc3RAc25pcHBldC5jb20ifQ.ViKO3lB0MMNlBy7VYSVQhKAdFsJTw57w5H2tGtcW-1rOZjrWO1vXmQdxnbzyt0Fu-_DCIfS_cKKbcz-ILzujjUtLH-blXsHnU0dJmnm8_kJHVXlgJqrcB9L-XItZ_LzpE74ngSsHhj7_unP7JrX-17nKWIUgyXvs340Sx4yX0FgIyY1ue4jycmifndV7tCSOeAt0dN3fJc80Fw-FG5maihEi69_uTzEVfdpKaMBDXE-te8zCc_Dc4J1qXUi5_59SuyGvADoWE5N5O9FbqYMWqvVSuguZ2wtewzmsj9hHnnVQzG-bf1mvdwiBS2gIXZ8cmSBPkrxvrjWOM14ewuKEjw"
}

