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
    let searchViewRijks = SearchViewRijks()
    let searchViewTM = SearchViewTM()
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
        switch state {
        case .rijks:
            view = searchViewRijks
        default:
            view = searchViewTM
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureSearchController()
        configureCollectionView()
        configure()
        searchViewRijks.collectionViewRijks.delegate = self
        searchViewTM.collectionViewTM.delegate = self
    }
    
    private func configureCollectionView()  {
        switch state {
        case .rijks:
            searchViewRijks.collectionViewRijks.register(RijksCell.self, forCellWithReuseIdentifier: RijksCell.reuseIdentifier)
        case .ticketMaster:
            searchViewTM.collectionViewTM.register(TicketMasterCell.self, forCellWithReuseIdentifier: TicketMasterCell.reuseIdentifier)
        }
    }
    
    private func configureSearchController()    {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
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
        dataSourceRijks = UICollectionViewDiffableDataSource<Section, ArtObject>(collectionView: searchViewRijks.collectionViewRijks, cellProvider: { (collectionView, indexPath, artItem) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RijksCell.reuseIdentifier, for: indexPath) as? RijksCell else {
                fatalError()
            }
            
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
        dataSourceTM = UICollectionViewDiffableDataSource<Section, Event>(collectionView: searchViewTM.collectionViewTM, cellProvider: { (collectionView, indexPath, event) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketMasterCell.reuseIdentifier, for: indexPath) as? TicketMasterCell else {
                fatalError()
            }
            
            let url = URL(string: event.images.first?.url ?? "")
            let startDateString = event.dates.start.localTime
            let endDateString = event.dates.end?.localTime
            
            let specificStartTime = event.dates.start.noSpecificTime
            let specificEndTime = event.dates.end?.noSpecificTime
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            
            let startDate = dateFormatter.date(from: startDateString ?? "")
            let endDate = dateFormatter.date(from: endDateString ?? "")
            dateFormatter.dateFormat = "h:mm a"
            let dateTwelve = dateFormatter.string(from: startDate ?? Date())
            let endDateTwelve = dateFormatter.string(from: endDate ?? Date())
            
            cell.backgroundColor = .systemRed
            cell.eventNameLabel.text = event.name
            
            if specificStartTime == true {
                cell.startEventTimeLabel.text = "Start Time: N/A"

            } else {
                cell.startEventTimeLabel.text = "Start Time: " + dateTwelve
            }
            
            if let sET = specificEndTime {
                if sET == true {
                    cell.endEventTimeLabel.text = "End Time: N/A"
                } else {
                    cell.endEventTimeLabel.text = "End Time: " + endDateTwelve
                }
            } else {
                cell.endEventTimeLabel.text = "End Time: N/A"
            }
            
            cell.startEventDateLabel.text = "Start Date: " + event.dates.start.localDate
            cell.endEventDateLabel.text = "End Date: \(event.dates.end?.localDate ?? "N/A")"
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "book"), options: [.transition(.fade(0.2)), .cacheOriginalImage], completionHandler:  { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let kfImage):
                    print("\(kfImage.source.url?.absoluteString ?? "")")
                }
            })
            return cell
        })
        
        var snapshot = dataSourceTM.snapshot()
        snapshot.appendSections([.main])
        dataSourceTM.apply(snapshot, animatingDifferences: false)
    }

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
        
        let detailViewRijks = DetailRijksViewController()
        let detailViewTm = DetailTMViewController()
        switch state {
        case .rijks:
            guard let artItem = dataSourceRijks.itemIdentifier(for: indexPath) else {
                fatalError()
            }
            detailViewRijks.currentArtItem = artItem
            self.navigationController?.pushViewController(detailViewRijks, animated: true)

        default:
            guard let eventItem = dataSourceTM.itemIdentifier(for: indexPath) else {
                fatalError()
            }
            detailViewTm.tmEvent = eventItem
            self.navigationController?.pushViewController(detailViewTm, animated: true)
        }
        
    }
}
