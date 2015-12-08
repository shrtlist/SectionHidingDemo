/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2015 shrtlist
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

import UIKit

class SectionViewController: UITableViewController {
    @IBOutlet weak var cellLabel: UILabel?
    @IBOutlet weak var rowSwitch: UISwitch?

    var numberOfSections: NSInteger = 0
    var isExtraRowShowing: Bool = false

    let kSectionIndexToToggle = 1
    
    // MARK: Initialization
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the number of sections in the table view
        numberOfSections = super.numberOfSectionsInTableView(super.tableView)
        
        rowSwitch!.on = false
    }


    // MARK: Target-action methods
    
    @IBAction func toggleValueChanged(sender: UISwitch?) {
        tableView.beginUpdates()
        
        if sender!.on {
            // Delete section 1
            tableView.deleteSections(NSIndexSet(index: kSectionIndexToToggle), withRowAnimation: UITableViewRowAnimation.Fade)
            numberOfSections--
        }
        else {
            // Insert section 1
            tableView.insertSections(NSIndexSet(index: kSectionIndexToToggle), withRowAnimation: UITableViewRowAnimation.Fade)
            numberOfSections++;
        }
        
        tableView.endUpdates()
    }

    @IBAction func toggleHiddenCell(sender: UISwitch?) {
        tableView.beginUpdates()
        
        if sender!.on {
            isExtraRowShowing = true
        }
        else {
            isExtraRowShowing = false
        }
        
        tableView.endUpdates()
    }

// MARK: UITableViewDataSource protocol conformance

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var rowHeight = tableView.rowHeight
        
        if (indexPath.section == 0) && (indexPath.row == 1) // This is the cell to hide - change as you need
        {
            if (!isExtraRowShowing)
            {
                rowHeight = 0 // Hide the cell
            }
        }
        return rowHeight
    }

    // MARK: UITableViewDelegate protocol conformance

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
