//
//  MainPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/3.
//

#import "MainPageViewController.h"
#import "AFNetworking.h"
#import "SDWebImage.h"
#import "KJBannerHeader.h"
#import "MainPageBannerViewCell.h"
#import "MainPageBannerViewModel.h"
#import "MenuPageViewController.h"
#import "NewsPageViewController.h"
#import "TopView.h"

@interface MainPageViewController ()<UITableViewDataSource, UITableViewDelegate, KJBannerViewDelegate, KJBannerViewDataSource>


@property (nonatomic, strong) TopView *topView;

@property (nonatomic, strong) NSMutableArray<MainPageNewsItemModel *> *dataArrayForPlainStory;  //数据数组，存储，针对普通新闻

@property (nonatomic, strong) NSMutableArray<MainPageBannerViewModel *> *dataArrayForTopStory;  //数据数组，存储，针对Banner上的新闻

@property (nonatomic, strong) UITableView *newsItemTableView;  //新闻流视图

@property (nonatomic, strong) UIScrollView *mainScreenScroll;  //主页面新闻流滑动视图

@property (nonatomic, strong) KJBannerView *topNewsBannerView;  //Banner视图

@end

@implementation MainPageViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //Necessary Datas Init
    self.dataArrayForPlainStory = [[NSMutableArray alloc] init];
    self.dataArrayForTopStory = [[NSMutableArray alloc] init];
    [self getRequest];
    //topView Init
    [self.view addSubview:self.topView];
    //scrollView Init
    [self.view addSubview:self.mainScreenScroll];
    [self.mainScreenScroll addSubview:self.topNewsBannerView];
    [self.mainScreenScroll addSubview:self.newsItemTableView];
    
}


#pragma mark - Getter //懒加载

- (TopView *)topView{
    if(_topView == nil){
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 60)];
        _topView. backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseImage:)];
        [_topView.avatarImageView addGestureRecognizer:avatarTap];
    }
    return _topView;
}

- (UIScrollView *)mainScreenScroll{
    if(!_mainScreenScroll){
        _mainScreenScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height )];
        _mainScreenScroll.backgroundColor = [UIColor whiteColor];
        _mainScreenScroll.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, self.topNewsBannerView.bounds.size.height+self.newsItemTableView.bounds.size.height);
    }
    return _mainScreenScroll;
}

- (UITableView *)newsItemTableView{
    if(!_newsItemTableView){
        _newsItemTableView.backgroundColor = [UIColor whiteColor];
        _newsItemTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 390, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _newsItemTableView.dataSource = self;
        _newsItemTableView.delegate = self;
        [_newsItemTableView registerClass:MainPageTableViewCell.class forCellReuseIdentifier:@"MainPagePlainCell"];
    }
    return _newsItemTableView;
}

- (KJBannerView *)topNewsBannerView{
    if(!_topNewsBannerView){
        _topNewsBannerView = [[KJBannerView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 390)];
        _topNewsBannerView.dataSource = self;
        _topNewsBannerView.delegate = self;
        _topNewsBannerView.autoTime = 5;
        [_topNewsBannerView registerClass:[MainPageBannerViewCell class]forCellWithReuseIdentifier:@"MainPageBannerCell"];
        _topNewsBannerView.pageControl.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0];
    }
    return _topNewsBannerView;
}

#pragma mark - OnlineDataSource  //数据源

- (void)getRequest {  //拉取请求，不包含历史新闻
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = @"https://news-at.zhihu.com/api/3/news/latest";
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"stories"]){
            MainPageNewsItemModel *plainItem = [[MainPageNewsItemModel alloc] initWithDic:dic];
            [self.dataArrayForPlainStory addObject:plainItem];
            [self.newsItemTableView reloadData];
        }
        for (NSDictionary *dic in responseObject[@"top_stories"]){
            MainPageBannerViewModel *topItem = [[MainPageBannerViewModel alloc] initWithDic:dic];
            [self.dataArrayForTopStory addObject:topItem];
            [self.topNewsBannerView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }
    ];
}

#pragma mark - UITableViewDataSource

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
    mainPlainCell.topicLabel.text = dataModelMainPlain.newsTitle;  //标题
    mainPlainCell.hintLabel.text = dataModelMainPlain.hint;  //提示词
    NSString *mainPlainThumbnailUrlString = dataModelMainPlain.thumbnailUrl.firstObject;  //将从API获取到的数组URL转化为NSString类型
    NSURL *mainPlainThumbnailUrl = [NSURL URLWithString:mainPlainThumbnailUrlString];  //再将NSString类型的URL转化为NSURL类型
    [mainPlainCell.prevImageLabel sd_setImageWithURL: mainPlainThumbnailUrl];  //通过相应的URL获取对应的新闻图片
    return mainPlainCell;
}

#pragma mark - BannerViewDataSource

- (NSInteger)kj_numberOfItemsInBannerView:(KJBannerView *)banner {
    return self.dataArrayForTopStory.count;
}

- (KJBannerViewCell *)kj_bannerView:(KJBannerView *)banner cellForItemAtIndex:(NSInteger)index {
    MainPageBannerViewModel *dataModelMainTop = self.dataArrayForTopStory[index];
    MainPageBannerViewCell *mainTopCell = [banner dequeueReusableCellWithReuseIdentifier:@"MainPageBannerCell" forIndex:index];
    if(mainTopCell == nil){
        mainTopCell = [[MainPageBannerViewCell alloc] init];
    }
    mainTopCell.topicLabel.text = dataModelMainTop.newsTitle;
    mainTopCell.hintLabel.text = dataModelMainTop.hint;
    NSURL *mainTopThumbnailUrl = [NSURL URLWithString:dataModelMainTop.thumbnailUrl];  //再将NSString类型的URL转化为NSURL类型
    [mainTopCell.prevImageLabel sd_setImageWithURL:mainTopThumbnailUrl];  //通过相应的URL获取对应的新闻图片
    return mainTopCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsPageViewController *newsPage = [[NewsPageViewController alloc] init];
    MainPageNewsItemModel *newsModel = self.dataArrayForPlainStory[indexPath.row];
    newsPage.newsUrl = [NSURL URLWithString:newsModel.newsUrl];
    newsPage.newsId = newsModel.newsId;
    newsPage.newsTitle = newsModel.newsTitle;
    newsPage.thumbnailUrl = newsModel.thumbnailUrl.firstObject;
    [self.navigationController pushViewController:newsPage animated:YES];
}

#pragma mark - BannerViewDelegate

- (void)kj_bannerView:(KJBannerView *)banner didSelectItemAtIndex:(NSInteger)index{
    NewsPageViewController *newsPage = [[NewsPageViewController alloc] init];
    MainPageBannerViewModel *newsModel = self.dataArrayForTopStory[index];
    newsPage.newsUrl = [NSURL URLWithString:newsModel.newsUrl];
    newsPage.newsId = newsModel.newsId;
    newsPage.newsTitle = newsModel.newsTitle;
    newsPage.thumbnailUrl = newsModel.thumbnailUrl;
    [self.navigationController pushViewController:newsPage animated:YES];
}

#pragma mark - AvatarClickAction

-(void)choseImage:(UITapGestureRecognizer*)sender{
    MenuPageViewController *menuPage = [[MenuPageViewController alloc] init];
    [self.navigationController pushViewController:menuPage animated:YES];
}

@end
