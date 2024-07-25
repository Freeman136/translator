
import UIKit
import SDWebImage
import RealmSwift

class UIAllWordViewController: ViewController {
    
    var wordsArray:[Word] = StorageManager.shared.getRealmData()
    
    private lazy var collectionView: UICollectionView = {
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        let cellWidth = (screenWidth - 38) / 3
        let cellHeight = screenHeight / 7
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: cellWidth, height: 130)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 50)
        layout.sectionHeadersPinToVisibleBounds = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
        longPress()
        
        StorageManager.shared.printURL()
        
    }
    
    
    private func setupNavigation() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemButton))
        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addItemButton() {
        let detailViewController = AddNewWordController(editingWord: nil, image: nil)
        detailViewController.addNewWordDelegate = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        collectionView.register(RoundedImageCell.self, forCellWithReuseIdentifier: RoundedImageCell.identifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
    }
    
    private func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}


extension UIAllWordViewController: AddNewWordControllerDelegate {
    
    func didAddNewWord(_ word: Word) {
        StorageManager.shared.add(word)
        wordsArray = StorageManager.shared.getRealmData()
        collectionView.reloadData()
    }
    
    func reloadData() {
        wordsArray = StorageManager.shared.getRealmData()
        collectionView.reloadData()
    }
    
}

extension UIAllWordViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoundedImageCell.identifier, for: indexPath) as? RoundedImageCell else { return UICollectionViewCell() }
        let word = wordsArray[indexPath.row]
        if let image = word.image {
            cell.iconImageView.image = UIImage(data: image)
            
        }
        cell.configure(firstLabelText: word.my, secondLabelText: word.learn)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderView
            headerView.configure(text: "Все слова")
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        self.updateWordsForDetailView(index: indexPath)
        print("did select new")
        
    }
    
}

extension UIAllWordViewController {
    
    func updateWordsForDetailView(index: IndexPath) {
        let currentWord = wordsArray[index.row]
        
        let addDetailViewController = AddNewWordController(editingWord: currentWord, image: currentWord.image)
        addDetailViewController.addNewWordDelegate = self
        navigationController?.pushViewController(addDetailViewController, animated: true)
    }
    
    private func createMenuAlert(for indexPath: IndexPath) {
        let alertAction = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "Редактировать", style: .default){_ in
            self.updateWordsForDetailView(index: indexPath)
            
        }
        
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            
            let wordToDelete = self.wordsArray[indexPath.row]
            StorageManager.shared.delete(word: wordToDelete)
            self.wordsArray = StorageManager.shared.getRealmData()
            
            self.collectionView.reloadData()
            
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel){_ in
            
        }
        alertAction.addAction(editAction)
        alertAction.addAction(deleteAction)
        alertAction.addAction(cancelAction)
        
        self.present(alertAction, animated: true)
        
    }
    
    private func longPress() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        collectionView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: collectionView)
            
            if let indexPath = collectionView.indexPathForItem(at: point) {
                createMenuAlert(for: indexPath)
            }
        }
    }
}
