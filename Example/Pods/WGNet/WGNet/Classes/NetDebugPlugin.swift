//
//  NetDebugPlugin.swift
//  WGNet
//
//  Created by chen liang on 2021/1/15.
//

import Foundation
import Moya

//实现环境切换功能插件
public class NetDebugPlugin: Moya.PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
//        var req = URLRequest.init(url: request.url!, cachePolicy: request.cachePolicy, timeoutInterval: request.timeoutInterval)
//        var headers = req.allHTTPHeaderFields ?? [String: String]()
//        headers["test"] = "test"
//        req.allHTTPHeaderFields = headers
//        switch target.task {
//        case let .requestParameters(parameters: parameters, encoding: parameterEncoding):
//            do {
//               req = try parameterEncoding.encode(req, with: parameters)
//            } catch _ {
//                return request
//            }
//           return req
//        default:
//            return req
//        }
    }
    
}
