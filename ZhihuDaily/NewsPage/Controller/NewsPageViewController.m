//
//  NewsPageViewController.m
//  ZhihuDaily
//
//  Created by Holeon on 2025/2/28.
//

#import "NewsPageViewController.h"
#import "MainPageViewController.h"
#import "AFNetworking.h"

@interface NewsPageViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *newsView;

@property (nonatomic, strong) UIView *bottomToolBar;

@property (nonatomic, strong) UIImageView *backBtn;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *likeNum;
@property (nonatomic, strong) UIImageView *commentImage;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIImageView *shareButton;

@property (nonatomic, assign) NSNumber *popularityNum;
@property (nonatomic, assign) NSNumber *commentNum;


@end

@implementation NewsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getRequest];
    [self.view addSubview:self.newsView];
    [self.view addSubview:self.bottomToolBar];
    [self.bottomToolBar addSubview:self.backBtn];
    [self.bottomToolBar addSubview:self.starBtn];
    [self.bottomToolBar addSubview:self.likeBtn];
    [self.bottomToolBar addSubview:self.likeNum];
    [self.bottomToolBar addSubview:self.commentImage];
    [self.bottomToolBar addSubview:self.commentLabel];
    [self.bottomToolBar addSubview:self.shareButton];
    // Do any additional setup after loading the view.
}

#pragma mark - ExtraDataLoad

- (void)getRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSLog(@"%@",self.newsId);
    NSString *urlString = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/3/story-extra/%@",self.newsId];
    NSLog(@"%@",urlString);
    [manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSLog(@"%@",responseObject);
        self.popularityNum = responseObject[@"popularity"];
        self.commentNum = responseObject[@"comments"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){}];
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

- (UIButton *)starBtn{
    if(_starBtn == nil){
        _starBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 15, 35, 35)];
        [_starBtn setImage:[UIImage imageNamed:@"si_star-fill.png"] forState:UIControlStateSelected];
        [_starBtn setImage:[UIImage imageNamed:@"si_star-duotone.png"] forState:UIControlStateNormal];
        [_starBtn addTarget:self action:@selector(starClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starBtn;
}

- (UIButton *)likeBtn{
    if(_likeBtn == nil){
        _likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(170, 15, 35, 35)];
        [_likeBtn setImage:[UIImage imageNamed:@"bxs_like.png"] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"bx_like.png"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UILabel *)likeNum{
    if(_likeNum == nil){
        _likeNum = [[UILabel alloc] initWithFrame:CGRectMake(206, 17, 16, 16)];
        _likeNum.backgroundColor = [UIColor clearColor];
        _likeNum.text = [NSString stringWithFormat:@"%d",[self.popularityNum intValue]];
        _likeNum.textAlignment = NSTextAlignmentLeft;
        _likeNum.textColor = [UIColor blackColor];
        _likeNum.font = [UIFont systemFontOfSize:8];
    }
    return _likeNum;
}

- (UIImageView *)commentImage{
    if(_commentImage == nil){
        _commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 35, 35)];
        _commentImage.image = [UIImage imageNamed:@"mdi_comment-outline.png"];
        _commentImage.layer.masksToBounds = YES;
    }
    return _commentImage;
}

- (UILabel *)commentLabel{
    if(_commentLabel == nil){
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(276, 17, 16, 16)];
        _commentLabel.backgroundColor = [UIColor clearColor];
        _commentLabel.text = [NSString stringWithFormat:@"%d",[self.commentNum intValue]];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.textColor = [UIColor blackColor];
        _commentLabel.font = [UIFont systemFontOfSize:8];
    }
    return _commentLabel;
}

- (UIImageView *)shareButton{
    if(_shareButton == nil){
        _shareButton = [[UIImageView alloc] initWithFrame:CGRectMake(310, 15, 35, 35)];
        _shareButton.image = [UIImage imageNamed:@"ion_share-outline.png"];
        _shareButton.layer.masksToBounds = YES;
    }
    return _shareButton;
}

#pragma mark - WKWebViewDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.getElementsByClassName('Daily')[0].remove();document.getElementsByClassName('view-more')[0].remove();" completionHandler:nil];
}

#pragma mark - BarItemActions

- (void)popPage{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ButtonAction

- (void) starClick{
    self.starBtn.selected = !self.starBtn.selected;
    NSString *alertMessage = [[NSString alloc] init];
    if(self.starBtn.selected){
        alertMessage = @"收藏成功";
    }else{
        alertMessage = @"取消收藏";
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertMessage
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) likeClick{
    self.likeBtn.selected = !self.likeBtn.selected;
    NSString *alertMessage = [[NSString alloc] init];
    if(self.likeBtn.selected){
        alertMessage = @"已点赞";
        int result = [self.popularityNum intValue] + 1;
        _likeNum.text = [NSString stringWithFormat:@"%d",result];
    }else{
        alertMessage = @"取消点赞";
        _likeNum.text = [NSString stringWithFormat:@"%@",self.popularityNum];
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertMessage
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
