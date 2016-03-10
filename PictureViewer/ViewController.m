//
//  ViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/1.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//
 
#import "ViewController.h"
#import "XsingleRotationRecoginzer.h"
#import "CViewController.h"

typedef enum {
    AddTYPEpicture,
    AddTYPEtext,
}AddTYPE;

@interface ViewController ()<XimgViewDelegate>
{
    int i;
    XsingleRotationRecoginzer *xsGesture;
    XimgView *currentXview;
}
@property (nonatomic,assign)CGRect lastRect;
@property (nonatomic,assign)CGRect lastWRect;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loadImg" object:nil];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loadNoti:) name:@"loadImg" object:nil];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    i=1;
    
    self.lastRect = CGRectMake(50, 200, 300, 300);
    self.lastWRect = CGRectMake(50, 200, 100, 30);
    self.view.backgroundColor = [UIColor lightGrayColor];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Csegue"]) {
        NSLog(@"segu");
        CViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}
-(void)loadNoti:(NSNotification *)noti
{
    NSLog(@"%@",noti.userInfo);
    NSDictionary *info = noti.userInfo;
    [self loadXimgViewWithImg:info[@"image"]];
    
}

-(void)xFocusChange:(XimgView *)view
{
    currentXview.xFocused = NO;
    currentXview = view;
    
}
-(void)loadXimgViewWithImg:(UIImage *)image
{
    XimgView *xv = [[[NSBundle mainBundle]loadNibNamed:@"XimgView" owner:self options:nil]lastObject];
    
    NSLog(@"拿到图片:%@",NSStringFromCGSize(image.size));
    xv.frame = CGRectMake(100, 100, 120, 100);
    xv.img = image;
    xv.delegate = self;
    [self addXgingOnView:xv];
    [self.view addSubview:xv];
    currentXview.xFocused = NO;
    currentXview = xv;
}
-(void)addXgingOnView:(UIView *)view
{
    xsGesture = [[XsingleRotationRecoginzer alloc]initWithTarget:self action:@selector(xsHandle:)];
    [view addGestureRecognizer:xsGesture];
}
-(void)xsHandle:(XsingleRotationRecoginzer *)recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
}
- (IBAction)onAddClick:(UIButton *)sender {
    [self loadXimgViewWithImg: [UIImage imageNamed:[self imgNameStr]]];
     
}
- (IBAction)onAddTextClick:(UIButton *)sender {
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    currentXview.xFocused = NO;
}


//当前view的frame
-(CGRect)nowRect
{
    return CGRectMake(self.lastRect.origin.x+20,self.lastRect.origin.y-20,200,200);
}
-(CGRect)nowRectWith:(AddTYPE)type
{
    if (AddTYPEtext == type) {
        return CGRectMake(self.lastWRect.origin.x+20,self.lastRect.origin.y-20,100,30);
    }else{
        return CGRectMake(self.lastRect.origin.x+20,self.lastRect.origin.y-20,200,200);
    }
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
