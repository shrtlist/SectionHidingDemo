//
//  SectionViewController.m
//  SectionDeleteDemo
//
//  Created by Marco Abundo on 9/16/13.
//  Copyright (c) 2013 Your company. All rights reserved.
//

#import "SectionViewController.h"

@implementation SectionViewController
{
    NSInteger numberOfSections;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Get the number of sections in the table view
    numberOfSections = [super numberOfSectionsInTableView:[super tableView]];
}

#pragma mark - Target-action method

- (IBAction)toggleValueChanged:(id)sender
{
    UISwitch *toggleSwitch = (UISwitch *)sender;
    
    [self.tableView beginUpdates];
    
    if (toggleSwitch.on)
    {
        // Delete section 1
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        
        numberOfSections--;
    }
    else
    {
        // Insert section 1
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        
        numberOfSections++;
    }
    
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource protocol conformance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numberOfSections;
}

@end
