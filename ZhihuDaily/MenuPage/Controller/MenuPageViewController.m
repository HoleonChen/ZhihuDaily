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
    // Do any additional setup after loading the view.
}

#pragma mark - Lazy

- (UIImageView *)userAvatar{
    if(_userAvatar == nil){
        
    }
    return _userAvatar;
}

- (UILabel *)userName{
    return _userName;
}

- (UITableView *)menuTable{
    return _menuTable;
}

- (UICollectionView *)collectionView{
    return _collectionView;
}

#pragma mark - TableViewDataSource

#pragma mark - TableViewDelegate

#pragma mark - CollectionViewDataSource

#pragma mark - CollectionViewDelegate

@end
