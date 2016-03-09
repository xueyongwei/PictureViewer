//
//  PhotoView.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/1.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "PhotoView.h"
#define MAXSCALETIME 2

@implementation PhotoView
{
    CGPoint pic;
    CGPoint pre;
    CGPoint nxt;
    double oldLen;
    BOOL xuanZhuan;
    CGAffineTransform oldTransForm;
    int num;
}
-(void)awakeFromNib
{
    oldLen = self.bounds.size.width;
    DbLog(@"oldLen = %f",oldLen);
    [self addGestureDoubleFinger];
    [self AddpanGuest];
    xuanZhuan = NO;
    num = 0;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)addGestureDoubleFinger
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchHandle:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
    
    [self addGestureDoubleRotation];
}
-(void)addGestureDoubleRotation
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationHandle:)];
    rotation.delegate = self;
    [self addGestureRecognizer:rotation];
}
-(void)pinchHandle:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}
-(void)rotationHandle:(UIRotationGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}
- (IBAction)onDeleteClick:(UIButton *)sender {
    [sender.superview removeFromSuperview];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DbLog(@"touch the PicView! init pic point");
    pic = self.center;DbLog(@"self.frame %@",NSStringFromCGRect(self.frame));
    DbLog(@"center of self %@",NSStringFromCGPoint(pic));
    
    oldTransForm = self.transform;
    
    
    UITouch *touch1 = [[event touchesForView:self.xzView] anyObject];
    if (touch1) {//如果点的是旋转的图标
        DbLog(@"点击了旋转图标");
        
        CGPoint center1 = [touch1 locationInView:self.superview];
        DbLog(@"point in self.superview %@",NSStringFromCGPoint(center1));
        pre = center1;
        nxt = center1;
        xuanZhuan = YES;
    }else
    {
        DbLog(@"直接拖动");
        xuanZhuan = NO;
    }
    
}
-(void)panImg:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:self.superview];
    
    self.center = CGPointMake(self.center.x+point.x, self.center.y+point.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
}
-(void)AddpanGuest
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panImg:)];
    [self.imgView addGestureRecognizer:pan];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    num = 0;
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self.superview];
    NSLog(@"num = %d",num++);
    
    if (xuanZhuan) {
        nxt = touchPoint;
        DbLog(@"pre %@     nxt %@",NSStringFromCGPoint(pre),NSStringFromCGPoint(nxt));
        
        [self customScale];
        [self customNewView];
        pre = touchPoint;
        NSLog(@"%@",NSStringFromCGPoint(self.xzView.center));
    }else
    {
//        double preLen = sqrt((pre.x-pic.x)*(pre.x-pic.x)+(pre.y-pic.y)*(pre.y-pic.y));
//        DbLog(@"prelen = %f",preLen);
//        
//        double nxtLen = sqrt((nxt.x-pic.x)*(nxt.x-pic.x)+(nxt.y-pic.y)*(nxt.y-pic.y));
//        DbLog(@"prelen = %f",nxtLen);
//        
//        DbLog(@"oldLen = %f",oldLen);
//        if (preLen<oldLen) {
//            self.transform = CGAffineTransformScale(self.transform, nxtLen/preLen, nxtLen/preLen);
//        }
//        UITouch *touch2 = [[event touchesForView:self.imgView] anyObject];
//        if (touch2) {//点击图片时拖动
//            DbLog(@"moveimg..");
//            
//            DbLog(@"改变中心点之前的frame是%@",NSStringFromCGRect(self.frame));
//            CGPoint laCentet = [touch2 previousLocationInView:self.superview];
//            CGPoint center =
//            [touch2 locationInView:self.superview];
//            self.center = CGPointMake(self.center.x+center.x-laCentet.x, self.center.y+center.y-laCentet.y);
//            DbLog(@"改变中心点之后的frame是%@",NSStringFromCGRect(self.frame));
//        }


    }
    
//    if (touch1) {//点击小蓝块时旋转红块
//       
//        CGPoint center = [touch1 locationInView:self.superview];
//        DbLog(@"point in self.superview %@",NSStringFromCGPoint(center));
//        nxt = center;
//        
//        DbLog(@"pre %@     nxt %@",NSStringFromCGPoint(pre),NSStringFromCGPoint(nxt));
//        
//        [self customNewView];
//        [self customScale];
//
//        pre = center;
//    }
    }
