//
//  InfoVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "InfoVC.h"
#import "TLUploadManager.h"
#import "GenderPickerView.h"

@interface InfoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) TLTextField * name;
@property (nonatomic,strong) TLTextField * gender;
@property (nonatomic,strong) TLTextField * age;
@property (nonatomic,strong) TLTextField * more;
@property (nonatomic,assign) NSInteger genderindex;

@end

@implementation InfoVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self RefreshInfo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.titleLabel.font = FONT(16);
    self.RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-57.5, 30, 42.5, 45)];
    [self.RightButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self setup];
}
-(void)setup{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-22.5, 37.5, 55, 55)
                           ];
    image.image = kImage(@"头像");
    image.layer.cornerRadius = 27.5;
    image.layer.masksToBounds = YES;
//    [self.view addSubview:image];
    [view addSubview:image];
    self.image = image;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seleckImage)];
    [self.image addGestureRecognizer:tapGesture];
    self.image.userInteractionEnabled = YES;
    
    
    UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(image.x + 38, image.y + 38, 17, 17)
                           ];
    image1.image = kImage(@"更改头像");
    [view addSubview:image1];
    [self.view addSubview:view];

    [self.view addSubview:[self createview:CGRectMake(0, view.yy - 1, SCREEN_WIDTH, 1)]];
    
    TLTextField * name = [[TLTextField alloc]initWithFrame:CGRectMake(15,view.yy, SCREEN_WIDTH-30, 55) leftTitle:@"昵称" placeholder:@"请输入昵称"];
    [self.view addSubview:name];
    self.name = name;
    [self.view addSubview:[self createview:CGRectMake(15, name.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    TLTextField * gender = [[TLTextField alloc]initWithFrame:CGRectMake(15, name.yy, SCREEN_WIDTH-30, 55) leftTitle:@"性别" placeholder:@"请选择"];
    [self.view addSubview:gender];
    self.gender = gender;
    self.gender.delegate = self;
    [self.view addSubview:[self createview:CGRectMake(15, gender.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    
    TLTextField * age = [[TLTextField alloc]initWithFrame:CGRectMake(15, gender.yy, SCREEN_WIDTH-30, 55) leftTitle:@"年龄" placeholder:@"请选择"];
    [self.view addSubview:age];
    self.age = age;
    [self.view addSubview:[self createview:CGRectMake(15, age.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
    
    
    TLTextField * more = [[TLTextField alloc]initWithFrame:CGRectMake(15, age.yy, SCREEN_WIDTH-30, 100) placeholder:@"请输入个人简介（最多输入20个字符）"];
    [self.view addSubview:more];
//    more.delegate = self;
    self.more = more;
    
    [self.view addSubview:[self createview:CGRectMake(15, more.yy - 1, SCREEN_WIDTH - 30, 1)]];
    
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    if (textField.text.length > 20) {
//        [TLAlert alertWithMsg:@"最多输入20个字符，请重新输入"];
//    }
//}
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
-(void)myRecodeClick{
    if (self.more.text.length > 20) {
        [TLAlert alertWithMsg:@"个人简介最多输入20个字符，请重新输入"];
    }
    else{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805070";
        http.parameters[@"idNo"] = [TLUser user].idNo;
        http.parameters[@"realName"] = [TLUser user].realName;
        http.parameters[@"userId"] = [TLUser user].userId;
        if ([self.gender.text  isEqual: @"男"]) {
            http.parameters[@"gender"] = @"1";
        }else{
            http.parameters[@"gender"] = @"0";
        }
        http.parameters[@"nickname"] = self.name.text;
        http.parameters[@"age"] = self.age.text;
        http.parameters[@"introduce"] = self.more.text;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"修改成功！"];
            [[TLUser user]updateUserInfo];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
        }];
    }
    
    
}




-(void)seleckImage{
    
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
//        [self changeHeadIconWithKey:key imgData:imgData];
        TLNetworking *http = [TLNetworking new];
        http.code = @"805080";
        http.parameters[@"photo"] = key;
        http.parameters[@"userId"] = [TLUser user].userId;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:[LangSwitcher switchLang:@"设置成功" key:nil]];
            [[TLUser user] updateUserInfo];
            self.image.image = image;
//            [picker dismissModalViewControllerAnimated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
//            [picker popViewControllerAnimated:YES];
            [picker dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            [TLAlert alertWithError:@"设置失败"];
        }];
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [picker dismissModalViewControllerAnimated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
//    [picker popViewControllerAnimated:YES];
}

//刷新信息
-(void)RefreshInfo{
    if ([TLUser user].photo) {
        [self.image sd_setImageWithURL: [NSURL URLWithString:[[TLUser user].photo convertImageUrl]]];
    }
    if ([TLUser user].nickname) {
        self.name.text = [TLUser user].nickname;
    }
    if ([TLUser user].gender) {
        self.gender.text = [TLUser user].gender ? @"男":@"女";
    }
    if ([TLUser user].age) {
        self.age.text = [TLUser user].age;
    }
    if ([TLUser user].introduce) {
        self.more.text = [TLUser user].introduce;
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [textField resignFirstResponder];
//
//    GenderPickerView * view = [[GenderPickerView alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT / 2 - 25, SCREEN_WIDTH - 30, 50)];
//    __weak typeof(self) weakSelf = self;
//    view.genderblock = ^(NSString * _Nonnull Gender) {
//        self.gender.text = Gender;
//    };
//    [self.view addSubview:view];
    
    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0;  i < 2; i ++) {
//        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",@"男",@"女"]]];
//    }
    [array addObject:[[SelectedListModel alloc] initWithSid:0 Title:[NSString stringWithFormat:@"%@",@"男"]]];
    [array addObject:[[SelectedListModel alloc] initWithSid:1 Title:[NSString stringWithFormat:@"%@",@"女"]]];
    
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            SelectedListModel *model = array[0];
            NSLog(@"选中第%ld行" , model.sid);
            self.genderindex = model.sid;
            self.gender.text = model.title;
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择性别")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
    
//    [self.view addSubview:view];
}
@end
