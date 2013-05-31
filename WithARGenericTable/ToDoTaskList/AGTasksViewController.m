//
//  AGViewController.m
//  ARTasksTODO
//
//  Created by Corinne Krych on 5/27/13.
//  Copyright (c) 2013 corinne Krych. All rights reserved.
//

#import "AGTasksViewController.h"
#import "AGTaskViewController.h"
#import <AeroGear/AeroGear.h>    

@interface AGTasksViewController ()

@end

@implementation AGTasksViewController {
    NSMutableArray *_tasks;
}

- (id)init {
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) retrieveDataFromAeroGearTODO {
    id<AGAuthenticationModule> authModule;
    NSURL* projectsURL = [NSURL URLWithString:@"http://todo-aerogear.rhcloud.com/todo-server/"];
    
    AGAuthenticator* authenticator = [AGAuthenticator authenticator];
    authModule = [authenticator auth:^(id<AGAuthConfig> config) {
        [config setName:@"myModule"];
        [config setBaseURL:projectsURL];
    }];
    
    id<AGPipe> tasksPipe;
    
    // create the 'todo' pipeline, which contains the 'projects' pipe:
    AGPipeline *todo = [AGPipeline pipelineWithBaseURL:projectsURL];    
    
    tasksPipe = [todo pipe:^(id<AGPipeConfig> config) {                 
        [config setName:@"tasks"];
        [config setAuthModule:authModule];
    }];
    
    [authModule login:@"john" password:@"123" success:^(id object) {    
        
        [tasksPipe read:^(id responseObject) {                          
            
            _tasks = responseObject;
            
            ARTableViewData *tableViewData = [[ARTableViewData alloc] initWithSectionDataArray:@[[self sampleSectionData]]];
            self.tableViewData = tableViewData;         
        }
                failure:^(NSError *error) {
                    NSLog(@"An error has occured during fetch! \n%@", error);
                }];}
     
              failure:^(NSError *error) {
                  NSLog(@"Auth:%@", error);
              }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveDataFromAeroGearTODO];    
}

- (ARSectionData *)sampleSectionData {
    // configure the section
    ARSectionData *sectionData = [[ARSectionData alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    // configure the cell
    for (id task in _tasks) {
        ARCellData *cellData = [[ARCellData alloc] initWithIdentifier:NSStringFromClass([UITableViewCell class])];
       
        [cellData setCellConfigurationBlock:^(UITableViewCell *cell) {
            // called in cellForRowAtIndexpath
            cell.textLabel.text = [task objectForKey:@"title"];
        }];
        
        [cellData setCellSelectionBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            AGTaskViewController *taskController = [[AGTaskViewController alloc] initWithStyle:UITableViewStyleGrouped];
            taskController.task = task;
            
            UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
            [UIView beginAnimations: nil context: nil];
            [UIView setAnimationDuration:0.4];
            [UIView setAnimationTransition: trans forView: [self.view window] cache: NO];
            
            [self.navigationController pushViewController:taskController animated:NO];
            
            [UIView commitAnimations];

        }];
        
        [sectionData addCellData:cellData];
    }
    
    return sectionData;
}

@end
