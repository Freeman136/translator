
import UIKit
import SDWebImage

protocol LoadImagesProtocolViewController: AnyObject {
    func saveImage(image: UIImage?, url: String?)
}

final class LoadImagesViewController: ViewController {
    
    weak var delegateMy: LoadImagesProtocolViewController?
    
    private let presenter = LoadImagePresenter()
    
    private var word: Word?
    
    
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Поиск..."

        bar.searchBarStyle = .minimal
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.showsCancelButton = false
        return bar
    }()
    
    let emptySearchLabel: UILabel = {
       let label = UILabel()
        label.text = "Empty result of search"
        label.font = .montserrat(ofSize: 16, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let screenWidth = view.bounds.width
        let screenHeight = view.bounds.height
        
        let cellWidth = (screenWidth - 38) / 3
        let cellHeight = screenHeight / 7
        layout.itemSize = CGSize(width: cellWidth, height: 130)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    init(word: Word?) {
        super.init(nibName: nil, bundle: nil)
// TODO: споросить верно ли
        self.word = word
        if word?.learn == "random" {
            print("RANDOM")
            presenter.searchRandomPhoto()
        } else if let wordForSearchBar = word?.learn {
            searchBar.text = wordForSearchBar
            presenter.searchText(wordForSearchBar)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupConstraint()
        presenter.delegate = self
    }
    
    private func setupConstraint() {
        view.addSubviews(searchBar, emptySearchLabel)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            emptySearchLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            emptySearchLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        collectionView.contentInset.bottom = 40
        collectionView.backgroundColor = .clear
        searchBar.delegate = self
    }
    
    private func setupNavigation() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addItemButton))
        addButton.tintColor = .orange
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addItemButton() {
        presenter.saveButtonAction()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        
        collectionView.register(CellLoadImages.self, forCellWithReuseIdentifier: CellLoadImages.identifier)
    }
}

// MARK: UISearchBarDelegate

extension LoadImagesViewController: UISearchBarDelegate  {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchText(searchText)
    }
}
// MARK: - CollectionView setup cell
extension LoadImagesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.unsplashPhotoUrlsArray.count
    }
    // Main IndexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let value = presenter.unsplashPhotoUrlsArray[indexPath.item]
       
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellLoadImages.identifier, for: indexPath) as? CellLoadImages, let string = value.urls?.regular else { return UICollectionViewCell() }
        
        if let url = URL(string: string) {
            cell.imageView.sd_setImage(with: url)
            cell.imageView.tintColor = .red
        }
        
        cell.setCheckmarkVisible(indexPath == presenter.selectedIndexPath)
        cell.setSelected(indexPath == presenter.selectedIndexPath)
        
        let maxInPage = presenter.unsplashPhotoUrlsArray.count
        if indexPath.item == maxInPage - 4 {
            presenter.nextPage()
        }
        return cell
    }
    
    // MARK: - Select image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)  {
        
        setupNavigation()
        if let previousIndexPath = presenter.selectedIndexPath {
            presenter.setIndex(nil)
            collectionView.reloadItems(at: [previousIndexPath])
        } else if presenter.selectedIndexPath == nil {
            //            navigationController?.popViewController(animated: true)
        }
        
        presenter.setIndex(indexPath)
        collectionView.reloadItems(at: [indexPath])
        
        presenter.didSelect(index: indexPath)
    }
}

// MARK: - Presenter delegate

extension LoadImagesViewController: LoadImagesPresenterDelegate {
    
    //presenter - saveImages где вызов происходит?
    func saveImages(index: IndexPath, url: String?) {
        if let cell = collectionView.cellForItem(at: index) as? CellLoadImages {
            let image = cell.imageView.image
            delegateMy?.saveImage(image: image, url: url)
            navigationController?.popViewController(animated: true)
            return
        }

        delegateMy?.saveImage(image: nil, url: url)
        
        navigationController?.popViewController(animated: true)
        
        print(#function)
        
    }
    
    func alertError(_ title: Error?, massage: String?) {
        let string: String = title?.localizedDescription ?? ""
        let alert = UIAlertController(title: string, message: massage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func collectionReloadData() {
        
        if presenter.unsplashPhotoUrlsArray.count == 0 {
            emptySearchLabel.isHidden = false
        }
        
        collectionView.reloadData()
    }
    
    func didSelectIndexPath(_ indexPath: IndexPath) {
        print(#function)
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ProviderAppNavigationController : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = LoadImagesViewController(word: Word())
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderAppNavigationController.ContainterView>) -> LoadImagesViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ProviderAppNavigationController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderAppNavigationController.ContainterView>) {
            
        }
    }
}
