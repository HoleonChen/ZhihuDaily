//
//  StarPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/3/1.
//

#import "StarPageViewController.h"
#import "StarPageModel.h"
#import "StarPageTableViewCell.h"
#import "NewsPageViewController.h"
#import "SDWebImage.h"

@interface StarPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *starTableView;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIImageView *backBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray<StarPageModel *> *dataArrayForStar;

@end

@implementation StarPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.backBtn];
    [self.view addSubview:self.starTableView];
    // Do any additional setup after loading the view.
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

- (UIView *)topView{
    if(_topView == nil){
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 50)];
        _topView.backgroundColor = [UIColor whiteColor];
        
    }
    return _topView;
}

- (UITableView *)starTableView{
    if(_starTableView == nil){
        _starTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _starTableView.backgroundColor = [UIColor whiteColor];
        _starTableView.dataSource = self;
        _starTableView.delegate = self;
        [_starTableView registerClass:StarPageTableViewCell.class forCellReuseIdentifier:@"StarPageCell"];
    }
    return _starTableView;
}


- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((UIScreen.mainScreen.bounds.size.width)/2-40, 25, 80, 20)];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = @"我的收藏";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

#pragma mark - TableViewDataSource

- (void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"StarList.plist" ofType:nil];
    NSArray *dataOriginArray = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dic in dataOriginArray) {
        StarPageModel *model = [[StarPageModel alloc] initWithDic:dic];
        [self.dataArrayForStar addObject:model];
        [self.starTableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrayForStar.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StarPageModel *dataModelStar = self.dataArrayForStar[indexPath.row];
    StarPageTableViewCell *starCell = [tableView dequeueReusableCellWithIdentifier:@"StarPageCell"];
    if(starCell == nil){
        starCell = [[StarPageTableViewCell alloc] init];
    }
    starCell.topicLabel.text = dataModelStar.newsTitle;
    NSURL *starThumbnailUrl = [NSURL URLWithString:dataModelStar.thumbnailUrl];
    [starCell.prevImageLabel sd_setImageWithURL:starThumbnailUrl];
    return starCell;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsPageViewController *newsPage = [[NewsPageViewController alloc] init];
    StarPageModel *newsModel = self.dataArrayForStar[indexPath.row];
    NSString *newsUrlStr = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%ld",(long)newsModel.newsId];
    newsPage.newsUrl = [NSURL URLWithString:newsUrlStr];
    [self.navigationController pushViewController:newsPage animated:YES];
}


#pragma mark - TopViewAction

- (void)popPage{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
