/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020 shrtlist
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
    @IBOutlet weak var rowSwitch: UISwitch!

    var numberOfSections: NSInteger = 0
    var isExtraRowShowing: Bool = false

    let kSectionIndexToToggle = 1

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the number of sections in the table view
        numberOfSections = super.numberOfSections(in: super.tableView)
        
        rowSwitch.isOn = false
    }


    // MARK: Target-action methods
    
    @IBAction func toggleValueChanged(_ sender: UISwitch) {
        tableView.beginUpdates()
        
        if sender.isOn {
            // Delete section 1
            tableView.deleteSections(IndexSet(integer: kSectionIndexToToggle), with: UITableView.RowAnimation.fade)
            numberOfSections -= 1
        }
        else {
            // Insert section 1
            tableView.insertSections(IndexSet(integer: kSectionIndexToToggle), with: UITableView.RowAnimation.fade)
            numberOfSections += 1;
        }
        
        tableView.endUpdates()
    }

    @IBAction func toggleHiddenCell(_ sender: UISwitch) {
        tableView.beginUpdates()
        
        if sender.isOn {
            isExtraRowShowing = true
        }
        else {
            isExtraRowShowing = false
        }
        
        tableView.endUpdates()
    }

    // MARK: UITableViewDataSource protocol conformance

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight = tableView.rowHeight
        
        if (indexPath.section == 0) && (indexPath.row == 1) // This is the cell to hide - change as you need
        {
            if (!isExtraRowShowing) {
                // Hide the cell by setting its row height to zero
                rowHeight = 0
            }
        }
        return rowHeight
    }

    // MARK: UITableViewDelegate protocol conformance

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
