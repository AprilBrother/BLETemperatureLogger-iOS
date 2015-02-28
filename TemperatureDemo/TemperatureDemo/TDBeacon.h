//
//  TDBeacon.h
//  TemperatureDemo
//
//  Created by liaojinhua on 15/2/27.
//  Copyright (c) 2015年 April Brother. All rights reserved.
//

#import "ABBeacon.h"

@interface TDBeacon : NSObject

@property (nonatomic, strong) ABBeacon *beacon;

@property (nonatomic) NSInteger temperature;
@property (nonatomic) NSInteger humidity;

@end
