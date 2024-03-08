//


import UIKit

protocol FollowerListVCDelegate: AnyObject {
	func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
	var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
	
	init(username: String) {
		super.init(nibName: nil, bundle: nil)
		self.username   = username
		title           = username
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavButton))
		navigationItem.rightBarButtonItem = addButton
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)) // to fill the whole screen
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        #warning("Empty Follower View shouldn't have search bar")
//        if followers.isEmpty { return }
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self // set the delegate
        searchController.searchBar.placeholder = "Search for a username"
//        searchController.obscuresBackgroundDuringPresentation = false // black overlay
//        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
		isLoadingMoreFollowers = true
		
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in // NetworkManager has strong ref to UIViewController if without [weak self]
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers) // adds the elements of a sequence to the end of the array.
                    
                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers. Go follow them 😃."
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                    self.updateData(on: self.followers)
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad", message: error.rawValue, buttonTitle: "Ok")
            }
			
			self.isLoadingMoreFollowers = false
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>() // snapshot for different data
        snapshot.appendSections([.main]) // why?
        snapshot.appendItems(followers) // to add data into snapshot
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) } // to add snapshots into datasource
    }
	
	@objc func addToFavButton() {
//		print(#function, "[\(Self.self)]")
		showLoadingView()
		
		NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
			guard let self = self else { return }
			self.dismissLoadingView()
			
			switch result {
				case .success(let user):
					let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
					
					PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
						guard let self = self else { return }
						
						guard let error = error else {
							self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favourited this user 🎉", buttonTitle: "Hooray!")
							return
						}
						
						self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
					}
					
				case .failure(let error):
					self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
			}
		}
	}
}

extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y // because doing vertical scroll view
        let contentHeight = scrollView.contentSize.height // height of entire scroll view
        let height        = scrollView.frame.size.height // height of screen
        
        if offsetY > contentHeight - height { // check when scroll to bottom
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { // when select an item
//        let follower = (isSearching ? filteredFollowers : followers)[indexPath.item]
        guard let follower = dataSource.itemIdentifier(for: indexPath) else { return } // to get the data of selected item
        
        let destVC 			= UserInfoVC() // destination view controller
        destVC.username 	= follower.login
		destVC.delegate		= self
        let navController 	= UINavigationController(rootViewController: destVC) // navigation on top
        present(navController, animated: true) // .sheet
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) { // when searching
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else {
			filteredFollowers.removeAll()
            updateData(on: followers)
            return
        }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filterText.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension FollowerListVC: FollowerListVCDelegate {
	func didRequestFollowers(for username: String) {
		self.username   = username
		title           = username
		page            = 1
		followers.removeAll()
		filteredFollowers.removeAll()
		collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true) // auto scroll first row
		getFollowers(username: username, page: page)
	}
}
