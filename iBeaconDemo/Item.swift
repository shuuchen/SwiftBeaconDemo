//
//  Item.swift
//  iBeaconDemo
//
//  Created by Du Shuchen on 2016/06/09.
//  Copyright © 2016年 Shuchen Du. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class Item: NSObject {
    
    let name: String
    let uuid: NSUUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    var distance: String
    var meters: String
    let avatar: UIImage?
    dynamic var lastSeenBeacon: CLBeacon?
    
    init(name: String, uuid: NSUUID, majorValue: CLBeaconMajorValue, minorValue: CLBeaconMinorValue, distance: String, meters: String, avatar: UIImage?) {
        
        self.name = name
        self.uuid = uuid
        self.majorValue = majorValue
        self.minorValue = minorValue
        self.distance = distance
        self.meters = meters
        self.avatar = avatar
    }
    
}

func ==(item: Item, beacon: CLBeacon) -> Bool {
    
    return item.uuid.UUIDString == beacon.proximityUUID.UUIDString
        && Int(item.majorValue) == Int(beacon.major)
        && Int(item.minorValue) == Int(beacon.minor)
}