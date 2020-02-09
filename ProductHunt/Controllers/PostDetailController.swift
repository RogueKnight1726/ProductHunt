//
//  PostDetailController.swift
//  ProductHunt
//
//  Created by Next on 08/02/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import WebKit

class PostDetailController: BaseController{
    
    
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var avatarWebView: UIImageView!
    var pageNumber = 1
    let pageSize = 5
    var model: Post!
    var flatCommentArray: [Comment] = []
    var reachedEndOfList = false
    var isDataLoading = false
    var noDataAvailableLabel: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initViews()
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func getData(){
        if reachedEndOfList{
            return
        }
        let commentsUrlString = String.URLScheme.COMMENTS.replacingOccurrences(of: "{POST_ID}", with: "\(model?.id ?? 0)").replacingOccurrences(of: "{PAGENUMBER}", with: "\(pageNumber)").replacingOccurrences(of: "{PAGESIZE}", with: "\(pageSize)")
        
        guard let commentssUrl = URL.init(string: commentsUrlString) else {
            print("Invalid URL")
            return
        }
        isDataLoading = true
        WebApiClient.shared.requestApi(with: commentssUrl, method: .get, params: nil) { [weak self] (error, success, data) in
            self?.isDataLoading = false
            if success{
                guard let unwrappedData = data else {
                    self?.onFailureListener(errorMessage: "Oops something went wrong", response: nil)
                    return
                }
                print("Success: \(unwrappedData)")
                self?.onSuccessListener(response: "Success", codableResponse: unwrappedData)
            } else{
                self?.onFailureListener(errorMessage: "Oops something went wrong", response: nil)
            }
        }
    }
    
    
    
    func flattenCommentsArray(array: [Comment],isParentComment: Bool){
        for object in array{
            var mutableObject = object
            mutableObject.isParentComment = isParentComment
            flatCommentArray.append(mutableObject)
            if !(object.child_comments?.isEmpty ?? true){
                flattenCommentsArray(array: object.child_comments!, isParentComment: false)
            }
        }
    }
}


extension PostDetailController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flatCommentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! ThreadReplyCell
        cell.model = flatCommentArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == flatCommentArray.count - 1 ) {
            if !isDataLoading {
                self.pageNumber = self.pageNumber + 1
                self.getData()
            }
        }
    }
}


extension PostDetailController: DataResponseListener{
    func onSuccessListener(response: Any, codableResponse: Data) {
        let decoder = JSONDecoder()
        do {
            let commentArray = try decoder.decode(CommentsCollection.self, from: codableResponse)
            if commentArray.comments?.isEmpty ?? true{
                reachedEndOfList = true
            }
            self.flattenCommentsArray(array: commentArray.comments ?? [], isParentComment: true)
            collectionView.reloadData()
            
            if flatCommentArray.count == 0 {
                collectionView.isHidden = true
                noDataAvailableLabel.isHidden = false
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func onFailureListener(errorMessage: String, response: Any?) {
        
    }
    
    
}








extension PostDetailController{
    
    func initViews(){
        
        noDataAvailableLabel = UILabel()
        view.addSubview(noDataAvailableLabel)
        noDataAvailableLabel.translatesAutoresizingMaskIntoConstraints = false
        [noDataAvailableLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
         noDataAvailableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        noDataAvailableLabel.text = "No comments here yet."
        noDataAvailableLabel.textColor = .gray
        noDataAvailableLabel.font = UIFont.systemFont(ofSize: 27, weight: .ultraLight)
        noDataAvailableLabel.isHidden = true
        
        avatarWebView = UIImageView()
        view.addSubview(avatarWebView)
        avatarWebView.translatesAutoresizingMaskIntoConstraints = false
        [avatarWebView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
         avatarWebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
         avatarWebView.widthAnchor.constraint(equalToConstant: 80),
         avatarWebView.heightAnchor.constraint(equalToConstant: 80)].forEach({$0.isActive = true})
        avatarWebView.layer.cornerRadius = 40
        avatarWebView.clipsToBounds = true
        avatarWebView.kf.setImage(
            with: URL.init(string: model?.thumbnail?.image_url ?? ""),
            placeholder: nil,
            options: [.transition(.fade(0)), .loadDiskFileSynchronously],
            progressBlock: { receivedSize, totalSize in
        },
            completionHandler: { _ in
        })
        
        
        let postTitlelabel = UILabel()
        view.addSubview(postTitlelabel)
        postTitlelabel.translatesAutoresizingMaskIntoConstraints = false
        [postTitlelabel.leftAnchor.constraint(equalTo: avatarWebView.rightAnchor, constant: 8),
         postTitlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)].forEach({$0.isActive = true})
        postTitlelabel.text =  model.name ?? ""
        postTitlelabel.lineBreakMode = .byTruncatingTail
        postTitlelabel.textColor = .black
        postTitlelabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        let subTitleLabel = UILabel()
        view.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        [subTitleLabel.leftAnchor.constraint(equalTo: postTitlelabel.leftAnchor, constant: 0),
         subTitleLabel.topAnchor.constraint(equalTo: postTitlelabel.bottomAnchor, constant: 8),
         subTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subTitleLabel.numberOfLines = 2
        subTitleLabel.lineBreakMode = .byTruncatingTail
        subTitleLabel.textColor = .gray
        subTitleLabel.text = model?.tagline
        
        let seperator = UIView()
        view.addSubview(seperator)
        seperator.backgroundColor = .lightGray
        seperator.translatesAutoresizingMaskIntoConstraints = false
        [seperator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         seperator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         seperator.heightAnchor.constraint(equalToConstant: 1),
         seperator.topAnchor.constraint(equalTo: avatarWebView.bottomAnchor, constant: 16)].forEach({$0.isActive = true})
        seperator.alpha = 0.2
        
        
        layout = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = CGSize.init(width: view.bounds.width, height: 200)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
         collectionView.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        collectionView.register(ThreadReplyCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
    }
}
