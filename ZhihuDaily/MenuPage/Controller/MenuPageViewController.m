//
//  MenuPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/25.
//

#import "MenuPageViewController.h"

@interface MenuPageViewController ()

@end

@implementation MenuPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topToolBar];
    [self.view addSubview:self.userAvatar];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.copyright];
    [self.topToolBar addSubview:self.backBtn];
}

#pragma mark - Lazy

- (UIImageView *)backBtn{
    if(_backBtn == nil){
        _backBtn = [[UIImageView alloc] initWithFrame:CGRectMake(30, 15, 35, 35)];
        UIImage *backBtnImage = [UIImage imageNamed:@"Back"];
        _backBtn.image = backBtnImage;
        _backBtn.layer.masksToBounds = YES;
        _backBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popPage)];
        [_backBtn addGestureRecognizer:backTap];
    }
    return _backBtn;
}


- (UIView *)topToolBar{
    if(_topToolBar == nil){
        _topToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 50)];
        _topToolBar.backgroundColor = [UIColor whiteColor];
    }
    return _topToolBar;
}

- (UIImageView *)userAvatar{
    if(_userAvatar == nil){
        _userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width/2)-40, 100, 80, 80 )];
        _userAvatar.backgroundColor = [UIColor whiteColor];
        _userAvatar.image = [UIImage imageNamed:@"Default_Avatar"];
        _userAvatar.contentMode = UIViewContentModeScaleAspectFit;
        _userAvatar.layer.cornerRadius = 40;
        _userAvatar.layer.masksToBounds = YES;
    }
    return _userAvatar;
}

- (UILabel *)userName{
    if(_userName == nil){
        _userName = [[UILabel alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width/2)-50, 200, 100, 20)];
        _userName.backgroundColor = [UIColor whiteColor];
        _userName.text = @"DemoUser";
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.numberOfLines = 1;
        _userName.font = [UIFont systemFontOfSize:16];
        _userAvatar.layer.masksToBounds = YES;
    }
    return _userName;
}

- (UILabel *)copyright{
    if(_copyright == nil){
        _copyright = [[UILabel alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height-30, UIScreen.mainScreen.bounds.size.width, 10)];
        _copyright.backgroundColor = [UIColor whiteColor];
        _copyright.text = @"ZhihuDaily Duplicated By Holeon.";
        _copyright.textColor = [UIColor lightGrayColor];
        _copyright.font = [UIFont systemFontOfSize:10];
        _copyright.textAlignment = NSTextAlignmentCenter;
        _copyright.numberOfLines = 1;
        _copyright.layer.masksToBounds = YES;
    }
    return _copyright;
}

#pragma mark - BarItemActions

- (void)popPage{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
