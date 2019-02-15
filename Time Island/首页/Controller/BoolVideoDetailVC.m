//
//  BoolVideoDetailVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BoolVideoDetailVC.h"
#import "BookDetailHeadView.h"
#import "BookDetailContentView.h"
#import "BookImageCell.h"
#import "BookContentCell.h"
@interface BoolVideoDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * FootView;
}
@property (nonatomic , strong) BookDetailHeadView *headView;
@property (nonatomic,strong) BookDetailContentView * ContentView;
@property (nonatomic,strong) UITableView * TableView;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UIButton * CollectBtn;
@property (nonatomic,strong) UIButton * ZanBtn;
@property (nonatomic,strong) NSArray * imagearr;
@property (nonatomic,assign) float height;

@property (nonatomic,strong) UILabel * text;

@end

@implementation BoolVideoDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [self check];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagearr = [self.BookModel.photo componentsSeparatedByString:@"||"];
    
    self.ContentView = [[BookDetailContentView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 150 - 64 - 50)];
    self.ContentView.state = self.state;
    self.ContentView.BookModel = self.BookModel;
    [self.view addSubview:self.ContentView];
    
    [self CreateHeadView];
    [self CreateFootView];
    
   self.height = [self heightForString:self.BookModel.content andWidth:SCREEN_WIDTH - 30];
    
    self.TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableHeaderView = self.headView;
    self.TableView.tableFooterView = FootView;
    
    [self.TableView registerClass:[BookImageCell class] forCellReuseIdentifier:@"BookImageCell"];
    [self.TableView registerClass:[BookContentCell class] forCellReuseIdentifier:@"BookContentCell"];
    
    [self.view addSubview:self.TableView];
}

-(void)CreateHeadView{
    self.headView = [[BookDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    self.headView.state = self.state;
    self.headView.BookModel = self.BookModel;
//    [self.view addSubview:self.headView];
}
-(void)CreateFootView{
    [self CreateViewWithFrame:CGRectMake(15, self.ContentView.yy - 1, SCREEN_WIDTH - 30, 1)];
    FootView = [[UIView alloc]initWithFrame:CGRectMake(0, self.ContentView.yy, SCREEN_WIDTH, 50)];
    UIButton * CollectBtn = [UIButton buttonWithTitle:@"" titleColor:kTextColor3 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
    if ([self.state isEqualToString:@"collect"]) {
        [CollectBtn setTitle: [NSString stringWithFormat:@"%@",self.BookModel.article[@"collectCount"]] forState:UIControlStateNormal];
    }
    else{
        [CollectBtn setTitle: self.BookModel.collectCount forState:UIControlStateNormal];
    }
    
    CollectBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 50);
    [CollectBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:4 imagePositionBlock:^(UIButton *button) {
        [button setImage: kImage(@"收藏（未点击）") forState:UIControlStateNormal];
        [button setImage:kImage(@"收藏（点击）") forState:UIControlStateSelected];
    }];
    [CollectBtn addTarget:self action:@selector(CollectBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [FootView addSubview:CollectBtn];
    self.CollectBtn = CollectBtn;
    
    
    [self CreateViewWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 1, self.ContentView.yy + 15, 1, 20)];
    
    UIButton * ZanBtn = [UIButton buttonWithTitle:@"" titleColor:kTextColor3 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
    
    if ([self.state isEqualToString:@"collect"]) {
        [ZanBtn setTitle: [NSString stringWithFormat:@"%@",self.BookModel.article[@"pointCount"]] forState:UIControlStateNormal];
    }else{
        [ZanBtn setTitle: self.BookModel.pointCount forState:UIControlStateNormal];
    }
    ZanBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + 1, 0, SCREEN_WIDTH / 2, 50);
    [ZanBtn SG_imagePositionStyle:SGImagePositionStyleDefault spacing:4 imagePositionBlock:^(UIButton *button) {
        [button setImage: kImage(@"点赞（未点击）") forState:UIControlStateNormal];
        [button setImage:kImage(@"点赞（点击）") forState:UIControlStateSelected];
    }];
    [ZanBtn addTarget:self action:@selector(ZanBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [FootView addSubview:ZanBtn];
    self.ZanBtn = ZanBtn;
    
//    [self.view addSubview:view];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return self.imagearr.count * 200;
    }
    return self.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BookContentCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"BookContentCell" forIndexPath:indexPath];
        cell.BookModel = self.BookModel;
        cell.selectionStyle = UIAccessibilityTraitNone;
        
        
//        cell.cellheight = ^(float height) {
//            self.height = height;
//            [self.TableView reloadData];
//        };
        return cell;
    }
    
    BookImageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BookImageCell" forIndexPath:indexPath];
    cell.BookModel = self.BookModel;
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
    
}
/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */

- (float) heightForString:(NSString *)value andWidth:(float)width{
    //根据label文字获取CGRect
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //set the line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont systemFontOfSize:15],
                              NSFontAttributeName,
                              paragraphStyle,
                              NSParagraphStyleAttributeName,
                              nil];
    
    
    //assume your maximumSize contains {250, MAXFLOAT}
    CGRect lblRect = [value boundingRectWithSize:(CGSize){SCREEN_WIDTH - 30, MAXFLOAT}
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:attrDict
                                              context:nil];
    return lblRect.size.height + 15;
}


-(void)CollectBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629811";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"code"] = self.BookModel.code;
    self.count = [self.BookModel.collectCount integerValue];
    [http postWithSuccess:^(id responseObject) {
        
        if (sender.selected == YES) {
            self.count = self.count + 1;
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }else
        {
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }
        
    } failure:^(NSError *error) {
    }];
}
-(void)ZanBtnClick:(UIButton * )sender{
    sender.selected = !sender.selected;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629810";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"code"] = self.BookModel.code;
    self.count = [self.BookModel.collectCount integerValue];
    [http postWithSuccess:^(id responseObject) {
        
        if (sender.selected == YES) {
            self.count = self.count + 1;
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }else
        {
            [sender setTitle: [NSString stringWithFormat:@"%d",(int)self.count] forState:(UIControlStateNormal)];
        }
        
    } failure:^(NSError *error) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)CreateViewWithFrame:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    [self.view addSubview:view];
}
-(void)check{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629348";
    http.parameters[@"userId"] = [TLUser user].userId;
    
    if ([self.state isEqualToString:@"collect"]) {
        http.parameters[@"code"] = self.BookModel.article[@"code"];
    }
    else{
        http.parameters[@"code"] = self.BookModel.code;
    }
    http.parameters[@"type"] = @(1);
    [http postWithSuccess:^(id responseObject) {
        if ([responseObject[@"data"][@"isPointCollect"] isEqualToString:@"1"]) {
            self.ZanBtn.selected = YES;
        }
    } failure:^(NSError *error) {
    }];
    
//    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629348";
    http.parameters[@"userId"] = [TLUser user].userId;
//    http.parameters[@"code"] = self.BookModel.code;
    if ([self.state isEqualToString:@"collect"]) {
        http.parameters[@"code"] = self.BookModel.article[@"code"];
    }
    else{
        http.parameters[@"code"] = self.BookModel.code;
    }
    http.parameters[@"type"] = @(2);
    [http postWithSuccess:^(id responseObject) {
        if ([responseObject[@"data"][@"isPointCollect"] isEqualToString:@"1"]) {
            self.CollectBtn.selected = YES;
        }
    } failure:^(NSError *error) {
    }];
    
}
@end
