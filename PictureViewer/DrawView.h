//
//  DrawView.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/7.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
//@property (nonatomic,strong)NSMutableArray *lines;
@property (nonatomic,strong)UIImage *bgImage;
@property (nonatomic,retain)UIColor *color;
@property (nonatomic,assign)BOOL erase;
@property (nonatomic,assign)CGFloat scale;
//可通过sb或者xib方法添加本视图

//需要回退时调用这个方法
-(void)unDo;
//需要恢复时调用这个方法
-(void)reDo;
//取涂鸦内容为图片
- (UIImage *)getImage;
@end
