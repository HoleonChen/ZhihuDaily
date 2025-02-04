//
//  MainPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/3.
//

#import "MainPageViewController.h"
#import "AFNetworking.h"
#import "MainPageNewsItemModel.h"
#import "MainPageTableViewCell.h"

@interface MainPageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<MainPageNewsItemModel *> *dataArrayForPlainStory;  //数据数组，存储

@property (nonatomic, strong) UITableView *newsItemTableView;

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArrayForPlainStory = [[NSMutableArray alloc] init];
    self.newsItemTableView = [[UITableView alloc] init];
    [self getRequestOfPlainStory];
}

- (void)getRequestOfPlainStory {  //拉取请求，主要是下面的视图，而不是banner
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = @"https://news-at.zhihu.com/api/3";
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"stories"]){
            MainPageNewsItemModel *item = [[MainPageNewsItemModel alloc] initWithDic:dic];
            [self.dataArrayForPlainStory addObject:item];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }
    ];
}

#pragma mark - Getter //懒加载

- (UITableView *)newsItemTableView{
    if(!_newsItemTableView){
        _newsItemTableView = [[UITableView alloc] init];
        _newsItemTableView.dataSource = self;
        _newsItemTableView.delegate = self;
    }
    return _newsItemTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrayForPlainStory.count;
}



@end
