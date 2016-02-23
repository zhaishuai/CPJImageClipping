# CPJImageClipping
CPJImageClipping是一个专门裁剪图片的库。
#Screenshot
<center>![裁剪图片](https://github.com/zhaishuai/CPJImageClipping/blob/master/3.png)<center/>
#How to Use
CPJImageClipping使用起来非常简单，不需要编译静态库也不需要其他额外的配置只需要将<code>CPJClippingPanel</code>文件夹下的文件拷贝至自己的工程下即可。<br/>
##代码示例
``` objective-c
- (void)configImageCropper{
  // 初始化以及配置画布、裁剪窗口的大小颜色
  //
    self.imageClipping = [[CPJImageClipping alloc] init];
    self.imageClipping.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 35);
    self.imageClipping.clippingPanel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95];
    self.imageClipping.clippingRect = CGRectMake(SCREEN_WIDTH/2 - HEADER_SIZE/2, SCREEN_HEIGHT/2 - HEADER_SIZE/2, HEADER_SIZE, HEADER_SIZE);
    
    //将裁剪窗口添加到控制器的视图中
    //
    [self addChildViewController:self.imageClipping];
    [self.view addSubview:self.imageClipping.view];
}

- (IBAction)clipAction:(id)sender {
    // 裁剪图片命令
    //
    self.image = [self.imageClipping clippImage];
}

```
