//
//  JudgeViewController.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "JudgeViewController.h"
#import "HDragItemListView.h"
#import "UIView+Ex.h"
#define kSingleLineHeight 36
#define kMaxLines  6
@interface JudgeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HDragItemListView *itemList;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, assign) CGFloat lastTextViewHeight;
@end

@implementation JudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HDragItem *item = [[HDragItem alloc] init];
    item.backgroundColor = [UIColor clearColor];
    item.image = [UIImage imageNamed:@"上传图片"];
    item.isAdd = YES;
    
    // 创建标签列表
    HDragItemListView *itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.itemList = itemList;
    itemList.backgroundColor = [UIColor clearColor];
    // 高度可以设置为0，会自动跟随标题计算
    // 设置排序时，缩放比例
    itemList.scaleItemInSort = 0.8;
    // 需要排序
    itemList.isSort = YES;
    itemList.isFitItemListH = YES;
    
    [itemList addItem:item];
    
    __weak typeof(self) weakSelf = self;
    
    [itemList setClickItemBlock:^(HDragItem *item) {
        if (item.isAdd) {
            NSLog(@"添加");
            [weakSelf showUIImagePickerController];
        }
    }];
    
    /**
     * 移除tag 高度变化，得重设
     */
    itemList.deleteItemBlock = ^(HDragItem *item) {
        HDragItem *lastItem = [weakSelf.itemList.itemArray lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!lastItem.isAdd) {
                HDragItem *item = [[HDragItem alloc] init];
                item.backgroundColor = [UIColor clearColor];
                item.image = [UIImage imageNamed:@"上传图片"];
                item.isAdd = YES;
                [weakSelf.itemList addItem:item];
            }
            [weakSelf updateHeaderViewHeight];
        });
    };
    
    [self.view addSubview:itemList];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, itemList.frame.size.height)];
    
    [headerView addSubview:itemList];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kSingleLineHeight)];
    _textView.textColor = kTextColor2;
    _textView.font = [UIFont systemFontOfSize:13];
    _textView.text = @"   发表评价";
    [headerView addSubview:_textView];
    
    itemList.y = _textView.height + 20;
    headerView.height = itemList.height + itemList.y;
    
    _tableView.tableHeaderView = headerView;
    _tableView.tableFooterView = [UIView new];
    
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChange:) name:UITextViewTextDidChangeNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeBegin:) name:UITextViewTextDidBeginEditingNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeBegin:) name:UITextViewTextDidBeginEditingNotification object:nil];
}

//更新头部高度
- (void)updateHeaderViewHeight{
    self.itemList.y = _textView.height + 20;
    self.tableView.tableHeaderView.height = self.itemList.itemListH + self.itemList.y;
    [self.tableView beginUpdates]; //加上这对代码，改header的时候，会有动画，不然比较僵硬
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    [self.tableView endUpdates];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, kScreenWidth, 50);
    view.backgroundColor =  kWhiteColor;
    UIView *backView = [UIView new];
    backView.backgroundColor = kLineColor;
    backView.frame = CGRectMake(0, 0, kScreenWidth, 10);
    [view addSubview:backView];
    return view;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];

    if (indexPath.row == 0) {
        UIButton *btn = [UIButton buttonWithTitle:@"提交" titleColor:kWhiteColor backgroundColor:kSJDMainTextColor titleFont:15];
        btn.layer.cornerRadius = 4;
        btn.clipsToBounds = YES;
        btn.frame = CGRectMake(15, 0, kScreenWidth-30, kHeight(49));
        [cell addSubview:btn];
        [btn addTarget:self action:@selector(sumbitMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)sumbitMessage
{
    NSLog(@"点击提交");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeight(49);
}


- (void)textViewChangeBegin:(NSNotificationCenter *)notifi{
    NSLog(@"%@",_textView.text);
    if ([_textView.text containsString:@"发表评价"]) {
        _textView.text = @"";
    }
  
}
#pragma mark - textView
- (void)textViewChange:(NSNotificationCenter *)notifi{
    
    if (_textView.text == nil || [_textView.text isEqualToString:@""]) {
        _textView.text = @"    发表评价";
    }
    CGSize size = [_textView sizeThatFits:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)];
    CGFloat height = size.height;
    BOOL scrollEnabled = NO;
    if (height > kSingleLineHeight * kMaxLines) {
        height = kSingleLineHeight * kMaxLines;
        scrollEnabled = YES;
    }
    _textView.scrollEnabled = scrollEnabled;
    _textView.height = height;
    
    if (_lastTextViewHeight != height && _lastTextViewHeight > 0) { //换行
        [self updateHeaderViewHeight];
    }
    
    _lastTextViewHeight = height;
}

#pragma mark - UIImagePickerController
- (void)showUIImagePickerController{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        HDragItem *item = [[HDragItem alloc] init];
        item.image = image;
        item.backgroundColor = [UIColor purpleColor];
        [self.itemList addItem:item];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateHeaderViewHeight];
        });
    }];
}


@end
