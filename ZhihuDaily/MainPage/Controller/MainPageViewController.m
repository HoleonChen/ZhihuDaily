//
//  MainPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/3.
//

#import "MainPageViewController.h"
#import "AFNetworking.h"
#import "SDWebImage.h"

@interface MainPageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<MainPageNewsItemModel *> *dataArrayForPlainStory;  //数据数组，存储

@property (nonatomic, strong) UITableView *newsItemTableView;  //新闻流视图



@end

@implementation MainPageViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArrayForPlainStory = [[NSMutableArray alloc] init];
    [self getRequestOfPlainStory];
    [self.view addSubview:self.newsItemTableView];
}

#pragma mark - Getter //懒加载

- (UITableView *)newsItemTableView{
    if(!_newsItemTableView){
        _newsItemTableView.backgroundColor = [UIColor whiteColor];
        _newsItemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _newsItemTableView.dataSource = self;
        _newsItemTableView.delegate = self;
        [_newsItemTableView registerClass:MainPageTableViewCell.class forCellReuseIdentifier:@"MainPagePlainCell"];
    }
    return _newsItemTableView;
}

#pragma mark - UITableViewDataSource  //数据源

- (void)getRequestOfPlainStory {  //拉取请求，主要是下面的视图，而不是banner
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = @"https://news-at.zhihu.com/api/3/news/latest";
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"stories"]){
            MainPageNewsItemModel *item = [[MainPageNewsItemModel alloc] initWithDic:dic];
            [self.dataArrayForPlainStory addObject:item];
            [self.newsItemTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }
    ];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;  //目前只想考虑最新文章，历史文章以后再想
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrayForPlainStory.count;  //按照文章数量分组
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainPageNewsItemModel *dataModelMainPlain = self.dataArrayForPlainStory[indexPath.row];
    MainPageTableViewCell *mainPlainCell = [tableView dequeueReusableCellWithIdentifier:@"MainPagePlainCell"];
    if (mainPlainCell == nil) {
        mainPlainCell = [[MainPageTableViewCell alloc] init];
    }
    mainPlainCell.topicLabel.text = dataModelMainPlain.newsTitle;
    mainPlainCell.hintLabel.text = dataModelMainPlain.hint;
    [mainPlainCell.prevImageLabel sd_setImageWithURL:[NSURL URLWithString:dataModelMainPlain.thumbnailUrl]];
    return mainPlainCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 310;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}




@end
