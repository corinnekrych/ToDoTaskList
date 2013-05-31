//
//  AGTitleCell.m
//  ARTasksTODO
//
//  Created by Corinne Krych on 5/27/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import "AGTitleCell.h"

@implementation AGTitleCell

- (id)initWithCellIdentifier:(NSString *)cellID {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    if (self) {
        _txtField = [[UITextField alloc] initWithFrame:CGRectZero];
        _txtField.font = [UIFont boldSystemFontOfSize:16.0];
        _txtField.backgroundColor = [UIColor clearColor];
        _txtField.textAlignment = NSTextAlignmentCenter;
        _txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtField.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:_txtField];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect bounds = CGRectInset(self.contentView.bounds, 8, 8);
    _txtField.frame = bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
