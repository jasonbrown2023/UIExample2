//
//  CollectViewController.swift
//  UIExample
//
//  Created by jason brown on 19/06/1402 AP.
//

import UIKit



struct CollectionTableViewCellView {
        
}

class CollectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView:  UITableView = {
    let table = UITableView()
    table.register(CollectionTableViewCell.self,
        forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
        }()
        
    private let viewModels: [CollectionTableViewCellModel] = [
        CollectionTableViewCellModel(
        viewModels: [
            TileCollectionViewCellViewModel(name: "Apple", backgroundColor: .systemBlue),
            TileCollectionViewCellViewModel(name: "Google", backgroundColor: .systemRed),
            TileCollectionViewCellViewModel(name: "NVidia", backgroundColor: .systemYellow),
            TileCollectionViewCellViewModel(name: "Intel", backgroundColor: .systemPink),
            TileCollectionViewCellViewModel(name: "Facebook", backgroundColor: .systemGreen),
            TileCollectionViewCellViewModel(name: "Microsoft", backgroundColor: .systemOrange),
            ]
        )
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
        
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let viewModel = viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  CollectionTableViewCell.identifier, for: indexPath
            ) as? CollectionTableViewCell else {
                fatalError()
                
            }
        cell.delegate = self
        cell.configure(with: viewModel)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return view.frame.size.width/2
        }
        

    }

extension CollectViewController: CollectionTableViewCellDelegate{
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionViewCellViewModel) {
        let alert = UIAlertController(title: viewModel.name,
                                      message: "You successfully selected an Item:",
                                      preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}

