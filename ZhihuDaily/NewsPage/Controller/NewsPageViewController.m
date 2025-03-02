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

@property (nonatomic, strong) UIView *bottomToolBar;

@property (nonatomic, strong) UIImageView *backBtn;
@property (nonatomic, strong) UIButton *starBtn;

@end

@implementation NewsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newsView];
    [self.view addSubview:self.bottomToolBar];
    [self.bottomToolBar addSubview:self.backBtn];
    // Do any additional setup after loading the view.
}

#pragma mark - Lazy

- (WKWebView *)newsView{
    if(_newsView == nil){
        _newsView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-80)];
        _newsView.UIDelegate = self;
        _newsView.navigationDelegate = self;
        _newsView.allowsBackForwardNavigationGestures = NO;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.newsUrl];
        [_newsView loadRequest:request];
        [_newsView reload];
    }
    return _newsView;
}

- (UIView *)bottomToolBar{
    if(_bottomToolBar == nil){
        _bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height-80, UIScreen.mainScreen.bounds.size.width, 80)];
        _bottomToolBar.backgroundColor = [UIColor lightTextColor];
    }
    return _bottomToolBar;
}

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

#pragma mark - WKWebViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.getElementsByClassName('Daily')[0].remove();document.getElementsByClassName('view-more')[0].remove();" completionHandler:nil];
}

#pragma mark - BarItemActions

- (void)popPage{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
