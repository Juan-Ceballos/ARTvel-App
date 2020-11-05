//
//  SearchView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/29/20.
//

import Foundation
import SnapKit

class SearchView: UIView {
    
    enum Section: Int, CaseIterable {
        case sectionOne
        case sectionTwo
        case sectionThree
        var rowCount: Int {
            switch self {
            case .sectionOne:
                return 1
            case .sectionTwo:
                return 2
            case .sectionThree:
                return 3
            }
            
        }
    }
    
    public lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemIndigo
        return cv
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemSpacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    private func commonInit()   {
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints()   {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
        
}
