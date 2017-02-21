//
//  DoodleView.m
//  Doodle
//
//  Created by yy c on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.multipleTouchEnabled = YES;
        _lineArray = [[NSMutableArray alloc] init];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 420, 120, 40);
        [btn setTitle:@"撤销" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(undoDraw) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        // Initialization code
    }
    return self;
}

- (void)undoDraw//撤销操作
{
    [_lineArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [_lineArray release];
    _lineArray = nil;
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();//获得上下文
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//画笔颜色
    CGContextSetLineWidth(context, 2.0f);//画笔粗细
    for (int i = 0; i < [_lineArray count]; i++) 
    {
        NSMutableArray *pointArray = [_lineArray objectAtIndex:i];
        for(int j = 0; j < [pointArray count] - 1; j++)//
        {
            NSValue *a = [pointArray objectAtIndex:j];
            CGPoint c = [a CGPointValue];
            NSValue *b = [pointArray objectAtIndex:j + 1];
            CGPoint d = [b CGPointValue];
            CGContextMoveToPoint(context, c.x, c.y);
            CGContextAddLineToPoint(context, d.x, d.y);
        }
    }
    CGContextStrokePath(context);
}

//每次开始触摸的时候增加一个新的数组，数组记录划过的点，这些点用于绘画。
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@",touches);
    //UIResponder
    //UITouch
    
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    [_lineArray addObject:pointArray];
    [pointArray release];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSValue *value = [NSValue valueWithCGPoint:point];
    NSMutableArray *pointArray = [_lineArray lastObject];
    [pointArray addObject:value];
    
    [self setNeedsDisplay];//重绘界面
}


@end
