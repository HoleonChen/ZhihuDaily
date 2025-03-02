//
//  MenuPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/25.
//

#import "MenuPageViewController.h"
#include "StarPageViewcontroller.h"

@interface MenuPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MenuPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topToolBar];
    [self.view addSubview:self.userAvatar];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.menuTable];
    [self.view addSubview:self.copyright];
    [self.topToolBar addSubview:self.backBtn];
}

#pragma mark - Lazy

- (UIImageView *)backBtn{
    if(_backBtn == nil){
        _backBtn = [[UIImageView alloc] initWithFrame:CGRectMake(30, 15, 35, 35)];
        UIImage *backBtnImage = [UIImage imageNamed:@"famicons_chevron-back-outline.png"];
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
        _userAvatar.image = [UIImage imageNamed:@"DefaultAvatar.jpeg"];
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

- (UITableView *)menuTable{
    if(_menuTable == nil){
        _menuTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, UIScreen.mainScreen.bounds.size.width, 60)];
        _menuTable.backgroundColor = [UIColor whiteColor];
        _menuTable.delegate = self;
        _menuTable.dataSource = self;
        [_menuTable registerClass:UITableViewCell.class forCellReuseIdentifier:@"MenuTableCell"];
    }
    return _menuTable;
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

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    UITableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableCell"];
    if(menuCell == nil){
        menuCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuTableCell"];
    }
    menuCell.textLabel.text = @"我的收藏";
    menuCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return menuCell;
}


#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StarPageViewController *starVC = [[StarPageViewController alloc] init];
    [self.navigationController pushViewController:starVC animated:YES];
}

#pragma mark - BarItemActions

- (void)popPage{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
