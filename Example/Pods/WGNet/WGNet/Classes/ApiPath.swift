//
//  ApiPath.swift
//  WGNet
//
//  Created by chen liang on 2021/1/18.
//

import Foundation

//目前没什么好的方法桥接到OC
public protocol ApiTypeAble {
    func path() -> String
}

public enum UserApi {
    case login
    
}

extension UserApi: ApiTypeAble {
    public func path() -> String {
        switch self {
        case .login:
            return "service/account/app_auth.jsp}"
        }
    }
}


public enum ConfigApi {
    case sysConfig
    case sensorConfig
}

extension ConfigApi: ApiTypeAble {
    public func path() -> String {
        switch self {
        case .sysConfig:
            return "service/sys/sys_config.jsp"
        case .sensorConfig:
            return "service/sys/sys_config.jsp"
        }
    }
}

public enum AlbumPersonalApi {
    case all
    case new
    case video
    case images
    case detail
}

extension AlbumPersonalApi: ApiTypeAble {
    
    public func path() -> String {
        switch self {
        case .all:
            return "album/personal/all"
        case .new:
            return "album/personal/new"
        case .video:
            return "album/personal/video"
        case .images:
            return "album/personal/image"
        case .detail:
            return "commodity/view"
        }
    }
}
