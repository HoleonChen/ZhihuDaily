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

@interface MainPageViewController ()<UITableViewDataSource, UITableViewDelegate, KJBannerViewDelegate, KJBannerViewDataSource>

@property (nonatomic, strong) NSURL *topNewsUrl;

@property (nonatomic, strong) NSURL *plainNewsUrl;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *day;
@property (nonatomic, strong) UILabel *month;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *topic;

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
    self.topNewsUrl = [[NSURL alloc] init];
    self.plainNewsUrl = [[NSURL alloc] init];
    [self getRequest];
    //topView Init
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.month];
    [self.topView addSubview:self.day];
    [self.topView addSubview:self.topic];
    [self.topView addSubview:self.avatar];
    //scrollView Init
    [self.view addSubview:self.mainScreenScroll];
    [self.mainScreenScroll addSubview:self.topNewsBannerView];
    [self.mainScreenScroll addSubview:self.newsItemTableView];
    
}


#pragma mark - Getter //懒加载

- (UIView *)topView{
    if(_topView == nil){
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, UIScreen.mainScreen.bounds.size.width, 60)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UILabel *)month{
    if(_month == nil){
        _month = [[UILabel alloc] initWithFrame:CGRectMake(16, 39, 32, 12)];
        _month.backgroundColor = [UIColor whiteColor];
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar  currentCalendar];
        unsigned int unitFlags = NSMonthCalendarUnit;
        NSDateComponents *d = [calendar components:unitFlags fromDate:currentDate];
        int monthNum = [d month];
        NSString *monthStr;
        switch (monthNum) {
            case 1:
                monthStr = @"一月";
                break;
            case 2:
                monthStr = @"二月";
                break;
            case 3:
                monthStr = @"三月";
                break;
            case 4:
                monthStr = @"四月";
                break;
            case 5:
                monthStr = @"五月";
                break;
            case 6:
                monthStr = @"六月";
                break;
            case 7:
                monthStr = @"七月";
                break;
            case 8:
                monthStr = @"八月";
                break;
            case 9:
                monthStr = @"九月";
                break;
            case 10:
                monthStr = @"十月";
                break;
            case 11:
                monthStr = @"十一月";
                break;
            case 12:
                monthStr = @"十二月";
                break;
        }
        _month.text = monthStr;
        _month.font = [UIFont systemFontOfSize:12 weight:bold];
        _month.textAlignment = NSTextAlignmentCenter;
        _month.textColor = [UIColor blackColor];
    }
    return _month;
}

- (UILabel *)day{
    if(_day == nil){
        _day = [[UILabel alloc] initWithFrame:CGRectMake(17, 14, 30, 20)];
        _day.backgroundColor = [UIColor whiteColor];
        NSDate *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar  currentCalendar];
        unsigned int unitFlags = NSDayCalendarUnit;
        NSDateComponents *d = [calendar components:unitFlags fromDate:currentDate];
        NSInteger *dayNum = [d day];
        NSString *dayStr = [[NSNumber numberWithInteger:dayNum] stringValue];
        _day.text = dayStr;
        _day.font = [UIFont systemFontOfSize:20];
        _day.textAlignment = NSTextAlignmentCenter;
        _day.textColor = [UIColor blackColor];
    }
    return _day;
}

- (UILabel *)topic{
    if(_topic == nil){
        _topic = [[UILabel alloc] initWithFrame:CGRectMake(80, 17, 100, 25)];
        _topic.backgroundColor = [UIColor whiteColor];
        _topic.text = @"知乎日报";
        _topic.font = [UIFont systemFontOfSize:25];
        _topic.textAlignment = NSTextAlignmentLeft;
        _topic.textColor = [UIColor blackColor];
    }
    return _topic;
}

- (UIImageView *)avatar{
    if(_avatar == nil){
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(340, 13, 34, 34)];
        _avatar.backgroundColor = [UIColor whiteColor];
        _avatar.image = [UIImage imageNamed:@"DefaultAvatar.jpeg"];
        _avatar.layer.cornerRadius = 17;
        _avatar.layer.masksToBounds = YES;
        _avatar.userInteractionEnabled = YES;
        UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseImage:)];
        [_avatar addGestureRecognizer:avatarTap];
    }
    return _avatar;
}

- (UIScrollView *)mainScreenScroll{
    if(!_mainScreenScroll){
        _mainScreenScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 110, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _mainScreenScroll.backgroundColor = [UIColor whiteColor];
        _mainScreenScroll.contentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height+1);
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
    self.plainNewsUrl = [NSURL URLWithString:dataModelMainPlain.newsUrl];
    mainPlainCell.topicLabel.text = dataModelMainPlain.newsTitle;  //标题
    mainPlainCell.hintLabel.text = dataModelMainPlain.hint;  //提示词
    NSString *mainPlainThumbnailUrlString = dataModelMainPlain.thumbnailUrl.firstObject;  //将从API获取到的数组URL转化为NSString类型
    NSURL *mainPlainThumbnailUrl = [mainPlainThumbnailUrlString stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];  //再将NSString类型的URL转化为NSURL类型
    [mainPlainCell.prevImageLabel sd_setImageWithURL: [NSURL URLWithString:mainPlainThumbnailUrl]];  //通过相应的URL获取对应的新闻图片
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
    NSString *imageUrlStr = dataModelMainTop.thumbnailUrl;
    NSURL *mainTopThumbnailUrl = [imageUrlStr stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];  //再将NSString类型的URL转化为NSURL类型
    [mainTopCell.prevImageLabel sd_setImageWithURL: [NSURL URLWithString:mainTopThumbnailUrl]];  //通过相应的URL获取对应的新闻图片
    self.topNewsUrl = [NSURL URLWithString:dataModelMainTop.newsUrl];
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
    newsPage.newsUrl = self.plainNewsUrl;
    [self.navigationController pushViewController:newsPage animated:YES];
    NSLog(@"Clicked!");
}

#pragma mark - BannerViewDelegate

- (void)kj_bannerView:(KJBannerView *)banner didSelectItemAtIndex:(NSInteger)index{
    NewsPageViewController *newsPage = [[NewsPageViewController alloc] init];
    newsPage.newsUrl = self.topNewsUrl;
    [self.navigationController pushViewController:newsPage animated:YES];
}

#pragma mark - AvatarClickAction

-(void)choseImage:(UITapGestureRecognizer*)sender{
    MenuPageViewController *menuPage = [[MenuPageViewController alloc] init];
    [self.navigationController pushViewController:menuPage animated:YES];
}

@end
