//
//  IssueBook.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/17.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "IssueBook.h"
#import "ConnectTreeModel.h"
@interface IssueBook ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIView * view1;
@property (nonatomic,strong) UIView * view2;
@property (nonatomic,strong) UITextField * textfield;
@property (nonatomic,strong) UITextView * textview;
@property (nonatomic,strong) TLTextField * textfield1;
@property (nonatomic,strong) TLTextField * textfield2;
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) NSMutableArray<ConnectTreeModel * > * ConnectTreeModels;
@property (nonatomic,strong) ConnectTreeModel * ConnectTreeModel;
@property (nonatomic,strong) NSMutableArray * ImageKey;
@property (nonatomic,assign) NSInteger openLevel;

@end

@implementation IssueBook

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布文章";
    self.ImageKey = [NSMutableArray array];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.titleLabel.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(saveBook) forControlEvents:(UIControlEventTouchUpInside)];
    

    [self setupview1];
    [self setupview2];
    
    UIButton * issuebtn = [[UIButton alloc]initWithFrame:CGRectMake(15, self.view2.yy + 81, SCREEN_WIDTH - 30, 42) title:@"发布" backgroundColor:kTabbarColor];
    [issuebtn addTarget:self action:@selector(IssueBook) forControlEvents:UIControlEventTouchUpInside];
    issuebtn.layer.cornerRadius = 4;
    issuebtn.layer.masksToBounds = YES;
    [self.view addSubview:issuebtn];
}

-(void)setupview1{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 301.5)];
    self.view1.backgroundColor = kWhiteColor;
    UITextField * textfield = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55)];
    textfield.placeholder = @"标题";
    textfield.font = FONT(15);
    [self.view1 addSubview:textfield];
    self.textfield = textfield;
    
    [self.view1 addSubview:[self createview:CGRectMake(15, textfield.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    UITextView * textview = [[UITextView alloc]initWithFrame:CGRectMake(15, textfield.yy + 2, SCREEN_WIDTH - 30, 156.5)];
    textview.font = FONT(13);
    textview.delegate = self;
    textview.text = @"发表下您的感想吧";
    textview.textColor = kHexColor(@"#999999");
    [self.view1 addSubview:textview];
    self.textview = textview;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(15, textfield.yy + 156.5, 80, 80)];
    image.image = kImage(@"上传图片");
    
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChooseImage)];
    ges1.delegate = self;
    [image addGestureRecognizer:ges1];
    
    [self.view1 addSubview:image];
    self.image = image;
    
    [self.view addSubview:self.view1];
}

-(void)setupview2{
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.view1.yy + 10, SCREEN_WIDTH, 110)];
    self.view2.backgroundColor = kWhiteColor;
    
    TLTextField *textfield1 = [[TLTextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55) placeholder:@"关联古树"];
    textfield1.enabled = NO;
    [self.view2 addSubview:textfield1];
    self.textfield1 = textfield1;
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 55)];
    [self.view2 addSubview:btn];
    [btn addTarget:self action:@selector(ChooseTree) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 24.5, 22.5, 9.65, 9.65)];
    image1.image = kImage(@"下拉");
    [textfield1 addSubview:image1];
    
    
    [self.view2 addSubview:[self createview:CGRectMake(15, textfield1.yy - 1, SCREEN_WIDTH - 30, 1)]];

    
    TLTextField * textfield2 = [[TLTextField alloc]initWithFrame:CGRectMake(15, textfield1.yy, SCREEN_WIDTH - 30, 55) placeholder:@"公开/私密/仅好友可见"];
    textfield2.enabled = NO;
    textfield2.tag = 2;
    textfield2.delegate = self;
    [self.view2 addSubview:textfield2];
    self.textfield2 = textfield2;
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, textfield1.yy, SCREEN_WIDTH - 30, 55)];
    [self.view2 addSubview:btn1];
    [btn1 addTarget:self action:@selector(ChooseState) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * image2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 24.5, 22.5, 9.65, 9.65)];
    image2.image = kImage(@"下拉");
    [textfield2 addSubview:image2];
    
    
//    [textfield2 addTarget:self action:@selector(ChooseState) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view2 addSubview:[self createview:CGRectMake(15, textfield2.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    
    
    [self.view addSubview:self.view2];
}


-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}


#pragma UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"发表下您的感想吧";
        textView.textColor = kHexColor(@"#999999");
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"发表下您的感想吧"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

#pragma 按钮点击
-(void)IssueBook{
    NSLog(@"%s",__func__);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629340";
    http.parameters[@"title"] = self.textfield.text;
    http.parameters[@"content"] = self.textview.text;
    http.parameters[@"photo"] = self.ImageKey[0];
    http.parameters[@"openLevel"] = [NSString stringWithFormat:@"%d",(int)self.openLevel + 1];
    http.parameters[@"adoptTreeCode"] = self.ConnectTreeModel.code;
    http.parameters[@"treeNo"] = self.ConnectTreeModel.tree[@"treeNumber"];
    http.parameters[@"updater"] = [TLUser user].userId;
    http.parameters[@"publishUserId"] = [TLUser user].userId;
    http.parameters[@"type"] = @"2";
    http.parameters[@"dealType"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        [TLAlert alertWithError:@"发布失败，请重新发布"];
    }];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveBook{
    NSLog(@"%s",__func__);
}

#pragma 手势
-(void)ChooseImage{
    NSLog(@"%s",__func__);
    //这部分代码是用来打开相册的
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//是否允许编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    TLUploadManager * manager = [TLUploadManager manager];
    manager.imgData = UIImageJPEGRepresentation(image, 1.0);;
    manager.image = image;
    [manager getTokenShowView:self.view succes:^(NSString *key) {
        [self.ImageKey addObject:key];
//        self.image.frame = CGRectMake(15 + 90 * self.ImageKey.count, self.textfield.yy + 156.5, 80, 80);
        [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
        self.image.image = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)ChooseTree{
    CoinWeakSelf
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629207";
    http.parameters[@"currentHolder"] = [TLUser user].userId;
    http.parameters[@"statusList"] = @[@1,@2,@3];
    [http postWithSuccess:^(id responseObject) {
        self.ConnectTreeModels = [ConnectTreeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0;  i < self.ConnectTreeModels.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@(%@)",self.ConnectTreeModels[i].tree[@"productName"],self.ConnectTreeModels[i].treeNumber]]];
        }
        
        
        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = array;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                SelectedListModel *model = array[0];
                weakSelf.textfield1.text = model.title;
                weakSelf.ConnectTreeModel = weakSelf.ConnectTreeModels[model.sid];
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"选择关联树木")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    } failure:^(NSError *error) {
    }];
    
    NSLog(@"%s",__func__);
}
-(void)ChooseState{
    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0;  i < self.ConnectTreeModels.count; i ++) {
//        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@(%@)",self.ConnectTreeModels[i].tree[@"productName"],self.ConnectTreeModels[i].treeNumber]]];
//    }
    NSArray * arr = @[@"公开",@"私密",@"仅好友可看"];
    for (int i = 0;  i < arr.count; i ++) {
    [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",arr[i]]]];
     }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            SelectedListModel *model = array[0];
            self.textfield2.text = model.title;
            self.openLevel = model.sid;
//            weakSelf.textfield1.text = model.title;
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"谁可以看")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}



@end
