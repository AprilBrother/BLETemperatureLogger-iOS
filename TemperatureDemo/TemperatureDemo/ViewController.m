//
//  ViewController.m
//  TemperatureDemo
//
//  Created by liaojinhua on 15/2/27.
//  Copyright (c) 2015年 April Brother. All rights reserved.
//

#import "ViewController.h"
#import "TDDeviceManage.h"
#import "TDTableViewCell.h"
#import "TDBeacon.h"

@interface ViewController () <TDDeviceMangeDelegate>

@property (nonatomic, strong) TDDeviceManage *deviceManage;
@property (nonatomic, strong) NSArray *beacons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.deviceManage = [[TDDeviceManage alloc] init];
    self.deviceManage.delegate = self;
    [self.deviceManage startRangeUUID:@"06742A69-4C2C-4359-BBFE-122D05B6DCBF"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deviceManage:(TDDeviceManage *)deviceManage
     didRangeBeacons:(NSArray *)beacons
{
    _beacons = beacons;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _beacons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TDTableViewCell"];
    TDBeacon *beacon = _beacons[indexPath.row];
    cell.uuidLabel.text = [NSString stringWithFormat:@"UUID:%@",beacon.beacon.proximityUUID.UUIDString];
    cell.majorLabel.text = [NSString stringWithFormat:@"Major:%@",beacon.beacon.major];
    cell.minorLabel.text = [NSString stringWithFormat:@"Minor:%@",beacon.beacon.minor];
    cell.tempLabel.text = [NSString stringWithFormat:@"%ld",(long)beacon.temperature];
    cell.humidityLabel.text = [NSString stringWithFormat:@"%ld",(long)beacon.humidity];
    return cell;
}

@end
