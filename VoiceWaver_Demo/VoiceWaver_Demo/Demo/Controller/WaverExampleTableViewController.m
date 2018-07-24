//
//  WaverExampleTableViewController.m
//  VoiceWaver_Demo
//
//  Created by MrYeL on 2018/7/20.
//  Copyright © 2018年 MrYeL. All rights reserved.
//

#import "WaverExampleTableViewController.h"

#import "VolumeWaverView.h"
#import <AVFoundation/AVFoundation.h>

#import "RecordManager.h"

@interface WaverExampleTableViewController ()

/** 音频视图*/
@property (nonatomic, strong) VolumeWaverView * volume;

/** 录音工具*/
@property (nonatomic, strong) RecordManager *recordTool;

/** 数据Array*/
@property (nonatomic, copy) NSArray * dataArray;

/** timeLabel*/
@property (nonatomic, strong) UILabel * timeLabel;


@end


@implementation WaverExampleTableViewController

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 20)];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel = timeLabel;
    }
    return _timeLabel;
 
}

- (RecordManager *)recordTool {
    
    if (_recordTool == nil) {
        _recordTool = [RecordManager sharedRecordTool];
        //配置
        _recordTool.soundMeterCount = Xcount;
        _recordTool.updateFequency = 0.25/Xcount;
        _recordTool.maxSecond = 60;
        
        __weak typeof(self) weakSelf = self;

        _recordTool.returnTime = ^(NSTimer *timer,int second) {

          weakSelf.timeLabel.text =  [NSString stringWithFormat:@"00:00:%2d", second];
        };

    }
    return _recordTool;
}

- (VolumeWaverView *)volume {
    
    if (_volume == nil) {
        _volume = [[VolumeWaverView alloc] initWithFrame:CGRectMake(10, 70, 355, 150) andType:VolumeWaverType_Bar];
    }
    return _volume;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"波形图";
    self.dataArray = @[@"启用",@"暂停",@"取消"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    self.tableView.tableHeaderView = [self headerView];
    [self.tableView addSubview:self.volume];
    
    
}
- (UIView *)headerView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 150+ 70)];
    contentView.backgroundColor = [UIColor whiteColor];

    [contentView addSubview:self.timeLabel];
//    [contentView addSubview:self.volume];
    return contentView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self start];
            break;
        case 1:
            [self pause];
            break;
        case 2:
            [self cancle];
            break;
        default:
            break;
    }
    
}
#pragma mark - Action
- (void)start {

    [self.recordTool startRecord];
    
}
- (void)pause {
    

    [self.recordTool pauseRecord];
    
}
- (void)cancle {
    
    [self.recordTool pauseRecord];
    
}



@end
