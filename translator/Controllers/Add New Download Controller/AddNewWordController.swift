//
//  AddNewWordController.swift
//  FirstProject
//
//  Created by Andrew on 19.05.2024.

import UIKit
import SDWebImage

protocol AddNewWordControllerDelegate: AnyObject {
    func didAddNewWord(_ word: Word)
    func reloadData()
}

protocol AddNewWordDelegate: AnyObject {
    func getCurrentWord() -> String
}

final class AddNewWordController: ViewController {
    
    weak var addNewWordDelegate: AddNewWordControllerDelegate?
    
    private let backgroundView: UIView = .init()
    
    
    private let editingWord: Word?
    private var currentImage: Data?
//    let networkManager = Network.shared
    private var urlImage: URL?
    
    private let myWord = UIDetailView(title: "Слово", subtitleLabel: "на вашем языке")
    private let learnWord = UIDetailView(title: "Перевод", subtitleLabel: "на языке звучивания")
    private let playButton = PlayButton()
    private let switchLanguageItem = SwitchLanguage(languageLabel: .en)
    
    private let galleryView = GalleryLoadUIView(titleLabel: "Выберите изображение")
    
    deinit {
        print(#function, Self.self)
    }
    
    init(editingWord: Word?, image: Data?) {
        self.editingWord = editingWord
        if let image = image {
            self.galleryView.image = UIImage(data: image)
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupGalleryView()
        setupView()
        setupConstraints()
        setupBGView()
        myWord.text = editingWord?.my
        learnWord.text = editingWord?.learn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        navigationItem.largeTitleDisplayMode = .automatic
        setupGestureRecognizer()
        setupGestureRecognizerForLanguage()
    }
    
    private func loadImage(from url: URL) {
        // Используем SDWebImage для загрузки изображения
        galleryView.image = nil
        galleryView.fillImageLoad.sd_setImage(with: url, completed: nil)    }
    
    private func setupView() {
        
        view.addSubviews(backgroundView)
        backgroundView.addSubviews(myWord, learnWord, playButton, switchLanguageItem)
        backgroundView.backgroundColor = .white
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupGalleryView() {
        view.addSubviews(galleryView)
        galleryView.layer.cornerRadius = 17
        galleryView.clipsToBounds = true
    }
    
    
    private func setupBGView() {
        backgroundView.layer.cornerRadius = 17
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            galleryView.heightAnchor.constraint(equalToConstant: 192),
            galleryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            galleryView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            galleryView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            
            backgroundView.topAnchor.constraint(equalTo: galleryView.bottomAnchor, constant: 25),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 16),
            backgroundView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            myWord.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            myWord.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            myWord.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            learnWord.topAnchor.constraint(equalTo: myWord.bottomAnchor, constant: 25),
            learnWord.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            learnWord.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            playButton.topAnchor.constraint(equalTo: learnWord.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            playButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            switchLanguageItem.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 40),
            switchLanguageItem.heightAnchor.constraint(equalToConstant: 30),
            switchLanguageItem.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            switchLanguageItem.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            switchLanguageItem.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -30),
        ])
        galleryView.backgroundColor = .white
    }
    
    private func setupNavBar() {
        navigationItem.title = "Новое слово"
    }
    
    @objc func saveButtonPressed() {
        
        guard let wordText = myWord.text, let learnText = learnWord.text, !wordText.isEmpty, !learnText.isEmpty else {
            alertMassageCreate()
            return
        }
        let image = galleryView.image?.jpegData(compressionQuality: 1.0)
        
        let newWord = Word(my: wordText, learn: learnText, image: image)
        // MARK: - navigationController?.popViewController

        if let currentWord = editingWord {
            //editing
            newWord._id = currentWord._id
            StorageManager.shared.update(newWord)
            
            addNewWordDelegate?.reloadData()
            navigationController?.popViewController(animated: true)

        } else {
            //add new word
            addNewWordDelegate?.didAddNewWord(newWord)
            
            addNewWordDelegate?.reloadData()

            navigationController?.popViewController(animated: true)
        }
    }
}
//// LoadImages Protocol ViewController
extension AddNewWordController: LoadImagesProtocolViewController {
    func saveImage(image: UIImage?, url: String?) {
        
        galleryView.image = image
        
        guard let string = url, let urlString = URL(string: string) else { return }
        
        Network.shared.loadImage(from: urlString) { fullImage in
            guard let fullImage = fullImage else { return }
            self.galleryView.image = fullImage
        }
    }
}

// MARK: - Gesture Gallery Tap / Alert Tap
extension AddNewWordController {
    
    private func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GestureRecognizer(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        galleryView.addGestureRecognizer(gestureRecognizer)
        galleryView.isUserInteractionEnabled = true
    }
    
    @objc private func GestureRecognizer(_ gesture: UITapGestureRecognizer) {
        print("жесты")
        setupAlert()
    }

    func setupAlert() {
        let alertController = UIAlertController(title: "Выберите действие", message: "", preferredStyle: .actionSheet)
        let actionCamera = UIAlertAction(title: "Камера", style: .default)
        let actionPhotoAlbum = UIAlertAction(title: "Фотоальбом", style: .default)
        
        // MARK: - load VC LoadImagesViewController

        // Load image from unsplash
        let actionURL = UIAlertAction(title: "Интернет", style: .default) { _ in
            if self.editingWord == nil {
                guard let text = self.learnWord.text else { return }
                let word = Word(my: "", learn: text, image: nil)
                let vc = LoadImagesViewController(word: word)
                vc.delegateMy = self
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = LoadImagesViewController(word: self.editingWord)
                vc.delegateMy = self
                self.navigationController?.pushViewController(vc, animated: true)
            }

        }
        
        let alertRandom = UIAlertAction(title: "Рандомное фото", style: .default) { _ in
            let randomWord = Word(my: "", learn: "random", image: nil)
            let vc = LoadImagesViewController(word: randomWord)
            vc.delegateMy = self
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        if galleryView.image != nil {
            
            let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
//                    StorageManager.shared.update {
//                        self.currentWord?.image = nil
//                }

                self.galleryView.image = nil
                
            }
            
            alertController.addAction(deleteAction)
        }
        
        alertController.addAction(actionCamera)
        alertController.addAction(actionPhotoAlbum)
        alertController.addAction(actionURL)
        alertController.addAction(alertRandom)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            
        }
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true) {
        }
    }
    
    private func alertMassageCreate() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите слово и его перевод", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("Пользователь нажал OK")
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Пользователь нажал Отмена")
        }
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

extension AddNewWordController: AddNewWordDelegate {
    func getCurrentWord() -> String {
        guard let englishWord = learnWord.text else { return "" }
        //currentWord
        return englishWord
    }
    
    
    private func setupGestureRecognizerForLanguage() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(GestureRecognizerForLanguage(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        switchLanguageItem.addGestureRecognizer(gestureRecognizer)
        switchLanguageItem.isUserInteractionEnabled = true
    }
    
    @objc private func GestureRecognizerForLanguage(_ gesture: UITapGestureRecognizer) {
        print("выбор языка")
        switchLanguageItem.changeLanguage()
    }
}



//MARK: - SwiftUI

import SwiftUI

//struct Provider_ViewController: PreviewProvider {
//    static var previews: some View {
//        ContainterView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainterView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        typealias UIViewControllerType = UIViewController
//
//
//        let viewController = AddNewWordController(coder: "")
//        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) -> AddNewWordController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: Provider_ViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) {
//
//        }
//    }
//}


