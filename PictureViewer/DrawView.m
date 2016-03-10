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
    NSMutableArray *lines;//所有短线数组
    Line *currentLine;
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
    _scale = 0.2;
    
}
#pragma mark 触摸手势
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //新建一个数组存放本组手势点
    [self.undoManager beginUndoGrouping];
    for (UITouch *t in touches) {
        // Create a line for the value
        CGPoint loc = [t locationInView:self];
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setDrawColor:self.color];
        currentLine = newLine;

        if (lines.count==0) {//画板上没有笔迹
            NSLog(@"画板上没有笔迹，本次为第一次涂鸦，初始化图幅。");
            _startPoint = loc;
            _endPoint = loc;
        }

    }
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        [currentLine setDrawColor:self.color];
        CGPoint loc = [t locationInView:self];
        [currentLine setEnd:loc];
        
        if (currentLine) {
            [self addLine:currentLine];
        }
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setDrawColor:self.color];
        currentLine = newLine;
        
        //记录画幅
        _startPoint.x = loc.x<_startPoint.x?loc.x:_startPoint.x;
        _startPoint.y = loc.y<_startPoint.y?loc.y:_startPoint.y;
        _endPoint.x = loc.x>_endPoint.x?loc.x:_endPoint.x;
        _endPoint.y = loc.y>_endPoint.y?loc.y:_endPoint.y;

    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.undoManager endUndoGrouping];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
- (void)unDo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

- (void)reDo
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}
- (void)addLine:(Line*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [lines addObject:line];
    [self setNeedsDisplayInRect:self.frame];
}

- (void)removeLine:(Line*)line
{
    if ([lines containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [lines removeObject:line];
        [self setNeedsDisplayInRect:self.frame];
    }
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (Line *line in lines) {
        CGContextSetStrokeColorWithColor(context, line.drawColor.CGColor);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextMoveToPoint(context, line.begin.x, line.begin.y);
        CGContextAddLineToPoint(context,line.end.x, line.end.y);
        CGContextSetBlendMode(context, line.drawColor == [UIColor clearColor]?kCGBlendModeClear:kCGBlendModeColor);
        CGContextSetLineWidth(context, line.drawColor == [UIColor clearColor]?6.0:5.0);
        CGContextStrokePath(context);
    }
}

- (UIImage *)getImage {
    if (lines.count<1) {
        return nil;
    }
    NSLog(@"图片在drawView中位置：startPoint = (%f, %f), endPoint = (%f, %f)", _startPoint.x, _startPoint.y, _endPoint.x, _endPoint.y);
    
//    CGRect imageFrame = CGRectMake(_startPoint.x - 4, 0, _endPoint.x - _startPoint.x + 4 * 2, self.bounds.size.height);
    CGRect imageFrame = CGRectMake(_startPoint.x-5, _startPoint.y-5, _endPoint.x-_startPoint.x+10, _endPoint.y-_startPoint.y+10);

    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    ///只裁剪用户有涂鸦的部分
    CGContextBeginPath(context);
//    CGContextAddRect(context, imageFrame);
//    CGContextClip(context);

    // 将控制器view的layer渲染到上下文
    [self.layer renderInContext:context];
    
    // 取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束上下文
    UIGraphicsEndImageContext();
//        return newImage;
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
