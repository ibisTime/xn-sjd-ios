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
//#import <AMapSearchKit/AMapSearchAPI.h>
#import "JZLocationConverter.h"//坐标转换

@import MapKit;//ios7 使用苹果自带的框架使用@import导入则不用在Build Phases 导入框架了
@import CoreLocation;
@interface MapViewController ()<MAMapViewDelegate>

@property (nonatomic , strong)MAMapView *mapView;
//@property (nonatomic , strong)AMapSearchAPI *search;
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
    

    CLLocationCoordinate2D coor ;
    coor.latitude = self.latitude;
    coor.longitude = self.longitude;
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = coor;//设置地图的定位中心点坐标
    self.mapView.centerCoordinate = coor;//将点添加到地图上，即所谓的大头针
    [self.mapView addAnnotation:pointAnnotation];
    

  
//
    [self CreateSquareLatitude:self.latitude AndLongitude:self.longitude];
}

- (void)CreateSquareLatitude:(CLLocationDegrees)latitude AndLongitude:(CLLocationDegrees)longitude
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(latitude, longitude) animated:YES];
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            
            
        }else{
                
        
        }
    }];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id)annotation {
    //大头针标注
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        //判断是否是自己的定位气泡，如果是自己的定位气泡，不做任何设置，显示为蓝点，如果不是自己的定位气泡，比如大头针就会进入
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            
        }
        annotationView.highlighted = YES;
        annotationView.canShowCallout= YES;
        //设置气泡可以弹出，默认为NO//
//        annotationView.animatesDrop = YES;
        //设置标注动画显示，默认为
        annotationView.draggable = YES;
        //设置标注可以拖动，默认为NO//        annotationView.pinColor = MAPinAnnotationColorPurple;//设置大头针显示的图片
        annotationView.image = [UIImage imageNamed:@"定位"];
        //点击大头针显示的左边的视图
        
//        MACustomCalloutView *leftView
        
        MACustomCalloutView *customView = [[MACustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, 200, 51 + 20)];
        customView.backgroundColor = kClearColor;
        
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 175, 51)];
        leftView.backgroundColor = kHexColor(@"#000000");
        leftView.alpha = 0.7;
        kViewRadius(leftView, 4);
        [customView addSubview:leftView];
        
        self.nameLabel = [UILabel labelWithFrame:CGRectMake(10, 9, 100, 16) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(16) textColor:kWhiteColor];
//        self.nameLabel.text = @"爱情林";
        self.nameLabel.text = self.namestr;
        [self.nameLabel sizeToFit];
        self.nameLabel.frame = CGRectMake(10, 9, self.nameLabel.width, 16);
        [leftView addSubview:self.nameLabel];
        
        self.codeLabel = [UILabel labelWithFrame:CGRectMake(10, self.nameLabel.yy + 5, 100, 12) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kWhiteColor];
//        self.codeLabel.text = @"爱情林12号林";
        self.codeLabel.text = self.address;
        [self.codeLabel sizeToFit];
        self.codeLabel.frame = CGRectMake(10, self.nameLabel.yy + 5, self.codeLabel.width, 12);
        [leftView addSubview:self.codeLabel];
        
        customView.frame = CGRectMake(0, 0, self.codeLabel.width + 70, 51 + 20);
        leftView.frame = CGRectMake(0, 0, self.codeLabel.width + 70, 51);

        
        UIButton *navigationBtn = [UIButton  buttonWithTitle:@"导航" titleColor:kWhiteColor backgroundColor:kHexColor(@"#23AD8C") titleFont:11];
        kViewRadius(navigationBtn, 3);
        navigationBtn.frame = CGRectMake(self.codeLabel.width + 70 - 60, 8.5, 50, 51 - 27+10);
        [navigationBtn SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"导航") forState:(UIControlStateNormal)];
        }];
        [navigationBtn addTarget:self action:@selector(navigationBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [customView addSubview:navigationBtn];
        
        
        annotationView.customCalloutView = customView;

        
        return annotationView;
        
    }
    return nil;
    
}

-(void)navigationBtnClick
{
    NSString *urlScheme = @"MapJump://";
    NSString *appName = @"MapJump";
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);//要导航的终点的经纬度
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //这个判断其实是不需要的
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            CLLocationCoordinate2D desCoordinate = coordinate;
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:desCoordinate addressDictionary:nil]];
            toLocation.name = @"终点";//可传入目标地点名称
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        CLLocationCoordinate2D desCoordinate = [JZLocationConverter gcj02ToBd09:coordinate];//火星坐标转化为百度坐标
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            //我的位置代表起点位置为当前位置，也可以输入其他位置作为起点位置，如天安门
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=driving&src=JumpMapDemo", desCoordinate.latitude, desCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        //coordinate = CLLocationCoordinate2DMake(40.057023, 116.307852);
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            CLLocationCoordinate2D desCoordinate = coordinate;
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=applicationName&sid=BGVIS1&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dev=0&m=0&t=0",@"我的位置",desCoordinate.latitude, desCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//@"我的位置"可替换为@"终点名称"
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            CLLocationCoordinate2D desCoordinate = coordinate;
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,desCoordinate.latitude, desCoordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]])    {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"腾讯地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            CLLocationCoordinate2D desCoordinate = coordinate;
            
            NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&from=我的位置&to=%@&tocoord=%f,%f&policy=1&referer=%@", @"终点名称", desCoordinate.latitude, desCoordinate.longitude, appName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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
