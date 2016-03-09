//
//  wordView.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/4.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "wordView.h"

@implementation wordView
{
    CGPoint pic;
    CGPoint pre;
    CGPoint nxt;
    BOOL shouldPan;
}
-(void)awakeFromNib
{
    [self addGuest];
    shouldPan = YES;
}
- (IBAction)onDelClick:(UIButton *)sender {
    [sender.superview removeFromSuperview];
}

-(void)addGuest
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureHandle:)];
    [self addGestureRecognizer:pan];
    
//    [self addRotationGesture];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    pic = self.center;
    DbLog(@"self.frame %@",NSStringFromCGRect(self.frame));
    
    UITouch *touch = [[event touchesForView:self.xzView]anyObject];
    if (touch) {
        DbLog(@"点击了Label旋转图标");
        
        CGPoint center1 = [touch locationInView:self.superview];
        DbLog(@"point in self.superview %@",NSStringFromCGPoint(center1));
        
        pre = center1;
        nxt = center1;
    }
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ving..");
    UITouch *touch = [[event touchesForView:self.xzView]anyObject];
    if (touch) {
        shouldPan = NO;
        CGPoint center = [touch locationInView:self.superview];
        DbLog(@"point in self.superview %@",NSStringFromCGPoint(center));
        nxt = center;
        
        DbLog(@"pre %@     nxt %@",NSStringFromCGPoint(pre),NSStringFromCGPoint(nxt));
        
        [self customNewView];
        
        pre = center;

    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    shouldPan = YES;
}
-(void)customNewView
{
    double a = sqrt((nxt.x-pre.x)*(nxt.x-pre.x)+(nxt.y-pre.y)*(nxt.y-pre.y));
    double b = sqrt((nxt.x-pic.x)*(nxt.x-pic.x)+(nxt.y-pic.y)*(nxt.y-pic.y));
    double c = sqrt((pre.x-pic.x)*(pre.x-pic.x)+(pre.y-pic.y)*(pre.y-pic.y));
    double cosA = (b*b+c*c-a*a)/(2*c*b);
    double arcConA = acos(cosA);
    double angleA = arcConA;
    if (nxt.x>self.center.x) {//在中心点的右侧，y递减则逆时针
        if (nxt.y-pre.y<0) {
            angleA = -fabs(arcConA);
        }else if(nxt.y == pre.y){//水平滑动
            if (nxt.y<pic.y) {//在右上方
                DbLog(@"右上方");
                if (nxt.x<pre.x) {
                    DbLog(@"向左");
                    angleA = -fabs(arcConA);
                }else
                {
                    DbLog(@"向右");
                    angleA = fabs(arcConA);
                }
            }else//右下方
            {
                DbLog(@"右下方");
                if (nxt.x>pre.x) {
                    DbLog(@"向右");
                    angleA = -fabs(arcConA);
                }else
                {
                    DbLog(@"向左");
                    angleA = fabs(arcConA);
                }
            }
        }else//往下滑动
        {
            angleA = fabs(arcConA);
        }
    }else if (nxt.x==self.center.x){//在竖直方向
        DbLog(@"！！！！！！！！！竖直方向");
        
        DbLog(@"！！！！！！！！！竖直方向");
        if (nxt.y<pic.y) {//最上方
            DbLog(@"最上方");
            if (nxt.x<pre.x) {//向左移动
                DbLog(@"向左");
                angleA = fabs(arcConA);
            }else{
                DbLog(@"向右");
                angleA = -fabs(arcConA);
            }
        }else if(nxt.y>=pic.y)//最下方
        {
            DbLog(@"最下方");
            if (nxt.x<pre.x) {//向左移动
                DbLog(@"向左");
                angleA = -fabs(arcConA);
            }else{
                DbLog(@"向右");
                angleA = fabs(arcConA);
            }
        }
        
    }else if(nxt.x<self.center.x)//在中心点的左侧，y递增则逆时针
    {
        DbLog(@"<-中心点左侧");
        if (nxt.y>pre.y) {//向下移动
            DbLog(@"向下");
            angleA = -fabs(arcConA);
        }else if(nxt.y==pre.y)
        {
            if (nxt.y<pic.y) {//
                DbLog(@"最上方");
                if (nxt.x<pre.x) {
                    DbLog(@"向左");
                    angleA = -fabs(arcConA);
                }else
                {
                    DbLog(@"向右");
                    angleA = fabs(arcConA);
                }
            }else
            {
                DbLog(@"最下方");
                if (nxt.x<pre.x) {
                    DbLog(@"向左");
                    
                    angleA = fabs(arcConA);
                }else
                {
                    DbLog(@"向右");
                    angleA = -fabs(arcConA);
                }
            }
        }else if(nxt.y<pre.y)
        {
            DbLog(@"向上");
            angleA = fabs(arcConA);
        }
    }
    DbLog(@"angleA %f",angleA);
    self.transform = CGAffineTransformRotate(self.transform, angleA);
    
}

-(void)addRotationGesture
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGestureHandle:)];
    [self addGestureRecognizer:rotation];
}
-(void)panGestureHandle:(UIPanGestureRecognizer *)recognizer
{
    if (!shouldPan) {
        return;
    }
    CGPoint tran = [recognizer translationInView:self.superview];
    recognizer.view.center = CGPointMake(recognizer.view.center.x+tran.x, recognizer.view.center.y+tran.y);
    [recognizer setTranslation:CGPointZero inView:self.superview];
}
-(void)rotationGestureHandle:(UIRotationGestureRecognizer *)recognizer
{
    self.transform = CGAffineTransformRotate(self.transform, recognizer.rotation);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
