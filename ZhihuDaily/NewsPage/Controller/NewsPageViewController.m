//
//  NewsPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/28.
//

#import "NewsPageViewController.h"
#import "MainPageViewController.h"

@interface NewsPageViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *newsView;

@property (nonatomic, strong) UICollectionView *bottomView;

@end

@implementation NewsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newsView];
    // Do any additional setup after loading the view.
}

#pragma mark - Lazy

- (WKWebView *)newsView{
    if(_newsView == nil){
        _newsView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
        _newsView.UIDelegate = self;
        _newsView.navigationDelegate = self;
        _newsView.allowsBackForwardNavigationGestures = NO;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.newsUrl];
        [_newsView loadRequest:request];
        [_newsView reload];
    }
    return _newsView;
}

@end
