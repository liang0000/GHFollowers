//


import UIKit

class FavoritesListVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
		
		PersistenceManager.retrieveFavourites { result in
			switch result {
				case .success(let favourites):
					print(favourites)
				case .failure(let error):
					break
			}
		}
    }
}
