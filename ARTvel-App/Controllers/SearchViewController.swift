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

    var state: AppState.State
    
    init(state: AppState.State) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Section {
        case main
    }
    
    let authSession = AuthSession()
    let searchView = SearchView()
    private var searchController: UISearchController!
    
    private typealias DataSourceRijks = UICollectionViewDiffableDataSource<Section, ArtObject>
    private typealias DataSourceTM = UICollectionViewDiffableDataSource<Section, Event>

    private var dataSourceRijks: DataSourceRijks!
    private var dataSourceTM: DataSourceTM!
    
    var searchQuery: String = "" {
        didSet {
            switch state {
            case .rijks:
                fetchSampleArtItems(searchQuery: searchQuery)
            case .ticketMaster:
                fetchEventItems(searchQuery: searchQuery)
            }
        }
    }
    
    func configure() {
        switch state {
        case .rijks:
            configureDataSourceRijks()
            fetchSampleArtItems(searchQuery: searchQuery)
        case .ticketMaster:
            configureDataSourceTM()
            fetchEventItems(searchQuery: searchQuery)
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
        configure()
        searchView.collectionView.delegate = self
}
    
    private func configureCollectionView()  {
        switch state {
        case .rijks:
            searchView.collectionView.register(RijksCell.self, forCellWithReuseIdentifier: RijksCell.reuseIdentifier)
        case .ticketMaster:
            searchView.collectionView.register(TicketMasterCell.self, forCellWithReuseIdentifier: TicketMasterCell.reuseIdentifier)
        }
    }
    
    private func configureSearchController()    {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func fetchSampleArtItems(searchQuery: String)  {
        RijksAPIClient.fetchArtObjects(searchQuery: searchQuery) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let artObjects):
                DispatchQueue.main.async {
                    self?.updateRijksSnapshot(artItems: artObjects)
                }
            }
        }
    }
    
    private func fetchEventItems(searchQuery: String) {
        TicketMasterAPIClient.fetchEvents(stateCode: searchQuery, city: "", postalCode: "") { [weak self](result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let eventObjects):
                DispatchQueue.main.async {
                    self?.updateTMSnapshot(eventItems: eventObjects)
                }
            }
        }
    }
    
    private func updateRijksSnapshot(artItems: [ArtObject])   {
        var snapshot = dataSourceRijks.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(artItems)
        dataSourceRijks.apply(snapshot, animatingDifferences: false)
    }
    
    private func updateTMSnapshot(eventItems: [Event]) {
        var snapshot = dataSourceTM.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(eventItems)
        dataSourceTM.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureDataSourceRijks()  {
        dataSourceRijks = UICollectionViewDiffableDataSource<Section, ArtObject>(collectionView: searchView.collectionView, cellProvider: { (collectionView, indexPath, artItem) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RijksCell.reuseIdentifier, for: indexPath) as? RijksCell else {
                fatalError()
            }
            
            cell.titleLabel.text = artItem.title
            let url = URL(string: artItem.webImage.url)
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "book"), options: [.transition(.fade(0.2))], completionHandler:  { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let kfImage):
                    print("done \(kfImage.source.url?.absoluteString ?? "")")
                }
            })
            return cell
        })
        
        var snapshot = dataSourceRijks.snapshot()
        snapshot.appendSections([.main])
        dataSourceRijks.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureDataSourceTM() {
        dataSourceTM = UICollectionViewDiffableDataSource<Section, Event>(collectionView: searchView.collectionView, cellProvider: { (collectionView, indexPath, event) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketMasterCell.reuseIdentifier, for: indexPath) as? TicketMasterCell else {
                fatalError()
            }
            
            cell.backgroundColor = .systemRed
            cell.eventNameLabel.text = event.name
            cell.imageView.image = UIImage(systemName: "book")
            //let url = URL(string: event.webImage.url)
            //cell.imageView.kf.setImage(with: url)
            return cell
        })
        
        var snapshot = dataSourceTM.snapshot()
        snapshot.appendSections([.main])
        dataSourceTM.apply(snapshot, animatingDifferences: false)
    }
    
    // state of the app
    /*
     user selects rijks or ticketmaster
     if user selects ticketmaster use ticketmaster api populate api, search based on experience
     */

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

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(DetailViewController(), animated: false)
    }
}