-(void)customScale
{
    double preLen = sqrt((pre.x-pic.x)*(pre.x-pic.x)+(pre.y-pic.y)*(pre.y-pic.y));
    DbLog(@"prelen = %f",preLen);
    
    double nxtLen = sqrt((nxt.x-pic.x)*(nxt.x-pic.x)+(nxt.y-pic.y)*(nxt.y-pic.y));
    DbLog(@"prelen = %f",nxtLen);
    
    DbLog(@"oldLen = %f",oldLen);
    if (preLen<oldLen) {
        self.transform = CGAffineTransformScale(self.transform, nxtLen/preLen, nxtLen/preLen);
    }
   
//    self.transform = CGAffineTransformScale(self.transform, nxtLen/preLen, nxtLen/preLen);
}
-(void)customNewView
{
    double a = sqrt((nxt.x-pre.x)*(nxt.x-pre.x)+(nxt.y-pre.y)*(nxt.y-pre.y));
    double b = sqrt((nxt.x-pic.x)*(nxt.x-pic.x)+(nxt.y-pic.y)*(nxt.y-pic.y));
    double c = sqrt((pre.x-pic.x)*(pre.x-pic.x)+(pre.y-pic.y)*(pre.y-pic.y));
    double cosA = (b*b+c*c-a*a)/(2*c*b);
    double arcConA = acos(cosA);
    
    NSLog(@"%f %f %f",arcConA,cosA,arcConA*2*M_PI);
    
    double angleA = arcConA;
    if ((nxt.y>self.center.y&&nxt.x>pre.x)||(nxt.x>self.center.x&&nxt.y<pre.y)||(nxt.y<self.center.y&&nxt.x<pre.x)||(nxt.x<self.center.x&&nxt.y>pre.y)) {
        if (cosA>0) {
            angleA = -arcConA;
        }
        
    }else
    {
        angleA = fabs(arcConA);
    }
//    
//    if (nxt.x>self.center.x) {//在中心点的右侧，y递减则逆时针
//        if (nxt.y<pre.y) {
//            angleA = -fabs(arcConA);
//        }else
//        {
//            angleA = fabs(arcConA);
//        }
//    }else if (nxt.x==self.center.x){//中心点方向
//        //缩放
//    }else{//中心点左侧
//        if (nxt.y>pre.y) {
//            angleA = -fabs(arcConA);
//        }else
//        {
//            angleA = fabs(arcConA);
//        }
//    }
//    
////    if (nxt.x>self.center.x) {//在中心点的右侧，y递减则逆时针
////        if (nxt.y-pre.y<0) {
////            angleA = -fabs(arcConA);
////        }else if(nxt.y == pre.y){//水平滑动
////            if (nxt.y<pic.y) {//在右上方
////                DbLog(@"右上方");
////                if (nxt.x<pre.x) {
////                    DbLog(@"向左");
////                    angleA = -fabs(arcConA);
////                }else
////                {
////                    DbLog(@"向右");
////                    angleA = fabs(arcConA);
////                }
////            }else//右下方
////            {
////                DbLog(@"右下方");
////                if (nxt.x>pre.x) {
////                    DbLog(@"向右");
////                    angleA = -fabs(arcConA);
////                }else
////                {
////                    DbLog(@"向左");
////                    angleA = fabs(arcConA);
////                }
////            }
////        }else//往下滑动
////        {
////            angleA = fabs(arcConA);
////        }
////    }else if (nxt.x==self.center.x){//在竖直方向
////        DbLog(@"！！！！！！！！！竖直方向");
////        
////       DbLog(@"！！！！！！！！！竖直方向");
////        if (nxt.y<pic.y) {//最上方
////             DbLog(@"最上方");
////            if (nxt.x<pre.x) {//向左移动
////                DbLog(@"向左");
////                angleA = fabs(arcConA);
////            }else{
////                DbLog(@"向右");
////                angleA = -fabs(arcConA);
////            }
////        }else if(nxt.y>=pic.y)//最下方
////        {
////             DbLog(@"最下方");
////            if (nxt.x<pre.x) {//向左移动
////                DbLog(@"向左");
////                angleA = -fabs(arcConA);
////            }else{
////                DbLog(@"向右");
////                angleA = fabs(arcConA);
////            }
////        }
////        
////    }else if(nxt.x<self.center.x)//在中心点的左侧，y递增则逆时针
////    {
////         DbLog(@"<-中心点左侧");
////        if (nxt.y>pre.y) {//向下移动
////             DbLog(@"向下");
////            angleA = -fabs(arcConA);
////        }else if(nxt.y==pre.y)
////        {
////            if (nxt.y<pic.y) {//
////                DbLog(@"最上方");
////                if (nxt.x<pre.x) {
////                    DbLog(@"向左");
////                    angleA = -fabs(arcConA);
////                }else
////                {
////                    DbLog(@"向右");
////                    angleA = fabs(arcConA);
////                }
////            }else
////            {
////                DbLog(@"最下方");
////                if (nxt.x<pre.x) {
////                    DbLog(@"向左");
////                    
////                    angleA = fabs(arcConA);
////                }else
////                {
////                    DbLog(@"向右");
//                    angleA = -fabs(arcConA);
//                }
//            }
//        }else if(nxt.y<pre.y)
//        {
//             DbLog(@"向上");
//            angleA = fabs(arcConA);
//        }
//    }
    DbLog(@"angleA %f",angleA);
    self.transform = CGAffineTransformRotate(self.transform, angleA);

}
@end
