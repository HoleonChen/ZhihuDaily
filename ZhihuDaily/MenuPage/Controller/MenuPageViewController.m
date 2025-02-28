//
//  MenuPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/25.
//

#import "MenuPageViewController.h"
#import "MenuTableViewCell.h"

@interface MenuPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MenuPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userAvatar];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.menuTable];
    [self.view addSubview:self.copyright];
}

#pragma mark - Lazy

- (UIImageView *)userAvatar{
    if(_userAvatar == nil){
        _userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width/2)-40, 30, 80, 80 )];
        _userAvatar.backgroundColor = [UIColor whiteColor];
        UIImage *avatarImage = [UIImage imageNamed:@"DefaultImage.jpeg"];
        _userAvatar.image = avatarImage;
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
        [_menuTable registerClass:MenuTableViewCell.class forCellReuseIdentifier:@"MenuTableCell"];
    }
    return _menuTable;
}

- (UILabel *)copyright{
    if(_copyright == nil){
        _copyright = [[UILabel alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height-3, UIScreen.mainScreen.bounds.size.width, 3)];
        _copyright.backgroundColor = [UIColor whiteColor];
        _copyright.text = @"ZhihuDaily Duplicated By Holeon.";
        _copyright.textColor = [UIColor lightGrayColor];
        _copyright.font = [UIFont systemFontOfSize:3];
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
    MenuTableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableCell"];
    menuCell.topicLabel.text = @"我的收藏";
    return menuCell;
}




#pragma mark - TableViewDelegate


@end
