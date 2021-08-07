//
//  File.swift
//  KasleFrameworkTestApp
//
//  Created by Global on 05/08/21.
//

import Foundation

typealias ChannelName = String
typealias CallBack = ()->()

protocol PublisherSubscriber { }

fileprivate var callBackMap:[ChannelName: [CallBack?]] = [:]

extension PublisherSubscriber {
    
    func fireOnChannel(_ channel: ChannelName) {
        let arrCallBack = callBackMap[channel] ?? []
        DispatchQueue.concurrentPerform(iterations: arrCallBack.count) { (index) in
            if let callBack = arrCallBack[index] {
                callBack()
            }
        }
    }
    
    func addSubscriptionTo(channal: ChannelName, _ callBack: @escaping CallBack) {
        var arrCallBack = callBackMap[channal] ?? []
        arrCallBack.append(callBack)
        callBackMap[channal] = arrCallBack;
    }
    
    func removeSubscriptionToChannel(_ channelName: ChannelName) {
        callBackMap.removeValue(forKey: channelName)
    }
}

