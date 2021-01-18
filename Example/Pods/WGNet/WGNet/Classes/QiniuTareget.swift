//
//  WGQiniuTaregetAPI.swift
//  WGNet
//
//  Created by chen liang on 2021/1/15.
//

import UIKit

class WGQiniuTareget: BaseTarget {
    public convenience init(params: [String: Any], path: String) {
        self.init(paramsClosure: { (target) -> [String : Any] in
            return params
        }, baseUrlClosure: { (target) -> String in
            return "https://www.wsxcme.com/"
        }, path: path)
    }
}
