//
//  SearchViewController.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import UIKit
import FirebaseAuth
import Kingfisher

class SearchViewController: UIViewController {

    private enum Section {
        case main
    }
    
    private enum appState {
        case rijks
        case ticketmaster
    }
    
    let authSession = AuthSession()
    let searchView = SearchView()
    private var searchController: UISearchController!
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, ArtObject>
    private var dataSource: DataSource!
    
    var searchQuery: String = "" {
        didSet {
            fetchSampleArtItems(searchQuery: searchQuery)
        }
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        // forced default art objects
        fetchSampleArtItems(searchQuery: searchQuery)
        
    }
    

    private func configureCollectionView()  {
        searchView.collectionView.register(RijksCell.self, forCellWithReuseIdentifier: RijksCell.reuseIdentifier)
    }
    
    private func configureSearchController()    {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
    }
    // "Rembrandt+van+Rijn"
    // hardcoded search entry for rijk
    private func fetchSampleArtItems(searchQuery: String)  {
        RijksAPIClient.fetchArtObjects(searchQuery: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let artObjects):
                DispatchQueue.main.async {
                    self?.updateSnapshot(artItems: artObjects)
                }
            }
        }
    }
    
    // rijk only
    private func updateSnapshot(artItems: [ArtObject])   {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(artItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureDataSource()  {
        dataSource = UICollectionViewDiffableDataSource<Section, ArtObject>(collectionView: searchView.collectionView, cellProvider: { (collectionView, indexPath, artItem) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RijksCell.reuseIdentifier, for: indexPath) as? RijksCell else {
                fatalError()
            }
            
            cell.backgroundColor = .systemRed
            cell.titleLabel.text = artItem.title
            let url = URL(string: artItem.webImage.url)
            cell.imageView.kf.setImage(with: url)
            return cell
        })
        
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // state of the app
    

}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(searchBar.text ?? "error") + delegate")
        searchQuery = searchBar.text ?? ""
        resignFirstResponder()
    }
}
