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
        return ["Authorization" :  Token.accessToken]
    }
}

class Token {
    static var accessToken = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJGdDVJdEQzR0lDeVZmeDJ5S2Nnb1ZhZzYtZGVYMTh1dy1ZY2VNWjhNNGJFIn0.eyJleHAiOjE2MTk2MTU1NDcsImlhdCI6MTYxOTYxNDY0NywianRpIjoiNThkYTU2MjUtYjI0NC00NjhiLWE4OWYtZDY0NTdhNjc3NWY1IiwiaXNzIjoiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwL2F1dGgvcmVhbG1zL3NuaXBwZXQiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiNGRlMGNkMmQtODY5NC00MTBjLWE5NDEtZjZhY2VhODg0YzBjIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoic25pcHBldC1hcGkiLCJzZXNzaW9uX3N0YXRlIjoiNTljOWIxMmQtNzVjZS00MjZkLWI5YWYtMmZkOGNiY2I4NTdjIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyJodHRwOi8vc25pcHBldC1hbGItdGVzdGluZy00MjI5NzQwMjMudXMtZWFzdC0yLmVsYi5hbWF6b25hd3MuY29tIiwiaHR0cDovL2F1dGguc25pcHBldC5pbzo4MDgwIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIiwidXNlciJdfSwicmVzb3VyY2VfYWNjZXNzIjp7InNuaXBwZXQtYXBpIjp7InJvbGVzIjpbInVzZXIiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiUHJlbWl1bSIsInByZWZlcnJlZF91c2VybmFtZSI6InByZW1pdW1Ac25pcHBldC5jb20iLCJnaXZlbl9uYW1lIjoiUHJlbWl1bSIsInVzZXJpZCI6IjRkZTBjZDJkLTg2OTQtNDEwYy1hOTQxLWY2YWNlYTg4NGMwYyIsImZhbWlseV9uYW1lIjoiIiwiZW1haWwiOiJwcmVtaXVtQHNuaXBwZXQuY29tIn0.P1DpvcLuaI1vx4sDL45S7K8fIWShuyqFRbkSxz_ke_kcfSgAeX-Ii-s2fajbHxeluM0Fe-0lBWZHu-lyPyVZkW8VezaXvGrZBQP9JVH5aOrjXWenHLJTsVgDIAiPl7CFkQjT8sHB-41BX7jFT_fbiLmJgsL_orHoJjmvHH7RaWgWYyDUJ1H32NaWVNMQjzPx2CwUEhHJO4kgrkkgKhb798PWXzbeSVmFgMLoQ_cj2aIZYxuEhCimzPgmG4S0f-RGx_zQhBXUTtrrkawljmjvN-0KeRX04pgI3qpvVtiiq1Mg41RAxrwXB7908TyAOqddd5dzPUe-eIc6exlrWjU3fQ"
}

