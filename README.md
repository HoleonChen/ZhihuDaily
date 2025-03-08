# ZhihuDaily
由Holeon复刻的知乎日报
全部使用Objective-C语言完成编写

所使用的第三方库包括：
- AFNetworking
- SDWebImage
- KJBannerView

---

## 主页面

![主页面预览图](/README_image/MainScreen_ScreenShot.png "主页面预览图")

主页顶部布局使用了UIView，向里面添加了各种元素，包括月份和日期，“知乎日报”标题，以及作为菜单页面入口的头像。
不过顶部视图并未采用MVC开发模式，所有的代码都堆在了ViewController中

本页面的网络请求使用了第三方库"AFNetworking"来完成。

主页的Banner视图使用了第三方库"KJBannerView"辅助完成，并采用了MVC开发模式，能够在实现自我滚动的同时实现手势滚动。
Banner的Cell视图中有背景图片、标题和提示词三大元素，每个Cell都是作为对应新闻页面的入口。Banner底部有示意的控制条。

主页的TableView视图采用了MVC开发模式
TableView的Cell中有预览图、标题和提示词三大元素，每个Cell都是作为对应新闻页面的入口。

> 值得注意的是，目前只实现了最新新闻的显示，历史新闻目前没来得及完成。

Banner和TableView均放置在同一个ScrollView中。

---

## 新闻页面

![新闻页面预览图](/README_image/NewsPage_ScreenShot.png "新闻页面预览图")

新闻详情视图WKWebView的网络请求来自其自带功能，并且注入了JSON代码使其部分元素被隐藏。

新闻页面底部视图使用了UIView，向里面添加了starBtn、likeBtn两个UIButton元素，在点击时会弹出提示窗口，提示“收藏成功/取消收藏”或“已点赞/取消点赞”，点赞按钮点赞数字会发生变化。

> 原本想要实现收藏和点赞数据本地存储，并能够在菜单页面找到收藏内容，同时实现再次点击页面恢复原有收藏状态和点赞状态，由于时间问题将原案废弃。

backBtn、commentImage、shareBtn均为UIImageView，其中backBtn点击事件为返回主页面，其余两个均无实际功能

> 原本shareBtn的点击事件为将文章链接复制到剪切板中并弹出提示框“已复制分享链接”，由于时间问题未实现。

likeNum和commentLabel均为UILabel，能够实现显示点赞数和评论数，likeNum会在点赞后自动+1.

> 该方案存在Bug，就是刚进去页面时所有数字显示为0，在点赞后点赞数字恢复正常，目前尚不清楚Bug原因。

---

## 菜单页面

![菜单页面预览图](/README_image/MenuPage_ScreenShot.png "菜单页面预览图")

菜单页面顶部视图是UIView，只有一个元素backBtn，为UIImageView，点击事件为返回主页面

菜单页面头像为UIImageView，用户名为UILabel。
伪登陆暂未实现。

曾有废弃功能“我的收藏”，但后面废弃，并将我的收藏功能删除。
