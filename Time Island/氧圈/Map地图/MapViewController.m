//
//  MapViewController.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapLocationKit/AMapLocationKit.h>
@interface MapViewController ()<MAMapViewDelegate>

@property (nonatomic , strong)MAMapView *mapView;

@end

@implementation MapViewController

-(MAMapView *)mapView
{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        ///把地图添加至view
        _mapView.delegate = self;
        [_mapView setZoomLevel:14 animated:YES];
        _mapView.rotateCameraEnabled= YES;
        // 开启蓝点定位
        _mapView.showsUserLocation = YES;
        _mapView.rotateCameraEnabled= YES;
        _mapView.showsIndoorMap = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        _mapView.rotateCameraEnabled= NO;
        //        _mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 70);
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AMapServices sharedServices].apiKey =@"68a3888c4c6fb620c9ff44a0ce617326";
    self.title = @"地图";
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
