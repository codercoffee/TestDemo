//
//  QRView.m
//  二维码扫描
//
//  Created by wk on 15/12/22.
//  Copyright © 2015年 wk. All rights reserved.
//

#import "QRView.h"
#import "UIScreen+Extension.h"

// RGB颜色
#define COLOR(R ,G ,B ,A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

static NSTimeInterval kQrLineanimateDuration = 0.01;

@interface QRView ()
{
    BOOL upOrdown;
    UIImageView *qrBox;
    UIImageView *qrLine;
    CGFloat qrLineY;
}

@end

@implementation QRView

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (!qrBox) {
        
        [self initQRBox];
    }
    
    if (!qrLine) {
        
        [self initQRLine];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:kQrLineanimateDuration target:self selector:@selector(show) userInfo:nil repeats:YES];
        [timer fire];
    }
    
}

- (void)initQRBox {
    
    CGRect screenBounds = [UIScreen screenBounds];
    qrBox = [[UIImageView alloc]initWithFrame:CGRectMake(screenBounds.size.width / 2 - self.transparentArea.width / 2,
                                                         screenBounds.size.height / 2 - self.transparentArea.height / 2,
                                                         self.transparentArea.width,
                                                         self.transparentArea.height)];
    qrBox.image = [UIImage imageNamed:@"扫码框"];
    qrBox.backgroundColor = [UIColor clearColor];
    [self addSubview:qrBox];
    
}

- (void)initQRLine {
    
    
    CGRect screenBounds = [UIScreen screenBounds];
    qrLine  = [[UIImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width / 2 - self.transparentArea.width / 2 + 4,
                                                            screenBounds.size.height / 2 - self.transparentArea.height / 2,
                                                            self.transparentArea.width - 8,
                                                            2)];
    qrLine.image = [UIImage imageNamed:@"扫描线"];
    qrLine.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:qrLine];
    
    qrLineY = qrLine.frame.origin.y;
    
}


- (void)show {
    
    [UIView animateWithDuration:kQrLineanimateDuration animations:^{
        
        CGRect rect = qrLine.frame;
        rect.origin.y = qrLineY;
        qrLine.frame = rect;
        
    } completion:^(BOOL finished) {
        
        CGFloat minBorder = self.frame.size.height / 2 - self.transparentArea.height / 2 ;
        CGFloat maxBorder = self.frame.size.height / 2 + self.transparentArea.height / 2 - 4;
        
        qrLineY ++;
        if (qrLineY > maxBorder) {
            
            qrLineY = minBorder;
        }
        
//        if (upOrdown == NO) {
//            qrLineY ++;
//            if (qrLineY > maxBorder) {
//                upOrdown = YES;
//            }
//        }
//        else {
//            qrLineY --;
//            if (qrLineY < minBorder) {
//                upOrdown = NO;
//            }
//        }
        
    }];
    
    
}



- (void)drawRect:(CGRect)rect {
    
    //整个二维码扫描界面的颜色
    CGSize screenSize = [UIScreen screenBounds].size;
    CGRect screenDrawRect = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    //中间清空的矩形框
    CGRect clearDrawRect = CGRectMake(screenDrawRect.size.width / 2 - self.transparentArea.width / 2,
                                      screenDrawRect.size.height / 2 - self.transparentArea.height / 2,
                                      self.transparentArea.width,
                                      self.transparentArea.height);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self addScreenFillRect:ctx rect:screenDrawRect];
    
    [self addCenterClearRect:ctx rect:clearDrawRect];
    
//    [self addWhiteRect:ctx rect:clearDrawRect];

//    [self addCornerLineWithContext:ctx rect:clearDrawRect];
    
    
}

// 透明层
- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextSetRGBFillColor(ctx, 40 / 255.0, 40 / 255.0, 40 / 255.0, 0.5);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
}

// 扫描区域
- (void)addCenterClearRect :(CGContextRef)ctx rect:(CGRect)rect {
    
    CGContextClearRect(ctx, rect);  //clear the center rect  of the layer
}

// 白色扫描区域框
- (void)addWhiteRect:(CGContextRef)ctx rect:(CGRect)rect {

    CGContextStrokeRect(ctx, rect);
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    CGContextSetLineWidth(ctx, 0.8);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
}

// 边角
- (void)addCornerLineWithContext:(CGContextRef)ctx rect:(CGRect)rect{

    //画四个边角
    CGContextSetLineWidth(ctx, 2);
    CGContextSetRGBStrokeColor(ctx, 38 / 255.0, 91 / 255.0, 170 / 255.0, 1);//绿色

    //左上角
    CGPoint poinsTopLeftA[] = {
        CGPointMake(rect.origin.x + 0.7, rect.origin.y),
        CGPointMake(rect.origin.x + 0.7, rect.origin.y + 15)
    };
    CGPoint poinsTopLeftB[] = {
        CGPointMake(rect.origin.x, rect.origin.y + 0.7),
        CGPointMake(rect.origin.x + 15, rect.origin.y + 0.7)
    };
    [self addLine:poinsTopLeftA pointB:poinsTopLeftB ctx:ctx];

    //左下角
    CGPoint poinsBottomLeftA[] = {
        CGPointMake(rect.origin.x + 0.7, rect.origin.y + rect.size.height - 15),
        CGPointMake(rect.origin.x + 0.7, rect.origin.y + rect.size.height)
    };
    CGPoint poinsBottomLeftB[] = {
        CGPointMake(rect.origin.x, rect.origin.y + rect.size.height - 0.7) ,
        CGPointMake(rect.origin.x + 0.7 + 15, rect.origin.y + rect.size.height - 0.7)
    };
    [self addLine:poinsBottomLeftA pointB:poinsBottomLeftB ctx:ctx];

    //右上角
    CGPoint poinsTopRightA[] = {
        CGPointMake(rect.origin.x + rect.size.width - 15, rect.origin.y + 0.7),
        CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + 0.7 )
    };
    CGPoint poinsTopRightB[] = {
        CGPointMake(rect.origin.x + rect.size.width - 0.7, rect.origin.y),
        CGPointMake(rect.origin.x + rect.size.width - 0.7,rect.origin.y + 15 + 0.7 )
    };
    [self addLine:poinsTopRightA pointB:poinsTopRightB ctx:ctx];
    
    //右下角
    CGPoint poinsBottomRightA[] = {
        CGPointMake(rect.origin.x + rect.size.width - 0.7 , rect.origin.y + rect.size.height - 15),
        CGPointMake(rect.origin.x - 0.7 + rect.size.width,rect.origin.y + rect.size.height )
    };
    CGPoint poinsBottomRightB[] = {
        CGPointMake(rect.origin.x + rect.size.width - 15 , rect.origin.y + rect.size.height - 0.7),
        CGPointMake(rect.origin.x + rect.size.width,rect.origin.y + rect.size.height - 0.7 )
    };
    [self addLine:poinsBottomRightA pointB:poinsBottomRightB ctx:ctx];
    
    CGContextStrokePath(ctx);

}


- (void)addLine:(CGPoint[])pointA pointB:(CGPoint[])pointB ctx:(CGContextRef)ctx {
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
}


@end
