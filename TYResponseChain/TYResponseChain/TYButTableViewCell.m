//
//  TYButTableViewCell.m
//  TYResponseChain
//
//  Created by 汤义 on 2018/8/31.
//  Copyright © 2018年 汤义. All rights reserved.
//

#import "TYButTableViewCell.h"
@interface TYButTableViewCell ()
@property (nonatomic, weak) UILabel *lbl;
@property (nonatomic, weak) UIButton *but;
@property (nonatomic, assign) int i;
@end
@implementation TYButTableViewCell
+(TYButTableViewCell *)addTableViewCell:(UITableView *)tableView{
    static NSString *ID = @"cell";
    TYButTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TYButTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        [cell initView];
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    return cell;
}

- (void)initView{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(10, 0, 40, 44);
    but.backgroundColor = [UIColor redColor];
    [but setImage:[UIImage imageNamed:@"add_choose_But"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(selectorBut) forControlEvents:UIControlEventTouchUpInside];
    but.userInteractionEnabled = YES;
    [self addSubview:but];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 80, 20)];
    lbl.backgroundColor = [UIColor yellowColor];
    [self addSubview:_lbl = lbl];
}

- (void)selectorBut {
    _i ++;
    _lbl.text = [NSString stringWithFormat:@"这:%d",_i];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
