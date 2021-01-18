//
//  ClickEventSend.swift
//  WeAblum
//
//  Created by chen liang on 2020/1/9.
//  Copyright © 2020 WeAblum. All rights reserved.
//

import Foundation

class ClickEventSend: NSObject {
    @objc static func sendClickWithType(_ type: AnyClass, from: UIViewController? = DataAnlyticsManager.anlytic.cl_currentCtr()) -> Void {
//        var ctr = from
//        if from == nil {
//            ctr = DataAnlyticsManager.anlytic.cl_currentCtr()
//        }
//        let eventType: BaseClickEvent.Type = type as! BaseClickEvent.Type
        //let event: BaseClickEvent =
    }
    
    @objc static func personAlbumSendClickEdit(from: UIViewController) {
//        let event = ClickEnterProductEvent.init(title: from.sensorsdata_title)
//        event.send()
    }
}



