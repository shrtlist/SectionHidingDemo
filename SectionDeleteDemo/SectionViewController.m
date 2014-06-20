/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 shrtlist
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "SectionViewController.h"

@interface SectionViewController () // Class extension
@property (nonatomic, weak) IBOutlet UILabel *cellLabel;
@property (nonatomic, weak) IBOutlet UISwitch *rowSwitch;
@end

@implementation SectionViewController
{
    NSInteger _numberOfSections;
    BOOL _isExtraRowShowing;
}

static const NSUInteger kSectionIndexToToggle = 1;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Get the number of sections in the table view
    _numberOfSections = [super numberOfSectionsInTableView:[super tableView]];
    
    self.rowSwitch.on = NO;
}

#pragma mark - Target-action method

- (IBAction)toggleValueChanged:(id)sender
{
    UISwitch *toggleSwitch = (UISwitch *)sender;
    
    [self.tableView beginUpdates];
    
    if (toggleSwitch.on)
    {
        // Delete section 1
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:kSectionIndexToToggle] withRowAnimation:UITableViewRowAnimationFade];
        _numberOfSections--;
    }
    else
    {
        // Insert section 1
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:kSectionIndexToToggle] withRowAnimation:UITableViewRowAnimationFade];
        _numberOfSections++;
    }
    
    [self.tableView endUpdates];
}

- (IBAction)toggleHiddenCell:(id)sender
{
    [self.tableView beginUpdates];
    
    UISwitch *toggleSwitch = (UISwitch *)sender;
    
    if (toggleSwitch.on)
    {
        _isExtraRowShowing = YES;
    }
    else
    {
        _isExtraRowShowing = NO;
    }
    
    [self.tableView endUpdates];
}

#pragma mark - UITableViewDataSource protocol conformance

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = tableView.rowHeight;
    
    if ((indexPath.section == 0) && (indexPath.row == 1)) // This is the cell to hide - change as you need
    {
        if (!_isExtraRowShowing)
        {
            rowHeight = 0; // Hide the cell
        }
    }
    return rowHeight;
}

#pragma mark - UITableViewDelegate protocol conformance

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
