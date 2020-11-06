//
//  SearchView.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/29/20.
//

import Foundation
import SnapKit

class SearchView: UIView {
    
    public lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        //gray 6
        cv.backgroundColor = .tertiarySystemFill
        return cv
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemSpacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.00), heightDimension: .fractionalHeight(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

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
