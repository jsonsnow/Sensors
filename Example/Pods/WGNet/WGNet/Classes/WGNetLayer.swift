//
//  WGNetLayer.swift
//  WGNet
//
//  Created by chen liang on 2021/1/15.
//

import Foundation
import Moya
import Alamofire

let loggerPlugin = NetworkLoggerPlugin.init()
let logPlugin = NetLogPlugin.init()
let vipPlugin = VipPlugin.init()
let paramsPlugin = DefaultParamsPlugin.init()
let netDebugPlugin = NetDebugPlugin.init()

let albumProvider = MoyaProvider<AlbumTarget>(plugins: [netDebugPlugin, paramsPlugin, logPlugin, vipPlugin, loggerPlugin])
let orderProvider = MoyaProvider<OrderTarget>(plugins: [netDebugPlugin, paramsPlugin, logPlugin, vipPlugin, loggerPlugin])
let mockProvider = MoyaProvider<MockTarget>(plugins: [netDebugPlugin, paramsPlugin, logPlugin, vipPlugin, loggerPlugin])

public class NetCancellable: NSObject {
    
    let cancellable: Cancellable
    
    init(cancellable: Cancellable) {
        self.cancellable = cancellable
    }
    
    @objc public func cancle() {
        self.cancellable.cancel()
    }
    
}

var providerMaps: [String: Any] = [String: Any]()
func generateProvider<T: BaseTarget>(with type: T.Type) -> MoyaProvider<T> {
    let key = type.description()
    if let provider = providerMaps[key] as? MoyaProvider<T> {
        return provider
    }
    let provider = MoyaProvider<T>(plugins: [netDebugPlugin, paramsPlugin, logPlugin, vipPlugin, loggerPlugin]);
    providerMaps[key] = provider
    return provider
}

public class NetLayer: NSObject {
    public typealias HeadersClosure = (String) -> [String: String]?
    public typealias CallbackClosure = (_ data: WGConnectData) -> Void
    @objc public static let net: NetLayer = NetLayer.init()
    public private(set) var defaultHeades: [String: String]?
    public private(set) var defaultParams: [String: Any]?
    public private(set) var netDebugValue: String?
    
    private override init() {
        super.init()
        albumProvider.manager.delegate.sessionDidReceiveChallenge = {(session , change) in
            return self.trustServer(challenge: change)
        }
    }
    
  
    @discardableResult
    @objc public func orderRequst(path: String, params: [String: Any]?, callback: @escaping CallbackClosure) -> NetCancellable {
        let cancelable = orderProvider.request(OrderTarget.init(params: params ?? [String: Any](), path: path)) { (result) in
            switch result {
            case let .success(response):
                callback(self.handleResponse(response))
            case let .failure(error):
                callback(self.handleError(error))
            }
        }
        return NetCancellable.init(cancellable: cancelable)
    }
    
    @discardableResult
    @objc public func albumRequst(path: String, params: [String: Any]?, callback: @escaping CallbackClosure) -> NetCancellable {
        let cancelable = albumProvider.request(AlbumTarget.init(params: params ?? [String: Any](), path: path)) { (result) in
            switch result {
            case let .success(response):
                callback(self.handleResponse(response))
            case let .failure(error):
                callback(self.handleError(error))
            }
        }
        return NetCancellable.init(cancellable: cancelable)
    }
    
    @discardableResult
    @objc public func mockRequst(path: String, params: [String: Any]?, callback: @escaping CallbackClosure) -> NetCancellable {
        let cancelable = mockProvider.request(MockTarget.init(params: params ?? [String: Any](), path: path)) { (result) in
            switch result {
            case let .success(response):
                callback(self.handleResponse(response))
            case let .failure(error):
                callback(self.handleError(error))
            }
        }
        return NetCancellable.init(cancellable: cancelable)
    }
    
    public func request<T: BaseTarget>(path: ApiTypeAble, params: [String: Any]?, type: T.Type, completion: @escaping Completion) -> Cancellable {
        generateProvider(with: type).request(type.init(paramsClosure: { (target) -> [String : Any] in
            return params ?? [String: Any]()
        }, baseUrlClosure: { (target) -> String in
            type.baseUrlStr()
        }, path: path.path()), completion: completion)
    }
}

extension NetLayer {
    //不做任何验证，直接信任服务器
    private func trustServer(challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        let disposition = URLSession.AuthChallengeDisposition.useCredential
        let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        return (disposition, credential)
        
    }
}

//MARK: -- Handler result
extension NetLayer {
    private func handleResponse(_ response: Response) -> WGConnectData {
        let data = WGConnectData.init()
        data.isSuccess = true
        data.errType = .kConnect_none
        let json = try? response.mapJSON(failsOnEmptyData: true)
        data.responseData = json
        if let result = json as? [String: Any] {
            data.errcode = "\(result[ResponseKeyType.errcode.rawValue] as? String ?? "")"
            data.errmsg = result[ResponseKeyType.errmsg.rawValue] as? String
            data.uid = result[ResponseKeyType.uid.rawValue] as? String
            data.redirect_url = result[ResponseKeyType.redirect_url.rawValue] as? String
            data.result = result[ResponseKeyType.result.rawValue]
            if let code = data.errcode {
                if code != "0" {
                    data.errType = .kConnect_Serve_Error_Type
                    data.isSuccess = false
                }
            }
        }
        return data
    }
    
    private func handleError(_ error: MoyaError) -> WGConnectData {
        let data = WGConnectData.init()
        data.errType = .kConnect_Unknow_Error_Type
        data.isSuccess = false
        switch error {
        case let .underlying(urlError, _):
            if let _urlError = urlError as? URLError {
                if _urlError.errorCode == URLError.timedOut.rawValue {
                    data.errType = .kConnect_TimeOut_Error_Type
                }
            }
        default:
            print("")
        }
        return data
    }
}

//MARK: -- DefaultParams
extension NetLayer {
    
    @objc public func configDefaultHeaders(_ headers: [String: String]) {
        defaultHeades = headers
    }
    
    @objc public func configDefaultParams(_ params: [String: Any]) {
        defaultParams = params
    }
    
}


@objc public enum NetErrorType: Int {
    case kConnect_none
    case kConnect_Unknow_Error_Type
    case kConnect_Local_Error_Type
    case kConnect_Serve_Error_Type
    case kConnect_TimeOut_Error_Type
    case kConnect_QiNiu_Error_Type
}

enum ResponseKeyType: String {
    case errcode = "errcode"
    case errmsg = "errmsg"
    case result = "result"
    case uid = "uid"
    case redirect_url = "redirect_url"
}


@objc public class WGConnectData: NSObject {
    
    @objc public var errcode: String?
    @objc public var errmsg: String?
    public var status: Int?
    public var totalPage: Int?
    @objc public var responseData: Any?
    @objc public var isSuccess: Bool = false
    @objc public var errType: NetErrorType = .kConnect_none
    @objc public var uid: String?
    @objc public var redirect_url: String?
    @objc public var result: Any?
    
    override init() {
        super.init()
    }
}

extension URLRequest {
    func copyRequest(_ request: URLRequest) -> URLRequest {
        var req = URLRequest.init(url: request.url!, cachePolicy: request.cachePolicy, timeoutInterval: request.timeoutInterval)
        req.httpMethod = request.httpMethod
        req.allHTTPHeaderFields = request.allHTTPHeaderFields
        return req
    }
}
