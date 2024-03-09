//


import UIKit

class FavouritesListVC: UIViewController {
	let tableView            	= UITableView()
	var favourites: [Follower]	= []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavourites()
	}
	
	func configureViewController() {
		view.backgroundColor    = .systemBackground
		title                   = "Favourites"
		navigationController?.navigationBar.prefersLargeTitles = true // also needed in here because in different tab bar
	}
	
	func configureTableView() {
		view.addSubview(tableView)
		
		tableView.frame         = view.bounds // fill the whole screen
		tableView.rowHeight     = 80
		tableView.delegate      = self
		tableView.dataSource    = self
		tableView.removeExcessCells()
		
		tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
	}
	
	func getFavourites() {
		PersistenceManager.retrieveFavourites { [weak self] result in
			guard let self = self else { return }
			
			switch result {
				case .success(let favourites):
					if favourites.isEmpty {
						self.showEmptyStateView(with: "No Favourites?\nAdd one on the follower screen.", in: self.view)
					} else  {
						self.favourites = favourites
						DispatchQueue.main.async {
							self.tableView.reloadData()
							self.view.bringSubviewToFront(self.tableView) // to cover empty state view if it comes first
						}
					}
					
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

extension FavouritesListVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // rows in array
		return favourites.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID) as! FavouriteCell
		let favourite = favourites[indexPath.row] // e.g. favourites[1]
		cell.set(favourite: favourite)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // when selected the item
		let favorite    = favourites[indexPath.row]
		let destVC      = FollowerListVC(username: favorite.login)
		
//		navigationController?.pushViewController(destVC, animated: true)
		show(destVC, sender: self)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // to delete the row
		guard editingStyle == .delete else { return } // if not doing delete then don't do anything
		
		PersistenceManager.updateWith(favourite: favourites[indexPath.row], actionType: .remove) { [weak self] error in
			guard let self = self else { return }
			guard let error = error else {
				self.favourites.remove(at: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .left)
				return
			}
			self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
		}
	}
}
