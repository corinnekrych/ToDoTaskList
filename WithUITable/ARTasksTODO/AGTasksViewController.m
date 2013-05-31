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

// TODO to move to AGToDoAPIService
- (void) retrieveDataFromAeroGearTODO {
    id<AGAuthenticationModule> authModule;
    // NSURL object:
    NSURL* projectsURL = [NSURL URLWithString:@"http://todo-aerogear.rhcloud.com/todo-server/"];
    
    AGAuthenticator* authenticator = [AGAuthenticator authenticator];
    authModule = [authenticator auth:^(id<AGAuthConfig> config) {
        [config setName:@"myModule"];
        [config setBaseURL:projectsURL];
    }];
    
    id<AGPipe> tasksPipe;
    
    // create the 'todo' pipeline, which contains the 'projects' pipe:
    AGPipeline *todo = [AGPipeline pipelineWithBaseURL:projectsURL];    // [4]
    
    tasksPipe = [todo pipe:^(id<AGPipeConfig> config) {                 // [5]
        [config setName:@"tasks"];
        [config setAuthModule:authModule];
    }];
    
    [authModule login:@"john" password:@"123" success:^(id object) {    // [6]
        
        [tasksPipe read:^(id responseObject) {                          // [7]
            
            _tasks = responseObject;                                    // [8]
            
            [self.tableView reloadData];                                // [9]
            
        }
                failure:^(NSError *error) {
                    NSLog(@"An error has occured during fetch! \n%@", error);
                }];}
     
              failure:^(NSError *error) {
                  NSLog(@"Auth:%@", error);
              }];
}

- (void)viewDidLoad
{
    NSLog(@"AGTasksView controller viewDidLoad");
    [super viewDidLoad];
    [self retrieveDataFromAeroGearTODO];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [_tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Where we configure the cell in each row
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    //cell.textLabel.text = [_tasks objectAtIndex:indexPath.row];
    
    NSUInteger row = [indexPath row];
    
    cell.textLabel.text = [[_tasks objectAtIndex:row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    //TODO
    //AGTask *task = [_tasks objectAtIndex:row];
    id task = [_tasks objectAtIndex:row];
    
    AGTaskViewController *taskController = [[AGTaskViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //taskController.delegate = self;
    taskController.task = task;
    
    UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: NO];
    
	[self.navigationController pushViewController:taskController animated:NO];//YES];
    
    [UIView commitAnimations];
}

@end
