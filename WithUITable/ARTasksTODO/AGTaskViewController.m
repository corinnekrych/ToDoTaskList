//
//  AGTaskViewController.m
//  ARTasksTODO
//
//  Created by Corinne Krych on 5/27/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import "AGTaskViewController.h"
#import "EditCell.h"
#import "TextViewCell.h"
#import "DateSelectionCell.h"
#import "CellStyleValue1.h"

// Table Sections
enum AGTableSections {
    AGTableSectionTitle = 0,
    AGTableSectionDescr,
    AGTableSectionDueProjTag,
    AGTableNumSections
};

// Table Rows
enum AGTitleRows {
    AGTableSecTitleRowTitle = 0,
    AGTableSecTitleNumRows,
};

enum AGDescrRows {
    AGTableSecDescrRowDescr = 0,
    AGTableSecDescrNumRows,
};

enum AGDueProjTagRows {
    AGTableSecDueProjTagRowDue = 0,
    AGTableSecDueProjTagRowProj,
    AGTableSecDueProjTagRowTag,
    AGTableSecDueProjTagNumRows
};

@interface AGTaskViewController ()

@end

@implementation AGTaskViewController {

}

@synthesize task = _task;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
 	[self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return AGTableNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case AGTableSectionTitle:
            return AGTableSecTitleNumRows;
        case AGTableSectionDescr:
            return AGTableSecDescrNumRows;
        case AGTableSectionDueProjTag:
            return AGTableSecDueProjTagNumRows;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    UITableViewCell *cell;
    
    switch (section) {
        case AGTableSectionTitle: {
            EditCell *titleCell = [EditCell cellForTableView:tableView];
            titleCell.txtField.text = self.task[@"title"];
            cell = titleCell;
            break;
        }
        case AGTableSectionDescr:
        {
            TextViewCell *descrCell = [TextViewCell cellForTableView:tableView];           
            if (![self.task[@"description"] isKindOfClass:[NSNull class]])
                descrCell.txtView.text = self.task[@"description"];
            
            cell = descrCell;
            break;
        }
        case AGTableSectionDueProjTag:
        {
            switch (row) {
                case AGTableSecDueProjTagRowDue:
                {
                    DateSelectionCell *dateCell = [[DateSelectionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
                    dateCell.textLabel.text = @"Due Date";
                    dateCell.detailTextLabel.text = self.task[@"date"];
                    
                    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
                    [inputFormat setDateFormat:@"yyyy-MM-dd"];
                    NSDate *inputDate = [inputFormat dateFromString: self.task[@"description"]];
                   
                    dateCell.dateValue = inputDate;
                
                    cell = dateCell;
                    break;
                }
                case AGTableSecDueProjTagRowProj:
                {
                    CellStyleValue1 *dateCell = [CellStyleValue1 cellForTableView:tableView];
                    //dateCell.textLabel.text  = self.task[@"description"];
                    
                    
                    if ([self.task objectForKey:@"project"] != nil) {
                        dateCell.textLabel.text = self.task[@"project"];
                    }
                    cell = dateCell;
                    break;
                }
                case AGTableSecDueProjTagRowTag:
                {
                    CellStyleValue1 *selCell = [CellStyleValue1 cellForTableView:tableView];
                    selCell.textLabel.text = @"Tags";
                    
                    selCell.detailTextLabel.text = self.task[@"tags"];
                    
                    cell = selCell;
                    break;
                }
            }
            
            break;
        }
        
    }
    
    return cell;
}


@end
