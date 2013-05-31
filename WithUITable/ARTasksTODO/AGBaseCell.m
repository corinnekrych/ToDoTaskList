//
//  AGBaseCell.m
//  ARTasksTODO
//
//  Created by Corinne Krych on 5/29/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import "AGBaseCell.h"

@implementation AGBaseCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (id)cellForTableView:(UITableView *)tableView {
    NSString *cellID = [self cellIdentifier];
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithCellIdentifier:cellID];
    }
    return cell;
}


- (id)initWithCellIdentifier:(NSString *)cellID {
    return [self initWithStyle:UITableViewCellStyleSubtitle
               reuseIdentifier:cellID];
}


@end
