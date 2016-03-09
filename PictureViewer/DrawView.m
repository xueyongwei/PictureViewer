//
//  DrawView.m
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import "DrawView.h"
#import "Line.h"
#import <CoreGraphics/CoreGraphics.h>

@interface DrawView()
///涂鸦的位置
@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGPoint endPoint;
@end

@implementation DrawView
{
    CGPoint pre;
    CGPoint nxt;
    NSMutableArray *lines;//所有短线数组
    NSMutableArray *preViousLines;//所有组短线数组
    NSMutableArray *currentLines;//当前短线数组
}

//@synthesize lines;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadInit];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self loadInit];
    }
    return self;
}
-(void)loadInit
{
    _color = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
    lines = [[NSMutableArray alloc]init];
    preViousLines = [[NSMutableArray alloc]init];
    _scale = 0.5;
    
    _startPoint.x = 0;
    _startPoint.y = 0;
    _endPoint.x = 0;
    _endPoint.y = 0;
}
#pragma mark 触摸手势
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //新建一个数组存放本组手势点
    
    currentLines = [[NSMutableArray alloc]init];
    UITouch *touch = [touches anyObject];
    
    pre = [touch previousLocationInView:self];
    nxt = [touch locationInView:self];
    
    Line *line = [[Line alloc]init];
    line.begin = pre;
    line.end = nxt;
    line.drawColor = _color;
    
    
    
    [currentLines addObject:line];
    [lines addObject:line];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //记录这个点到手势点数组里面
    UITouch *touch = [touches anyObject];
    
    pre = [touch previousLocationInView:self];
    nxt = [touch locationInView:self];
    
    _startPoint.x = nxt.x<_startPoint.x?nxt.x:_startPoint.x;
    _startPoint.y = nxt.y<_startPoint.y?nxt.y:_startPoint.y;
    _endPoint.x = nxt.x>_endPoint.x?nxt.x:_endPoint.x;
    _endPoint.y = nxt.y>_endPoint.y?nxt.y:_endPoint.y;
    
    
    NSLog(@"_startPoint %@",NSStringFromCGPoint(_startPoint));
    NSLog(@"_endPoint %@",NSStringFromCGPoint(_endPoint));
    Line *line = [[Line alloc]init];
    line.begin = pre;
    line.end = nxt;
    if (self.erase) {
        line.drawColor = [UIColor clearColor];
    }else
    {
        line.drawColor = _color;
    }
    
    [lines addObject:line];
    
    [currentLines addObject:line];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    pre = [touch previousLocationInView:self];
    nxt = [touch locationInView:self];
    
    Line *line = [[Line alloc]init];
    line.begin = pre;
    line.end = nxt;
    line.drawColor = _color;
    
    //把本组手势添加到lin数组里
    [lines addObject:line];
    [preViousLines addObject:currentLines];
    currentLines = nil;
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self touchesEnded:touches withEvent:event];
}
-(void)backDraw
{
    for (Line *line in preViousLines.lastObject) {//把最后一组短线从所有短线数组里删除
        [lines removeObject:line];
    }
    //再把短线组的数组最后一个元素删除
    [preViousLines removeLastObject];
    //    [lines removeLastObject];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 4.0);
    
    for (Line *line in lines) {
        
        CGContextSetStrokeColorWithColor(context, line.drawColor.CGColor);
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(context,line.end.x, line.end.y);
//        if (line.drawColor == [UIColor clearColor]) {
//            
//            CGContextClearRect(context, CGRectMake(line.begin.x<line.end.x?line.begin.x:line.end.x, line.begin.y<line.end.y?line.begin.y:line.end.y, fabs(line.begin.x-line.end.x), fabs(line.begin.y-line.end.y)));
//            
//        }else
//        {
//            
//        }
        CGContextStrokePath(context);
    }
    
}

- (UIImage *)getImage {
    
    NSLog(@"图片位置：startPoint = (%f, %f), endPoint = (%f, %f)", _startPoint.x, _startPoint.y, _endPoint.x, _endPoint.y);
    
    CGRect imageFrame = CGRectMake(_startPoint.x - 4, 0, _endPoint.x - _startPoint.x + 4 * 2, self.bounds.size.height);
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    ///只裁剪用户有涂鸦的部分
    CGContextBeginPath(context);
    CGContextAddRect(context, imageFrame);
    CGContextClip(context);
    
    // 将控制器view的layer渲染到上下文
    [self.layer renderInContext:context];
    
    // 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
    //    return newImage;
    ///这个时候出来的image是跟self的frame一样大的view, 但图片数据是真实涂鸦那和大，旁边都是透明的，所以要进行剪切
    UIImage *realImage = [self cropImage:newImage withCropRect:imageFrame];
    
    return realImage;
}


///裁剪成目标大小的图片(旁边没有留白)
- (UIImage *)cropImage:(UIImage *)image withCropRect:(CGRect)cropRect {
    CGPoint origin;
    NSLog(@" begin = %@",NSStringFromCGSize(image.size));
    NSLog(@"cropRect %@",NSStringFromCGRect(cropRect));
    origin = CGPointMake(-cropRect.origin.x, - cropRect.origin.y);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(cropRect.size.width * _scale, cropRect.size.height * _scale) , NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeScale(_scale, _scale));
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@" end = %@",NSStringFromCGSize(image.size));
    UIGraphicsEndImageContext();
    
    return image;
}


@end
