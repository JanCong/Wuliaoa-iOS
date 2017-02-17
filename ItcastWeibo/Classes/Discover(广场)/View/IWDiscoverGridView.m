//
//  IWDiscoverGridView.m
//  Wuliaoa
//
//  Created by MJ Lee on 14-5-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWDiscoverGridView.h"

@interface IWDiscoverGridView()
@property (strong, nonatomic) NSMutableArray *horizontalLines;
@property (strong, nonatomic) NSMutableArray *verticalLines;
@property (strong, nonatomic) NSMutableArray *buttons;
@end

@implementation IWDiscoverGridView

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)horizontalLines
{
    if (_horizontalLines == nil) {
        _horizontalLines = [NSMutableArray array];
    }
    return _horizontalLines;
}

- (NSMutableArray *)verticalLines
{
    if (_verticalLines == nil) {
        _verticalLines = [NSMutableArray array];
    }
    return _verticalLines;
}

+ (instancetype)gridView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        for (int i = 0; i<2; i++) {
            [self.horizontalLines addObject:[self addLine]];
        }
        
        for (int i = 0; i<2; i++) {
            [self.verticalLines addObject:[self addLine]];
        }
        
        for (int i = 0; i<4; i++) {
            UIButton *btn = [[UIButton alloc] init];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setBackgroundImage:[UIImage resizedImageWithName:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
            [self addSubview:btn];
            [self.buttons addObject:btn];
        }
    }
    return self;
}

- (UIView *)addLine
{
    UIView *line = [[UIView alloc] init];
    line.alpha = 0.15;
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    return line;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 分割线间距
    CGFloat lineMargin = 8;
    
    // 水平分割线
    CGFloat horizontalLineW = (self.frame.size.width / self.horizontalLines.count) - 2 * lineMargin;
    CGFloat horizontalLineH = 1;
    CGFloat horizontalLineY = self.frame.size.height * 0.5;
    for (int i = 0; i<self.horizontalLines.count; i++) {
        UIView *line = self.horizontalLines[i];
        CGFloat horizontalLineX = lineMargin + i * (lineMargin * 2 + horizontalLineW);
        line.frame = CGRectMake(horizontalLineX, horizontalLineY, horizontalLineW, horizontalLineH);
    }
    
    // 垂直分割线
    CGFloat verticalLineW = 1;
    CGFloat verticalLineH = (self.frame.size.height / self.verticalLines.count) - 2 * lineMargin;
    CGFloat verticalLineX = self.frame.size.width * 0.5;
    for (int i = 0; i<self.verticalLines.count; i++) {
        UIView *line = self.verticalLines[i];
        CGFloat verticalLineY = lineMargin + i * (lineMargin * 2 + verticalLineH);
        line.frame = CGRectMake(verticalLineX, verticalLineY, verticalLineW, verticalLineH);
    }
    
    // 按钮
    int maxColumns = 2;
    CGFloat buttonW = self.frame.size.width * 0.5;
    CGFloat buttonH = self.frame.size.height * 0.5;
    for (int i = 0; i<self.buttons.count; i++) {
        UIButton *btn = self.buttons[i];
        CGFloat buttonX = (i % maxColumns) * buttonW;
        CGFloat buttonY = (i / maxColumns) * buttonH;
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, lineMargin, 0, 0);
    }
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImageWithName:@"common_card_background"] drawInRect:rect];
}

- (void)setGridData:(NSArray *)gridData
{
    _gridData = gridData;
    
    for (int i = 0; i<gridData.count; i++) {
        UIButton *btn = self.buttons[i];
        [btn setTitle:[NSString stringWithFormat:@"#%@#", gridData[i]] forState:UIControlStateNormal];
    }
}

@end
