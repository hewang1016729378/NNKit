//
//  NoteReusableView.swift
//  NNIM
//
//  Created by ljf on 2023/2/28.
//

import Foundation

// 包含一个图标和一个label
class NoteReusableView: UICollectionReusableView {
    lazy var noteIconView: UIImageView = {
        let tmp = UIImageView()
        return tmp
    }()
    lazy var noteLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = "#A9A9A9".color()
        tmp.font = .pingFangSCRegular(11)
        return tmp
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noteIconView)
        addSubview(noteLabel)
        noteIconView.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        noteLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(noteIconView.snp.right).offset(2.0)
        }
    }
}
