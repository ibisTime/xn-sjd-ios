//
//  PersonalCenterHeadView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/28.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "PersonalCenterHeadView.h"

@implementation PersonalCenterHeadView
{
    UIImageView *headView;
    UILabel *nameLbl;
    UILabel *LVLbl;
    UILabel *friendsLbl;
    UILabel *contentLbl;
    UIButton *btn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180 - 65 + kNavigationBarHeight)];
        topView.backgroundColor = kTabbarColor;
        [self addSubview:topView];
        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 30, 32 + kStatusBarHeight - 20, 60, 60)];
        
        [headView sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].photo convertImageUrl]] placeholderImage:kImage(@"头像")];
        kViewRadius(headView, 30);
        [self addSubview:headView];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, headView.yy + 10, SCREEN_WIDTH - 30, 18) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(18) textColor:kWhiteColor];
//        nameLbl.text = @"赤金炎人";
        if ([USERXX isBlankString:[TLUser user].nickname] == YES) {
            nameLbl.text = @"未设置昵称";
        }else
        {
            nameLbl.text = [TLUser user].nickname;
        }
        
        [self addSubview:nameLbl];
        
        LVLbl = [UILabel labelWithFrame:CGRectMake(10, nameLbl.yy + 7, SCREEN_WIDTH/2 - 20, 11) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(11) textColor:kWhiteColor];
        
        LVLbl.text = [NSString stringWithFormat:@"LV%@ 初探翠林",[TLUser user].level];
        
        [self addSubview:LVLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, nameLbl.yy + 7, 1, 11)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        friendsLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2 + 10, nameLbl.yy + 7, SCREEN_WIDTH/2 - 20, 11) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(11) textColor:kWhiteColor];
        
        friendsLbl.text =  [NSString stringWithFormat:@"好友: %@",[TLUser user].friendCount];
        [self addSubview:friendsLbl];
        
        btn = [UIButton buttonWithTitle:@"" titleColor:kWhiteColor backgroundColor:RGB(240, 171, 79) titleFont:12];
        btn.frame = CGRectMake(friendsLbl.xx + 5, nameLbl.yy + 7, 50, 11);
//        btn.isHidden = YES;
        [btn setHidden:YES];
        [btn addTarget:self action:@selector(AddFriend) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
        
        
        contentLbl = [UILabel labelWithFrame:CGRectMake(15, friendsLbl.yy + 10, SCREEN_WIDTH - 30, 11) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:FONT(11) textColor:kWhiteColor];
        if ([USERXX isBlankString:[TLUser user].introduce] == YES) {
            contentLbl.text = @"此人很懒，没留下什么";
        }else
        {
            contentLbl.text = [TLUser user].introduce;
        }
        
        
        [self addSubview:contentLbl];
        
        
        UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(15, topView.yy , 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(15) textColor:kTextBlack];
        titleLbl.text = @"认养的树";
        [self addSubview:titleLbl];
        

        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.yy + 39, SCREEN_WIDTH, 1)];
        bottomView.backgroundColor = kLineColor;
        [self addSubview:bottomView];
        
    }
    return self;
}

-(void)setFriendInfoModel:(FriendInfoModel *)FriendInfoModel{

    _FriendInfoModel = FriendInfoModel;
    [headView sd_setImageWithURL:[NSURL URLWithString:[FriendInfoModel.photo convertImageUrl]] placeholderImage:kImage(@"头像")];
    if ([USERXX isBlankString:FriendInfoModel.nickname] == YES) {
        nameLbl.text = @"未设置昵称";
    }else
    {
        nameLbl.text = FriendInfoModel.nickname;
    }
    
    LVLbl.text = [NSString stringWithFormat:@"LV%@ 初探翠林",FriendInfoModel.level];
    
    friendsLbl.text =  [NSString stringWithFormat:@"好友: %@",FriendInfoModel.friendCount];
    [friendsLbl sizeToFit];
    friendsLbl.frame = CGRectMake(SCREEN_WIDTH/2 + 10, nameLbl.yy + 7, friendsLbl.width, 11);
    
    btn.frame = CGRectMake(friendsLbl.xx + 5, nameLbl.yy + 5, 50, 15);
    if (![FriendInfoModel.userId isEqualToString:[TLUser user].userId]) {
        if ([self.state isEqualToString:@"rank"]) {
            [btn setTitle:@"申请好友" forState:(UIControlStateNormal)];
            [btn setHidden:NO];
        }
        else if ([self.state isEqualToString:@"friend"]){
            [btn setTitle:@"已是好友" forState:(UIControlStateNormal)];
            [btn setHidden:NO];
        }
    }
    
    
    if ([USERXX isBlankString:FriendInfoModel.introduce] == YES) {
        contentLbl.text = @"此人很懒，没留下什么";
    }else
    {
        contentLbl.text = FriendInfoModel.introduce;
    }

}
-(void)AddFriend{
    [self.delegate AddFriend:_FriendInfoModel.userId];
    
}
@end
