//
//  TDDeviceManage.m
//  TemperatureDemo
//
//  Created by liaojinhua on 15/2/27.
//  Copyright (c) 2015年 April Brother. All rights reserved.
//

#import "TDDeviceManage.h"
#import "TDBeacon.h"

NSString *SpecialUUID = @"E2C56DB5-DFFB-48D2-B060-D0F5A71096E1";

@interface TDDeviceManage () <ABBeaconManagerDelegate>

@property (nonatomic, strong) ABBeaconManager *beaconManager;

@property (nonatomic, strong) NSMutableDictionary *beaconsDic;

@end

@implementation TDDeviceManage


- (id)init
{
    if (self = [super init]) {
        self.beaconManager = [[ABBeaconManager alloc] init];
        self.beaconManager.delegate = self;
    }
    return self;
}

- (void)startRangeUUID:(NSString *)uuidString
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
    ABBeaconRegion *region = [[ABBeaconRegion alloc] initWithProximityUUID:uuid identifier:uuidString];
    [self.beaconManager startRangingBeaconsInRegion:region];
    
    // range temperature and humidity data
    uuid = [[NSUUID alloc] initWithUUIDString:SpecialUUID];
    region = [[ABBeaconRegion alloc] initWithProximityUUID:uuid identifier:SpecialUUID];
    [self.beaconManager startRangingBeaconsInRegion:region];
}

- (void)stopRangeUUID:(NSString *)uuidString
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:uuidString];
    ABBeaconRegion *region = [[ABBeaconRegion alloc] initWithProximityUUID:uuid identifier:uuidString];
    [self.beaconManager stopRangingBeaconsInRegion:region];
}

#pragma mark - ABBeaconMangerDelegate
- (void)beaconManager:(ABBeaconManager *)manager
      didRangeBeacons:(NSArray *)beacons
             inRegion:(ABBeaconRegion *)region
{
    for (ABBeacon *beacon in beacons) {
        NSLog(@"beacons:%@", beacon);
        TDBeacon *tdBeacon = _beaconsDic[beacon.major];
        if (tdBeacon) {
            if ([beacon.proximityUUID.UUIDString isEqualToString:SpecialUUID]) {
                // 解析温度和湿度
                UInt16 value = [beacon.minor intValue] & 0xffff;
                tdBeacon.humidity = value >> 8;
                tdBeacon.temperature = value & 0xff;
            } else {
                tdBeacon.beacon = beacon;
            }
        } else if (![beacon.proximityUUID.UUIDString isEqualToString:SpecialUUID]){
            tdBeacon = [[TDBeacon alloc] init];
            tdBeacon.beacon = beacon;
            if (!_beaconsDic) {
                _beaconsDic = [NSMutableDictionary dictionary];
            }
            [_beaconsDic setObject:tdBeacon forKey:beacon.major];
        }
    }
    
    if (_delegate &&
        [_delegate respondsToSelector:@selector(deviceManage:didRangeBeacons:)]) {
        [_delegate deviceManage:self didRangeBeacons:_beaconsDic.allValues];
    }
}

@end
