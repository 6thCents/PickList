//
//  NotificationEvent.swift
//  PickList
//
//  Created by David Rollins on 11/29/15.
//  Copyright © 2015 David Rollins. All rights reserved.
//

import Foundation

class NotificationEvent<T> {
    
    typealias EventHandler = T -> ()
    
    private var eventHandlers = [EventHandler]()
    
    func addHandler(handler: EventHandler) {
        eventHandlers.append(handler)
    }
    
    func raise(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }
}