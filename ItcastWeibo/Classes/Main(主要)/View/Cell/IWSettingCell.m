//
//  IWSettingCell.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSettingCell.h"
#import "IWSettingItem.h"
#import "IWSettingArrowItem.h"
#import "IWSettingSwitchItem.h"
#import "IWSettingCheckItem.h"
#import "IWSettingLabelItem.h"
#import "IWBadgeButton.h"

@interface IWSettingCell()
@property (weak, nonatomic) UITableView *tableView;
/**
 *  子标题
 */
@property (weak, nonatomic) UILabel *subtitleLabel;
/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  打钩
 */
@property (strong, nonatomic) UIImageView *checkView;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;
/**
 *  提醒数字
 */
@property (strong, nonatomic) IWBadgeButton *badgeButton;
@end

@implementation IWSettingCell

- (IWBadgeButton *)badgeButton
{
    if (_badgeButton == nil) {
        _badgeButton = [[IWBadgeButton alloc] init];
    }
    return _badgeButton;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UIImageView *)checkView
{
    if (_checkView == nil) {
        _checkView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_checkmark"]];
    }
    return _checkView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)switchChange
{
    // 存储数据
    IWSettingSwitchItem *switchItem = (IWSettingSwitchItem *)self.item;
    switchItem.on = self.switchView.isOn;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    IWSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 子标题
        UILabel *subtitleLabel = [[UILabel alloc] init];
        subtitleLabel.backgroundColor = [UIColor clearColor];
        subtitleLabel.textColor = [UIColor lightGrayColor];
        subtitleLabel.highlightedTextColor = subtitleLabel.textColor;
        subtitleLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:subtitleLabel];
        self.subtitleLabel = subtitleLabel;
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        // 最右边的详情文字
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.highlightedTextColor = self.detailTextLabel.textColor;
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setItem:(IWSettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];
}

/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageWithName:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
    
    // 3.子标题
    if (self.item.subtitle) {
        self.subtitleLabel.hidden = NO;
        self.subtitleLabel.text = self.item.subtitle;
    } else {
        self.subtitleLabel.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.item.subtitle == nil) return;
    // 设置子标题
    CGSize subtitleSize = [self.item.subtitle sizeWithFont:self.subtitleLabel.font];
    CGFloat subtitleW = subtitleSize.width;
    CGFloat subtitleH = subtitleSize.height;
    CGFloat subtitleX = CGRectGetMaxX(self.textLabel.frame) + 5;
    CGFloat subtitleY = (self.contentView.frame.size.height - subtitleH) * 0.5;
    self.subtitleLabel.frame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleH);
}

- (void)setFrame:(CGRect)frame
{
    if (iOS7) {
        frame.origin.x = IWSettingTableBorder;
        frame.size.width -= 2 * IWSettingTableBorder;
    } else {
        CGFloat x = IWSettingTableBorder - 9;
        frame.origin.x = x;
        frame.size.width -= 2 * x;
    }
    [super setFrame:frame];
}

/**
 *  设置右边的控件
 */
- (void)setupRightView
{
    if (self.item.badgeValue)
    { // 右边显示数字
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    }
    else if ([self.item isKindOfClass:[IWSettingLabelItem class]])
    { // 右边是文字
        self.accessoryView = nil;
        IWSettingLabelItem *labelItem = (IWSettingLabelItem *)self.item;
        self.detailTextLabel.text = labelItem.text;
    }
    else if ([self.item isKindOfClass:[IWSettingSwitchItem class]])
    { // 右边是开关
        IWSettingSwitchItem *switchItem = (IWSettingSwitchItem *)self.item;
        self.switchView.on = switchItem.isOn;
        self.accessoryView = self.switchView;
    }
    else if ([self.item isKindOfClass:[IWSettingArrowItem class]])
    { // 右边是箭头
        self.accessoryView = self.arrowView;
    }
    else if ([self.item isKindOfClass:[IWSettingCheckItem class]])
    { // 右边是打钩
        IWSettingCheckItem *checkItem = (IWSettingCheckItem *)self.item;
        self.accessoryView = checkItem.isChecked ? self.checkView : nil;
    }
    else { // 右边没有东西
        self.accessoryView = nil;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    int totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    if (totalRows == 1) { // 这组就1行
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    } else if (indexPath.row == 0) { // 首行
        bgName = @"common_card_top_background";
        selectedBgName = @"common_card_top_background_highlighted";
    } else if (indexPath.row == totalRows - 1) { // 尾行
        bgName = @"common_card_bottom_background";
        selectedBgName = @"common_card_bottom_background_highlighted";
    } else { // 中行
        bgName = @"common_card_middle_background";
        selectedBgName = @"common_card_middle_background_highlighted";
    }
    self.bg.image = [UIImage resizedImageWithName:bgName];
    self.selectedBg.image = [UIImage resizedImageWithName:selectedBgName];
}

@end
