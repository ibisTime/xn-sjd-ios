//
//  MallHomeHeaderView.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallHomeHeaderView.h"
@interface MallHomeHeaderView()<UISearchBarDelegate>
@property (nonatomic, strong) UIImageView *headImage;//banner图

@property (nonatomic, strong) UISearchBar *searchBar;//搜索框

@end
@implementation MallHomeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        //轮播图
        [self initCustomView];
     
    }
    return self;
}
- (void)initCustomView
{
 
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.size.height-5)];
    [self addSubview:self.headImage];
    self.headImage.image = kImage(@"bannerSummer");
    
    UIView *line = [UIView new];
    line.backgroundColor = kBackgroundColor;
    [self addSubview:line];
    line.frame = CGRectMake(0, self.headImage.yy, kScreenWidth, 5);
    
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 12, kScreenWidth-30, 36)];
//    searchbar.layer.cornerRadius = 18;//设置圆角具体根据实际情况来设置
//    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    [searchbar setTintColor:kWhiteColor];
    [searchbar setPlaceholder:@"搜索商品"];
    [self addSubview:searchbar];
    self.searchBar = searchbar;
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
         [[[[searchbar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        [searchField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 18;
        searchField.clipsToBounds = YES;
        
    }
}
@end
