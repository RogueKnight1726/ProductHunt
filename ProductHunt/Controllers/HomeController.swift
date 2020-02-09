//
//  HomeController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import WebKit

class HomeController: BaseController{
    
    
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var postsArray: PostCollection?
    var guide: UILayoutGuide!
    var greetingsLabel: UILabel!
    var postHeadline: UILabel!
    var cellColors = [UIColor]()
    var colorSet = [UIColor.AppTheme.cellOneColor,UIColor.AppTheme.cellTwoColor,UIColor.AppTheme.cellThreeColor,UIColor.AppTheme.cellFourColor]
    weak var selectionDelegate: PostSelectionProtocol?
    var calendarIcon: UIImageView!
    
    
    var daySelectionDescriptionLabel: UILabel!
    var dayPickerHolder: BaseView?
    let dismissView = UIView()
    var pickerView: UIPickerView!
    
    var requestQueue = [String]()
    
    var selectedDayOffset = 0 {
        didSet{
            getData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
        getData()
    }
    
    
    
    
    func getData(){
        
        if !Connectivity.isConnectedToInternet{
            readOfflineFileData()
            return
        }
        
        
        var postsUrlString = String.URLScheme.POSTS
        if selectedDayOffset != 0{
            postsUrlString = postsUrlString + "?days_ago=\(selectedDayOffset)"
        }
        guard let postsUrl = URL.init(string: postsUrlString) else {
            print("Invalid URL")
            return
        }
        
        
        let uuidString = UUID().uuidString
        requestQueue.append(uuidString)
        
        WebApiClient.shared.requestApiWithUUid(with: postsUrl, method: .get, params: nil, requestId: uuidString) { [weak self] (errorMessage, success, data, id) in
            if !(self?.requestQueue.isEmpty ?? true){
                if self?.requestQueue.last == id{
                    self?.requestQueue.removeAll()
                    if !success {
                        self?.onFailureListener(errorMessage: "Oops something went wrong", response: false)
                        return
                    }
                    self?.onSuccessListener(response: "Success", codableResponse: data!)
                } else {
                    self?.requestQueue.removeAll(where: { $0 == id })
                }
            } else {
                self?.onFailureListener(errorMessage: "Oops something went wrong", response: nil)
            }
        }
    }
    
    
    
    func readOfflineFileData(){
        
        FileManagerHelper.shared.readOfflineData { [weak self] (success, collectionResponse) in
            if success{
                self?.postsArray = collectionResponse
                self?.postsArray?.posts?.forEach({ _ in self?.cellColors.append(self?.randomAndRemove() ?? .white) })
                self?.collectionView.reloadData()
            }
        }
        
        
    }
    
    
    func saveDataToLocal(data: Data){
        let fileManager = FileManager.default
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let filePath = "file://" + doumentDirectoryPath.appendingPathComponent("SavedResponse.json")
        if fileManager.fileExists(atPath: filePath){
            do{
                try fileManager.removeItem(atPath: filePath)
            }catch let error {
                print("Error: \(error)")
            }
        }
        do{
            try data.write(to: URL.init(string: filePath)!)
            print("Saved to Directory")
        } catch let error {
            print("Error:  \(error)")
        }
        
    }
    
    
    //Date Selection
    @objc func calendarTapped(){
        view.addSubview(dismissView)
        dismissView.alpha = 0.14
        dismissView.backgroundColor = .black
        dismissView.translatesAutoresizingMaskIntoConstraints = false
        [dismissView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         dismissView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         dismissView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
         dismissView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)].forEach({$0.isActive = true})
        dismissView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dimissDateSelectionView(sender:))))
        
        dayPickerHolder = BaseView.init(with: .white, circular: false, shadow: false, borderColor: nil, borderThickness: nil)
        self.view.addSubview(dayPickerHolder!)
        dayPickerHolder?.translatesAutoresizingMaskIntoConstraints = false
        [dayPickerHolder?.leftAnchor.constraint(equalTo: dismissView.leftAnchor, constant: 0),
         dayPickerHolder?.rightAnchor.constraint(equalTo: dismissView.rightAnchor, constant: 0),
         dayPickerHolder?.bottomAnchor.constraint(equalTo: dismissView.bottomAnchor, constant: 0),
         dayPickerHolder?.heightAnchor.constraint(equalToConstant: 300)].forEach({$0?.isActive = true})
        
        daySelectionDescriptionLabel = UILabel()
        self.view?.addSubview(daySelectionDescriptionLabel)
        daySelectionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        [daySelectionDescriptionLabel.leftAnchor.constraint(equalTo: dayPickerHolder!.leftAnchor, constant: 16),
         daySelectionDescriptionLabel.topAnchor.constraint(equalTo: dayPickerHolder!.topAnchor, constant: 16)].forEach({$0?.isActive = true})
        daySelectionDescriptionLabel.text = "You may travel back in time and see the past posts"
        daySelectionDescriptionLabel.textColor = .gray
        daySelectionDescriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        pickerView = UIPickerView()
        dayPickerHolder?.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        [pickerView.leftAnchor.constraint(equalTo: dayPickerHolder!.leftAnchor, constant: 16), //force unwrapped for as initiated just above.
         pickerView.rightAnchor.constraint(equalTo: dayPickerHolder!.rightAnchor, constant: -16),
         pickerView.topAnchor.constraint(equalTo: dayPickerHolder!.topAnchor, constant: 16),
         pickerView.heightAnchor.constraint(equalToConstant: 240)].forEach({$0.isActive = true})
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.setValue(UIColor.white, forKey: "backgroundColor")
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
    }
    @objc func dimissDateSelectionView(sender: UITapGestureRecognizer){
        self.dismissView.removeFromSuperview()
        dayPickerHolder?.removeFromSuperview()
        daySelectionDescriptionLabel.removeFromSuperview()
        
    }
    
    
    
    
    //This method is implemented to reduce the number of repeatations while randoming. It doesnt completely remove repeatation, but greatly reduces, and I'm happy with the output
    func randomAndRemove()->UIColor{
        if colorSet.isEmpty {
            colorSet = [UIColor.AppTheme.cellOneColor,UIColor.AppTheme.cellTwoColor,UIColor.AppTheme.cellThreeColor,UIColor.AppTheme.cellFourColor]
        }
        let color = colorSet.randomElement()
        colorSet.removeAll(where: { $0 == color })
        return color!
    }
    
}



