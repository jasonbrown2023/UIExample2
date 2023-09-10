//
//  CollectionTableViewCell.swift
//  Carousel
//
//  Created by jason brown on 18/06/1402 AP.
//

import UIKit

struct CollectionTableViewCellModel {
    let viewModels: [TileCollectionViewCellViewModel]
}

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionViewCellViewModel)
}

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    static let identifier = "CollectTableViewCell"
    
    weak var delegate: CollectionTableViewCellDelegate?
    
    private var viewModels: [TileCollectionViewCellViewModel] = []
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    //Mark - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    required init?(coder: NSCoder){
        fatalError()
    }
    
    //Mark - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCollectionViewCell.identifier, for: indexPath
        ) as? TileCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    // Mark: - CollectionView
    func configure(with viewModel: CollectionTableViewCellModel)
    {
        self.viewModels = viewModel.viewModels
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width/2.5
        return CGSize(width: width, height: width/1.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        delegate?.collectionTableViewCellDidTapItem(with: viewModel)
    }

}
