
import Foundation

protocol LoadImagesPresenterDelegate: AnyObject {
    func didSelectIndexPath(_ indexPath: IndexPath)
    func saveImages(index: IndexPath, url: String?)
    func collectionReloadData()
    func alertError(_ title: Error?, massage: String?)
}

final class  LoadImagePresenter {
    
    weak var delegate: LoadImagesPresenterDelegate?
    
    private (set) var unsplashPhotoUrlsArray: [UnsplashPhotoUrls] = []
    private var timer: Timer?
    var currentSearchWord: String?
    var selectedImageURL: URL?
    private(set) var selectedIndexPath: IndexPath?
    private(set) var totalPages = 0
    private var page: Int = 1
    
}

// MARK: Input
extension LoadImagePresenter {
    
    func setIndex(_ indexPath: IndexPath?) {
        selectedIndexPath = indexPath
    }
    
    func saveButtonAction() {
        
        guard let selectedIndexPath = selectedIndexPath else { return }
        
        let url = unsplashPhotoUrlsArray[selectedIndexPath.item].urls?.full
        delegate?.saveImages(index: selectedIndexPath, url: url)
        print(#function)
    }
    
    func searchText(_ string: String) {
        
        if string.count < 2 {
            timer?.invalidate()
            return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(searchTextAction(_:)), userInfo: string, repeats: false)
    }
    
    func searchRandomPhoto() {
       
        Network.shared.randomPhoto( "collections", lang: "en", page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let success):
                totalPages = success.totalPages ?? 0
                reloadData(success.results ?? [])
                
            case .failure(let failure):
                alertError(failure)
            }
            
        }
    }
    
    
    @objc private func searchTextAction(_ timer: Timer) {
        
        guard let text = timer.userInfo as? String else { return }
        currentSearchWord = text
        
        page = 1
        totalPages = 0
        search(text: text)
        
    }
    
    private func search(text: String) {
        Network.shared.unsplashLoading(text, lang: "ru", page: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let success):
                totalPages = success.totalPages ?? 0

                reloadData(success.results ?? [])
                
            case .failure(let failure):
                alertError(failure)
            }
        }
    }
}
// MARK: - Output ?

extension LoadImagePresenter {
    
    func nextPage() {
        guard let currentSearchWord = currentSearchWord, page < totalPages else { return }
        page += 1
        print("\(page)")
        search(text: currentSearchWord)
        
    }
    
    func reloadData(_ array: [UnsplashPhotoUrls]) {
        if page == 1 {
            unsplashPhotoUrlsArray = array
            
        } else {
            unsplashPhotoUrlsArray += array
            
        }
        
        self.delegate?.collectionReloadData()
    }
    
    func alertError(_ error: Error) {
        
    }
    
    
    func didSelect(index: IndexPath) {
        delegate?.didSelectIndexPath(index)
        
        if let urlString = unsplashPhotoUrlsArray[index.item].urls?.regular, let url = URL(string: urlString) {
            selectedImageURL = url
        }
    }
}
