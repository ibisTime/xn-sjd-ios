//
//  MyNoticeCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/15.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNoticeCell : UITableViewCell
@property (nonatomic,strong) NSString * titleString;
@property (nonatomic,strong) NSString * TimeString;
@property (nonatomic,strong) NSString * ContentString;
@property (nonatomic,strong) UILabel * nameLbl;
@property (nonatomic,strong) UILabel * timeLbl;
@property (nonatomic,strong) UILabel * contactLbl;
@end
