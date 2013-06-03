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
    
    ARTableViewData *tableViewData = [[ARTableViewData alloc] init];
    
    // add the section to the tableView
    [tableViewData addSectionData:[self sectionTitle]];
    [tableViewData addSectionData:[self sectionDescription]];
    [tableViewData addSectionData:[self sectionDueDateProjectTag]];
    
    // setting the tableViewData property will automaticaly reload the tableView
    self.tableViewData = tableViewData;

}

- (ARSectionData *)sectionTitle {
    ARSectionData *sectionData = [[ARSectionData alloc] init];
    [self registerClass:[EditCell class] forCellReuseIdentifier:NSStringFromClass([EditCell class])];
    ARCellData *cellData = [[ARCellData alloc] initWithIdentifier:NSStringFromClass([EditCell class])];
    [cellData setCellConfigurationBlock:^(EditCell *cell) {
        cell.txtField.text = self.task[@"title"];
    }];                
    [sectionData addCellData:cellData];    
    return sectionData;
}

- (ARSectionData *)sectionDescription {
    ARSectionData *sectionData = [[ARSectionData alloc] init];
    [self registerClass:[TextViewCell class] forCellReuseIdentifier:NSStringFromClass([TextViewCell class])];
    ARCellData *cellData = [[ARCellData alloc] initWithIdentifier:NSStringFromClass([TextViewCell class])];
    [cellData setCellConfigurationBlock:^(TextViewCell *cell) {
        cell.txtView.text = self.task[@"description"];
    }];
    
    
    [sectionData addCellData:cellData];
    return sectionData;
}

- (ARSectionData *)sectionDueDateProjectTag {
    ARSectionData *sectionData = [[ARSectionData alloc] init];
    [sectionData addCellData:[self cellDueDate]];
    [sectionData addCellData:[self cellProject]];
    [sectionData addCellData:[self cellTag]];
    return sectionData;
}


- (ARCellData *)cellProject {
    [self registerClass:[CellStyleValue1 class] forCellReuseIdentifier:NSStringFromClass([CellStyleValue1 class])];
    ARCellData *cellData = [[ARCellData alloc] initWithIdentifier:NSStringFromClass([CellStyleValue1 class])];
    [cellData setCellConfigurationBlock:^(CellStyleValue1 *cell) { 
        //[cell setStyle:UITableViewCellStyleValue1];
        cell.textLabel.text = @"Project";
        cell.detailTextLabel.text = self.task[@"project"];
    }];
    return cellData;
}

- (ARCellData *)cellTag {
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    ARCellData *cellData = [[ARCellData alloc] initWithIdentifier:NSStringFromClass([UITableViewCell class])];
    [cellData setCellConfigurationBlock:^(UITableViewCell *cell) {
        cell.textLabel.text = @"Tags";
        cell.detailTextLabel.text = self.task[@"tags"];
    }];    
    return cellData;
}

- (ARCellData *)cellDueDate {
    [self registerClass:[DateSelectionCell class] forCellReuseIdentifier:NSStringFromClass([DateSelectionCell class])];
    ARCellData *cellData = [[ARCellData alloc] initWithIdentifier:NSStringFromClass([DateSelectionCell class])];
    [cellData setCellConfigurationBlock:^(DateSelectionCell *cell) {
        cell.textLabel.text = @"Due Date";
        cell.detailTextLabel.text = self.task[@"date"];
        NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
        [inputFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *inputDate = [inputFormat dateFromString: self.task[@"date"]];
        cell.dateValue = inputDate;
    }];
    return cellData;
}

@end
