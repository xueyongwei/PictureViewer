//
//  ViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/1.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//
 
#import "ViewController.h"
#import "PhotoView.h"

@interface ViewController ()
{
    int i;
}
@property (nonatomic,assign)CGRect lastRect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i=1;
    self.lastRect = CGRectMake(50, 200, 300, 300);
    self.view.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)onAddClick:(UIButton *)sender {
    [self customImgView];
}
//绘制图片界面
-(void)customImgView
{
    PhotoView *pv = [[[NSBundle mainBundle]loadNibNamed:@"PhotoView" owner:self options:nil]lastObject];
    pv.frame = [self nowRect];
    pv.imgView.image = [UIImage imageNamed:[self imgNameStr]];
    
    [self.view addSubview:pv];
    self.lastRect = pv.frame;
}

//当前view的frame
-(CGRect)nowRect
{
    return CGRectMake(self.lastRect.origin.x+20,self.lastRect.origin.y-20,200,200);
}
//需要加载的图片名字
-(NSString *)imgNameStr
{
    if (i>3) {
        i=1;
    }
    return [NSString stringWithFormat:@"%d.jpg",i++];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
