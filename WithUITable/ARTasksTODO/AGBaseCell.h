//
//  AGBaseCell.h
//  ARTasksTODO
//
//  Created by Corinne Krych on 5/29/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGBaseCell : UITableViewCell

+ (id)cellForTableView:(UITableView *)tableView;
+ (NSString *)cellIdentifier;

- (id)initWithCellIdentifier:(NSString *)cellID;

@end
