//
//  CellStyleValue1.m
//  ToDoTaskList
//
//  Created by Corinne Krych on 5/31/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import "CellStyleValue1.h"

@implementation CellStyleValue1

@synthesize myTextLabel = _myTextLabel;
@synthesize myDetailTextLabel = _myDetailTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        
        _myTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];       
        [self.contentView addSubview:_myTextLabel];
        _myDetailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_myDetailTextLabel];
        _myDetailTextLabel.textAlignment = UITextAlignmentRight;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
	CGRect bounds = CGRectInset(self.contentView.bounds, 8, 8);
    _myTextLabel.frame = bounds;
    _myDetailTextLabel.frame = bounds;
}
@end
