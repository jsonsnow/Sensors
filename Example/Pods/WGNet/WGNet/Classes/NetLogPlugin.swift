//
//  NetLogPulgin.swift
//  Alamofire
//
//  Created by chen liang on 2021/1/15.
//

import Foundation
import Moya

public class NetLogPlugin: Moya.PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
    }
}
