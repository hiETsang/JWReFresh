JWReFresh
==============


这是一个简易的上拉加载更多,下拉刷新的Demo,使用方法很简单.


1.导入头文件

2.在需要下载数据的时候调用

//头部
[JWRefresh addHeaderWithTableView:self.tableView andBlock:^(MyHeaderView *footerView, MyHeaderViewStatus status) {
    //下载数据
}];

//底部
[JWRefresh addFooterWithTableView:self.tableView andBlock:^(MyFooterView *footerView, MyFooterViewStatus status) {
    //下载数据
}];


3.在结束下载时调用
[JWRefresh downLoadEnd];

4.如需修改文字,则调用
[JWRefresh footerViewWithTitle:<#(NSString *)#> dragTitle:<#(NSString *)#> loadingTitle:<#(NSString *)#>];
[JWRefresh headerViewWithTitle:<#(NSString *)#> dragTitle:<#(NSString *)#> loadingTitle:<#(NSString *)#>];


