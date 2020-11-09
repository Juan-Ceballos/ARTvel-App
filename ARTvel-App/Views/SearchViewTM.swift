//
//  SearchViewTM.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 11/9/20.
//

import UIKit

class SearchViewTM: UIView {
    
    public lazy var collectionViewTM: UICollectionView = {
        let layout = createLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        //gray 6
        cv.backgroundColor = .tertiarySystemFill
        return cv
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let itemSpacing: CGFloat = 5
        item.contentInsets = NSDirectionalEdgeInsets(top: itemSpacing, leading: itemSpacing, bottom: itemSpacing, trailing: itemSpacing)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.00), heightDimension: .fractionalHeight(0.33))
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
        addSubview(collectionViewTM)
        collectionViewTM.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}
