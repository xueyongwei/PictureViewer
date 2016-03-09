//
//  ViewController.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/1.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//
 
#import "ViewController.h"
#import "PhotoView.h"
#import "wordView.h"

typedef enum {
    AddTYPEpicture,
    AddTYPEtext,
}AddTYPE;

@interface ViewController ()
{
    int i;
}
@property (nonatomic,assign)CGRect lastRect;
@property (nonatomic,assign)CGRect lastWRect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i=1;
    self.lastRect = CGRectMake(50, 200, 300, 300);
    self.lastWRect = CGRectMake(50, 200, 100, 30);
    self.view.backgroundColor = [UIColor lightGrayColor];
}
- (IBAction)onAddClick:(UIButton *)sender {
    [self customImgViewWith:AddTYPEpicture];
//    [self customImgView];
}
- (IBAction)onAddTextClick:(UIButton *)sender {
    [self customImgViewWith:AddTYPEtext];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//绘制图片界面
//-(void)customImgView
//{
//    PhotoView *pv = [[[NSBundle mainBundle]loadNibNamed:@"PhotoView" owner:self options:nil]lastObject];
//    pv.frame = [self nowRect];
//    pv.imgView.image = [UIImage imageNamed:[self imgNameStr]];
//    
//    [self.view addSubview:pv];
//    self.lastRect = pv.frame;
//}
-(void)customImgViewWith:(AddTYPE)type
{
    
    if (type == AddTYPEpicture) {
        
        PhotoView *pv = [[[NSBundle mainBundle]loadNibNamed:@"PhotoView" owner:self options:nil]lastObject];
        pv.frame = [self nowRectWith:AddTYPEpicture];
        pv.imgView.image = [UIImage imageNamed:[self imgNameStr]];
        
        [self.view addSubview:pv];
        self.lastRect = pv.frame;
    }else if (AddTYPEtext == type){
        wordView *wv = [[[NSBundle mainBundle]loadNibNamed:@"wordView" owner:self options:nil]lastObject];;
        wv.frame = [self nowRectWith:AddTYPEtext];
        [self.view addSubview:wv];
        self.lastWRect = wv.frame;
    }
    
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
