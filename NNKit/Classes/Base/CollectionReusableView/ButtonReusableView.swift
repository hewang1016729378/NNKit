//
//  ButtonReusableView.swift
//  NNIM
//
//  Created by ljf on 2023/5/25.
//  Copyright © 2023 NN. All rights reserved.
//

import Foundation

// 只包含一个Button
public class ButtonReusableView: UICollectionReusableView {
   public lazy var button: UIButton = {
       let tmp = UIButton(type: .custom)
       tmp.backgroundColor = NNKitConfirmBackColor
       tmp.setTitle("下一步")
       tmp.setTitleColor(NNKitConfirmTitleColor)
       tmp.titleLabel?.font = .pingfang(18)
       tmp.layer.cornerRadius = 25.0
       tmp.layer.masksToBounds = true
       tmp.isEnabled = true
       tmp.addClick(on: self) { selfView in
           if let block = selfView.btnBlock {
               block()
           }
       }
       return tmp
   }()
       
   public var btnWidth: CGFloat = 273.0 {
       didSet {
           button.snp.updateConstraints { make in
               make.width.equalTo(btnWidth)
           }
       }
   }
   public var btnHeight: CGFloat = 50.0 {
       didSet {
           button.snp.updateConstraints { make in
               make.height.equalTo(btnHeight)
           }
       }
   }
   public var bottomOffset: CGFloat = -13.0 {
       didSet {
           button.snp.updateConstraints { make in
               make.bottom.equalToSuperview().offset(bottomOffset)
           }
       }
   }
   public var btnBlock: (() -> Void)?
   
   public required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   public override init(frame: CGRect) {
       super.init(frame: frame)
       addSubview(button)
       button.snp.makeConstraints { make in
           make.centerX.equalToSuperview()
           make.width.equalTo(btnWidth)
           make.height.equalTo(btnHeight)
           make.bottom.equalToSuperview().offset(bottomOffset)
       }
   }
}
