//
//  BeaconTableViewController.swift
//  iBeaconDemo
//
//  Created by Shuchen Du on 2016/06/09.
//  Copyright © 2016年 Shuchen Du. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconTableViewController: UITableViewController {

    let locationManager = CLLocationManager()
    var items: [Item] = []
    
    func setItemsToMonitor() {
        
        let item = Item(name: "MacAir", uuid: NSUUID(UUIDString: "D797709A-FB7D-4B2E-91CE-4872D9AA1D4F")!, majorValue: 0, minorValue: 0, distance: "", meters: "", avatar: nil)
        
        startMonitoringItem(item)
        
        items.append(item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        setItemsToMonitor()
    }
    
    deinit {
        
        for item in items {
        
            stopMonitoringItem(item)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BEACON_ITEM", forIndexPath: indexPath) as! ItemTableViewCell

        let row = indexPath.row
        let item = items[row]
        
        cell.name.text = item.name
        cell.distance.text = item.distance
        cell.meters.text = item.meters
        cell.uuid.text = item.uuid.UUIDString
        cell.major.text = item.majorValue.description
        cell.minor.text = item.minorValue.description
        //cell.avatar.image = item.avatar

        return cell
    }

}

extension BeaconTableViewController: CLLocationManagerDelegate {
    
    func beaconRegionWithItem(item: Item) -> CLBeaconRegion {
        
        let beaconRegion = CLBeaconRegion(proximityUUID: item.uuid, major: item.majorValue, minor: item.minorValue, identifier: item.name)
        
        return beaconRegion
    }
    
    func startMonitoringItem(item: Item) {
        
        let beaconRegion = beaconRegionWithItem(item)
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func stopMonitoringItem(item: Item) {
        
        let beaconRegion = beaconRegionWithItem(item)
        locationManager.stopMonitoringForRegion(beaconRegion)
        locationManager.stopRangingBeaconsInRegion(beaconRegion)
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        
        let alert = UIAlertController(title: "ERROR", message: "Failed monitoring region!", preferredStyle: UIAlertControllerStyle.Alert)
        
        print("Failed monitoring region: \(error.description)")
        
        self.presentViewController(alert, animated: true, completion: {
            
        })
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        let alert = UIAlertController(title: "ERROR", message: "Location manager failed!", preferredStyle: UIAlertControllerStyle.Alert)
        
        print("Location manager failed: \(error.description)")
        
        self.presentViewController(alert, animated: true, completion: {
            
        })
    }
    
    func nameForProximity(proximity: CLProximity) -> String {
        
        switch proximity {
        
        case .Unknown:
            return "未知"
        case .Immediate:
            return "非常に近い"
        case .Near:
            return "近い"
        case .Far:
            return "遠い"
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        for beacon in beacons {
            
            for item in items {
                
                if item == beacon {
                    
                    item.distance = nameForProximity(beacon.proximity)
                    item.meters = String(format: "%.2f", beacon.accuracy)
                    
                    tableView.reloadData()
                }
            }
            
        }
    }
}
