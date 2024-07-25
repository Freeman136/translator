//
//  MainViewController.swift
//  FirstProject
//
//  Created by Andrew on 27.04.2024.
//

import UIKit


protocol DetailViewControllerDelegate: AnyObject {
    func didAddNewWord(_ myWord: String, _ learnWord: String)
    
    func getWordsDictionary() -> [Word]
}

import SwiftUI


class MainWordsViewController: UIViewController {
    
    private var wordsDictionary: [Word] = [
        Word(my: "Hello", learn: "Привет", imageName: "Hello"),
        Word(my: "House", learn: "Дом", imageName: "House"),
        Word(my: "Winter", learn: "Зима", imageName: "Winter"),
        Word(my: "Book", learn: "Книга", imageName: "Book"),
        Word(my: "Island", learn: "Остров", imageName: "Island"),
        Word(my: "Car", learn: "Машина", imageName: "Car"),
        Word(my: "Street", learn: "Улица", imageName: "Street"),
        
        Word(my: "Hello", learn: "Привет", imageName: "Hello"),
        Word(my: "House", learn: "Дом", imageName: "House"),
        Word(my: "Winter", learn: "Зима", imageName: "Winter"),
        Word(my: "Book", learn: "Книга", imageName: "Book"),
        Word(my: "Island", learn: "Остров", imageName: "Island"),
        Word(my: "Car", learn: "Машина", imageName: "Car"),
        Word(my: "Street", learn: "Улица", imageName: "Street"),
        
        Word(my: "Hello", learn: "Привет", imageName: "Hello"),
        Word(my: "House", learn: "Дом", imageName: "House"),
        Word(my: "Winter", learn: "Зима", imageName: "Winter"),
        Word(my: "Book", learn: "Книга", imageName: "Book"),
        Word(my: "Island", learn: "Остров", imageName: "Island"),
        Word(my: "Car", learn: "Машина", imageName: "Car"),
        Word(my: "Street", learn: "Улица", imageName: "Street"),
        
        Word(my: "Hello", learn: "Привет", imageName: "Hello"),
        Word(my: "House", learn: "Дом", imageName: "House"),
        Word(my: "Winter", learn: "Зима", imageName: "Winter"),
        Word(my: "Book", learn: "Книга", imageName: "Book"),
        Word(my: "Island", learn: "Остров", imageName: "Island"),
        Word(my: "Car", learn: "Машина", imageName: "Car"),
        Word(my: "Street", learn: "Улица", imageName: "Street"),
        Word(my: "Hello", learn: "Привет", imageName: "Hello"),
        Word(my: "House", learn: "Дом", imageName: "House"),
        Word(my: "Winter", learn: "Зима", imageName: "Winter"),
        Word(my: "Book", learn: "Книга", imageName: "Book"),
        Word(my: "Island", learn: "Остров", imageName: "Island"),
        Word(my: "Car", learn: "Машина", imageName: "Car"),
        Word(my: "Street", learn: "Улица", imageName: "Street"),
        

    ]
    
    private let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupBehavior()
        setupAddButton()
    }
    
    
    
    func setupAddButton() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Все слова"
        navigationController?.navigationBar.backgroundColor = .white
        //
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemButton))
        navigationItem.rightBarButtonItem = addButton
        addButton.tintColor = AppUIColors.orangeColor
    }
    
    @objc func addItemButton() {
        let detailViewController = DetailViewController()
        detailViewController.delegateMainViewController = self
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func setupView() {
        view.addSubview(mainTableView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -9),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 9),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupBehavior() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        mainTableView.rowHeight = 55
    }
    
    private func updateWordsForDetailView(index: IndexPath) {
        let detailViewController = AddNewWordController()
        detailViewController.delegateMainViewController = self

        let firstWords = wordsDictionary[index.row].my
        let secondWord = wordsDictionary[index.row].learn
        let result = detailViewController.updateWords(firstWords, secondWord, index.row)
        wordsDictionary.remove(at: index.row)
        wordsDictionary.insert(result, at: index.row)
        mainTableView.reloadData()
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
//MARK: - UITableViewDelegate

extension MainViewController: DetailViewControllerDelegate {
    func getWordsDictionary() -> [Word] {
        return wordsDictionary
    }

    func didAddNewWord(_ myWord: String, _ learnWord: String) {
        if !wordsDictionary.contains(where: { $0.my == myWord || $0.learn == learnWord }) {
            wordsDictionary.append(Word(my: myWord, learn: learnWord, imageName: nil))
            mainTableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let firstWords = wordsDictionary[indexPath.row].my
        let secondWord = wordsDictionary[indexPath.row].learn
        print(firstWords)
        cell.configureCell(mainLabelText: firstWords, secondLabelText: secondWord)
        
        return cell
    }
    
    //MARK: - delete words
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Удалить", handler: { _, _, _ in
            self.wordsDictionary.remove(at: indexPath.row)
            self.mainTableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let edit = UIContextualAction(style: .normal, title: "Редактировать") { _, _, _ in
            self.updateWordsForDetailView(index: indexPath)
        }
        
        let array: [UIContextualAction] = [
            edit, delete
        ]
        return UISwipeActionsConfiguration.init(actions: array)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateWordsForDetailView(index: indexPath)
    }
}


////MARK: - SwiftUI
//import SwiftUI
//struct ProviderAppNavigationController : PreviewProvider {
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
//        let viewController = AppNavigationController()
//        func makeUIViewController(context: UIViewControllerRepresentableContext<ProviderAppNavigationController.ContainterView>) -> AppNavigationController {
//            return viewController
//        }
//        
//        func updateUIViewController(_ uiViewController: ProviderAppNavigationController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProviderAppNavigationController.ContainterView>) {
//            
//        }
//    }
//    
//}
