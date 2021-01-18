//
//  MockTargetApi.swift
//  WGNet
//
//  Created by chen liang on 2021/1/15.
//

import Foundation
import Moya

//mock 服务器
class MockTarget: BaseTarget {
    public convenience init(params: [String: Any], path: String) {
        self.init(paramsClosure: { (target) -> [String : Any] in
            return params
        }, baseUrlClosure: { (target) -> String in
            return "http://192.168.1.55:3000/"
        }, path: path)
    }
}
