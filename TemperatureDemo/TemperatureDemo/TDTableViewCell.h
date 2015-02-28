//
//  TDTableViewCell.h
//  TemperatureDemo
//
//  Created by liaojinhua on 15/2/28.
//  Copyright (c) 2015年 April Brother. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;

@end