extension HomeController: DataResponseListener{
    func onSuccessListener(response: Any, codableResponse: Data) {
        let decoder = JSONDecoder()
        do {
            if selectedDayOffset == 0 {
                saveDataToLocal(data: codableResponse)
            }
            postsArray = try decoder.decode(PostCollection.self, from: codableResponse)
            postsArray?.posts?.forEach({ _ in cellColors.append(self.randomAndRemove()) })
            collectionView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func onFailureListener(errorMessage: String, response: Any?) {
        
    }
    
    
}


extension HomeController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0{
            return "Today"
        }
        return "\(row) \((row > 1) ? "Days ago" : "Day ago")"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDayOffset = row
    }
}







extension HomeController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsArray?.posts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! PostCollectionCell
        cell.model = postsArray?.posts?[indexPath.row]
        cell.backColor = cellColors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let unwrappedPost = postsArray?.posts?[indexPath.row] else {
            //handle this
            return
        }
        selectionDelegate?.selectedProtocol(with: unwrappedPost)
    }
}






extension HomeController{
    
    
    func initViews(){
        
        
        guide = view.safeAreaLayoutGuide
        greetingsLabel = UILabel()
        view.addSubview(greetingsLabel)
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        [greetingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
         greetingsLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16)].forEach({$0.isActive = true})
        greetingsLabel.text = "Greetings"
        greetingsLabel.textColor = .black
        greetingsLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        
        
        postHeadline = UILabel()
        view.addSubview(postHeadline)
        postHeadline.translatesAutoresizingMaskIntoConstraints = false
        [postHeadline.leftAnchor.constraint(equalTo: greetingsLabel.leftAnchor, constant: 8),
         postHeadline.topAnchor.constraint(equalTo: greetingsLabel.bottomAnchor, constant: 8)].forEach({$0.isActive = true})
        postHeadline.text = "Today's posts"
        postHeadline.font = UIFont.systemFont(ofSize: 18, weight: .light)
        postHeadline.textColor = .gray
        
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 170, height: 150)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         collectionView.heightAnchor.constraint(equalToConstant: 150),
         collectionView.topAnchor.constraint(equalTo: postHeadline.bottomAnchor, constant: 16)].forEach({$0.isActive = true})
        collectionView.backgroundColor = .clear
        collectionView.register(PostCollectionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        calendarIcon = UIImageView.init()
        view.addSubview(calendarIcon)
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        [calendarIcon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
         calendarIcon.topAnchor.constraint(equalTo: greetingsLabel.topAnchor, constant: 0),
         calendarIcon.heightAnchor.constraint(equalToConstant: 30),
         calendarIcon.widthAnchor.constraint(equalToConstant: 30)].forEach({$0.isActive = true})
        calendarIcon.image = UIImage.init(named: "calendarIcon")
        calendarIcon.contentMode = .scaleAspectFit
        calendarIcon.isUserInteractionEnabled = true
        calendarIcon.alpha = 0.7
        calendarIcon.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(calendarTapped)))
    }
}

