//
//  JudgeVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/6.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "JudgeVC.h"

@interface JudgeVC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic,strong) UIImageView * idPic;
@property (nonatomic,strong) NSString * key1;
@end

@implementation JudgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品评价";
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 325)];
    view.backgroundColor = kWhiteColor;
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 200)];
    _textView.textColor = kTextColor2;
    _textView.font = [UIFont systemFontOfSize:14];
    _textView.text = @"宝贝满足您的期待吗？说说您的使用心情，分享给想买他们的人吧！";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChangeBegin:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [view addSubview:_textView];
    
    UIImageView * idPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, _textView.yy + 25, 100, 100)];
    idPic.image = kImage(@"上传图片");
    idPic.tag = 1;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(seleckImage:)];
    ges.delegate = self;
    [idPic addGestureRecognizer:ges];
    idPic.userInteractionEnabled = YES;
    [view addSubview:idPic];
    self.idPic = idPic;
    
    [self.view addSubview:view];
    
    UIView * v1= [[UIView alloc]initWithFrame:CGRectMake(0, view.yy + 10, SCREEN_WIDTH, SCREEN_HEIGHT - view.yy - 10)];
    v1.backgroundColor = kWhiteColor;
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(15, 50, SCREEN_WIDTH - 30, 40) title:@"发表" backgroundColor:kTabbarColor];
    kViewRadius(button, 4);
    [button setTitle:@"发表" forState:(UIControlStateNormal)];
    [button setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(confirm) forControlEvents:(UIControlEventTouchUpInside)];
    [v1 addSubview:button];
    [self.view addSubview:v1];
}
-(void)confirm{
    NSString * string ;
    if (self.textView.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入评价内容！"];
        return;
    }
    else if (self.key1) {
        
        string = [NSString stringWithFormat:@"<p>%@</p><img src=\"%@?imageMogr2/auto-orient\" />",self.textView.text,[self.key1 convertImageUrl]];
    }else{
        if (self.idPic) {
            [TLAlert alertWithInfo:@"图片正在上传中···"];
            return;
        }
        string = [NSString stringWithFormat:@"<p>%@</p>",self.textView.text];
    }
    
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"629730";
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"content"] = string;
    http.parameters[@"code"] = self.code;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithInfo:@"评价成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)seleckImage:(UITapGestureRecognizer * )image{
    NSLog(@"%s",__func__);
    //这部分代码是用来打开相册的
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//是否允许编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.idPic.image = nil;
    self.idPic.image = image;
    TLUploadManager * manager = [TLUploadManager manager];
    manager.imgData = UIImageJPEGRepresentation(self.idPic.image, 1.0);
    manager.image = self.idPic.image;
    [manager getTokenShowView:self.idPic succes:^(NSString *token) {
            self.key1 = token;
    } failure:^(NSError *error) {
    
    }];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)textViewChangeBegin:(NSNotificationCenter *)notifi{
    NSLog(@"%@",_textView.text);
    if ([_textView.text containsString:@"宝贝满足您的期待吗？说说您的使用心情，分享给想买他们的人吧！"]) {
        _textView.text = @"";
    }
    
}
@end
