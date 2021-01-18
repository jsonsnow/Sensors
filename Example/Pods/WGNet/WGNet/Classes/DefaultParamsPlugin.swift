//
//  NetCommonParamsPlugin.swift
//  WGNet
//
//  Created by chen liang on 2021/1/15.
//

import Foundation
import Moya
import Alamofire


public class WraperDefaultPlugin: NSObject {
    
    
}

public class DefaultParamsPlugin: Moya.PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var req = URLRequest.init(url: request.url!, cachePolicy: request.cachePolicy, timeoutInterval: request.timeoutInterval)
        req.httpMethod = request.httpMethod
        var headers = req.allHTTPHeaderFields ?? [String: String]()
        if let _heads = NetLayer.net.defaultHeades {
            headers = headers.merging(_heads, uniquingKeysWith: { (first, _) -> String in
                return first
            })
        }
        req.allHTTPHeaderFields = headers
        switch target.task {
        case let .requestCompositeParameters(bodyParameters: bodyParams, bodyEncoding: encode, urlParameters: _):
            do {
                var params = bodyParams
                if let _params = NetLayer.net.defaultParams {
                    params = params.merging(_params) { (first, _) -> Any in
                        return first
                    }
                }
                if let jsonEncode = encode as? URLEncoding {
                    req = try jsonEncode.encode(req, with: params)
                }
            } catch _ {
                return request
            }
           return req
        default:
            return req
        }
    }
    
}
