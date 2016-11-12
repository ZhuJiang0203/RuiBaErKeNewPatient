//
//  LookBigPictureController.swift
//  RuiBaoiOSDoctor
//
//  Created by whj on 16/5/17.
//  Copyright © 2016年 ConneHealth. All rights reserved.
//

import UIKit

class LookBigPictureController: BaseViewController {

    var picture: UIImage?
    var pictureURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LookBigPictureController.dismissCurrentCtl))
        view.addGestureRecognizer(tap)
        
        let imgVw = UIImageView(frame: view.bounds)
        imgVw.contentMode = UIViewContentMode.scaleAspectFit
        if picture != nil {
            imgVw.image = picture!
        }
        if pictureURL != nil {
            imgVw.sd_setImage(with: pictureURL!, placeholderImage: UIImage(named: "wenzhangtu"))
        }
        view.addSubview(imgVw)
    }

    func dismissCurrentCtl() {
        dismiss(animated: false, completion: nil)
    }
}
