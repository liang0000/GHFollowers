//


import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() } // to present in main thread, every time updating UI have to do it on main thread
    }

    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero) // remove empty cell
    }
}
