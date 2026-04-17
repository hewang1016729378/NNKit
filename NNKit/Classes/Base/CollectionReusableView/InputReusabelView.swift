//
//  InputReusabelView.swift
//  NNIM
//
//  Created by ljf on 2023/3/2.
//

import Foundation
import RxSwift

// 只包含一个textField
public class InputReusabelView: UICollectionReusableView {
   public var disposeBag = DisposeBag()
   
   public override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag()
   }
   
   public lazy var textField: UITextField = {
       let tmp = UITextField()
       tmp.backgroundColor = "#F5F5F5".color()
       tmp.textColor = "#999999".color()
       tmp.font = .pingfang(14)
       tmp.textAlignment = .center
       tmp.layer.cornerRadius = 15.0
       tmp.delegate = self
       return tmp
   }()
   
   public var shouldChangeCharactersClosure: ((UITextField, NSRange, String) -> Bool)?
   
   public required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   public override init(frame: CGRect) {
       super.init(frame: frame)
       addSubview(textField)
       textField.snp.makeConstraints { make in
           make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6.0, left: 9.0, bottom: 6.0, right: 9.0))
       }
   }
}

extension InputReusabelView: UITextFieldDelegate {
   public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if let closure = shouldChangeCharactersClosure {
           return closure(textField, range, string)
       }
       return true
   }
}
