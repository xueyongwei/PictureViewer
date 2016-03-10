//
//  XimgView.h
//  PictureViewer
//
//  Created by xueyongwei on 16/3/10.
//  Copyright © 2016年 xueyongwei. All rights reserved.
//
#import <UIKit/UIKit.h>
@class XimgView;
@protocol XimgViewDelegate
-(void)xFocusChange:(XimgView *)view;
@end

@interface XimgView : UIView
@property (nonatomic,assign)BOOL xFocused;
@property (nonatomic,strong)UIImage *img;
@property (nonatomic,weak) id delegate;
@end

