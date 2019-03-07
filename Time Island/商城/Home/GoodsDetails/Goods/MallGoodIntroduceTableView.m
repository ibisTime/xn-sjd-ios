//
//  MallGoodIntroduceTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallGoodIntroduceTableView.h"

#import "MallGoodsInformationCell.h"
#define MallGoodsInformation @"MallGoodsInformationCell"
#import "TeamPostCell.h"
@interface MallGoodIntroduceTableView()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>
{
    TeamPostCell *_cell;
    NSInteger tag;
}

@end

@implementation MallGoodIntroduceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MallGoodsInformationCell class] forCellReuseIdentifier:MallGoodsInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.evaluationModel.count > 0) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 2) {
        return self.evaluationModel.count;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MallGoodsInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:MallGoodsInformation forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.treeModel = self.treeModel;
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"规格：选择规格分类";
        cell.textLabel.font = FONT(13);
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    // 通过唯一标识创建cell实例
    _cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!_cell) {
        _cell = [[TeamPostCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell.evaModel = self.evaluationModel[indexPath.row];
        _cell.informationLabel.delegate = self;
        NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                           "<head> \n"
                           "<style type=\"text/css\"> \n"
                           "body {font-size:%dpx;}\n"// 字体大小，px是像素
                           "</style> \n"
                           "</head> \n"
                           "<body>"
                           "<script type='text/javascript'>"
                           "window.onload = function(){\n"
                           "var $img = document.getElementsByTagName('img');\n"
                           "for(var p in  $img){\n"
                           "$img[p].style.width = '100%%';\n"// 图片宽度
                           "$img[p].style.height ='300px'\n"// 高度自适应
                           "}\n"
                           "}"
                           "</script>%@"
                           "</body>"
                           "</html>",15, self.evaluationModel[indexPath.row].content];
        [_cell.informationLabel loadHTMLString:htmls baseURL:nil];
        [_cell.informationLabel.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//    }
    
    return _cell;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        _webViewHeight1 = [[_cell.informationLabel stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        _cell.informationLabel.frame = CGRectMake(15, 53, SCREEN_WIDTH - 30, _webViewHeight1);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 135;
    }
    if (indexPath.section == 1) {
        return 55;
    }
    
    if ([self.evaluationModel[indexPath.row].content containsString:@"<img"]) {
        return 60 + 350;
    }
    return 60 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 46;
    }
    return 0.1;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 36)];
        backView.backgroundColor = kWhiteColor;
        [headView addSubview:backView];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, 50, 21) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        nameLbl.text = @"评价";
        [backView addSubview:nameLbl];
        
        UIButton *allBtn = [UIButton buttonWithTitle:@"查看全部" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:13];
        allBtn.frame = CGRectMake(SCREEN_WIDTH - 120, 15, 105, 21);
        allBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [allBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:3 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"积分更多") forState:(UIControlStateNormal)];
        }];
        [allBtn addTarget:self action:@selector(selectmore) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:allBtn];

        return headView;
    }
    return [UIView new];
}
-(void)selectmore{
    if (self.more) {
        self.more();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
-(void)dealloc{
    [_cell.informationLabel.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    
}
@end
