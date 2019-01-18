//
//  MallHomeHeadView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/18.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallHomeHeadView.h"
@interface MallHomeHeadView()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIImageView * image;
@end
@implementation MallHomeHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupImage];
        [self initSearchBar];
        [self SetupClassify];
    }
    return self;
}
-(void)setupImage{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 185)];
    image.image = kImage(@"邮政银行");
    [self addSubview:image];
    self.image = image;
}
-(void)SetupClassify{
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.yy, SCREEN_WIDTH, 115)];
//    [self addSubview:view];
//    self.ClassifyView = view;
    NSArray * ClassifyName = @[@"分类一",@"分类二",@"分类三",@"分类四",@"分类五"];
    CGFloat marge = (SCREEN_WIDTH - 45 * 5) / 6;
    
    [ClassifyName enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * btn = [UIButton buttonWithTitle:@"" titleColor:kTextColor backgroundColor:kClearColor titleFont:12];
        [btn setTitleColor:kTextColor forState:UIControlStateNormal];
        [btn setBackgroundImage:kImage(ClassifyName[idx]) forState:normal];
        [btn setTitleColor:kAppCustomMainColor forState:UIControlStateNormal];
        btn.frame = CGRectMake(idx*marge+marge+idx*45, self.image.yy + 22, 45, 45);
        [self addSubview:btn];
        
        UILabel * title = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(0, 0, 0) font:12];
        title.frame = CGRectMake(btn.xx, btn.yy + 10, 45, 16.5);
        title.centerX = btn.centerX;
        title.text = ClassifyName[idx];
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        btn.tag = idx + 100;
        [btn addTarget:self action:@selector(ClassifyClick : ) forControlEvents:UIControlEventTouchUpInside];

    }];
}
- (void)initSearchBar {
    UISearchBar * searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(14.5, 12, kScreenWidth-30, 31.0f)];
    searchbar.layer.cornerRadius = 15.5;
    searchbar.clipsToBounds = YES;
    searchbar.delegate = self;
    [searchbar setAccessibilityElementsHidden:YES];
    searchbar.alpha = 0.89;
    [searchbar setBackgroundColor:kWhiteColor];
    [searchbar setTintColor:[UIColor lightGrayColor]];
    [searchbar setPlaceholder:@"搜索商品"];
    [self.image addSubview:searchbar];
    self.searchBar = searchbar;
    
    UITextField *searchField = [searchbar valueForKey:@"searchField"];
    
    if (searchField) {
        [[[[searchbar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
        
        searchbar.backgroundColor = kWhiteColor;
        
        
        [searchField setBackgroundColor:[UIColor whiteColor]];
        [searchField setValue:[UIFont systemFontOfSize:11] forKeyPath:@"_placeholderLabel.font"];
        
        searchField.layer.cornerRadius = 15.5;//设置圆角具体根据实际情况来设置
        searchField.font =FONT(11);
        
        searchField.clipsToBounds = YES;
    }
}


-(void)ClassifyClick : (UIButton * )btn{
    NSLog(@"%d",(int)btn.tag);
}
@end
