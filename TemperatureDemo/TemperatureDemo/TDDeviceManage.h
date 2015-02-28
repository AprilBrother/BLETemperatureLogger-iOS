//
//  TDDeviceManage.h
//  TemperatureDemo
//
//  Created by liaojinhua on 15/2/27.
//  Copyright (c) 2015年 April Brother. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AprilSDK/AprilBeaconSDK.h>

@class TDDeviceManage;

@protocol TDDeviceMangeDelegate <NSObject>

@required
- (void)deviceManage:(TDDeviceManage *)deviceManage
     didRangeBeacons:(NSArray *)beacons;

@end

@interface TDDeviceManage : NSObject

@property (nonatomic, weak) id<TDDeviceMangeDelegate> delegate;


- (void)startRangeUUID:(NSString *)uuidString;

- (void)stopRangeUUID:(NSString *)uuidString;

@end
