//
//  MainAndSubtitleReusableView.swift
//  NNIM
//
//  Created by ljf on 2023/3/6.
//

import Foundation

// 包含主标题 和 副标题（上下结构，左对齐）
public class MainAndSubtitleReusableView: UICollectionReusableView {
    public lazy var titleLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = k_333333
        tmp.font = .pingfangMedium(14)
        return tmp
    }()
    public lazy var subTitleLabel: UILabel = {
        let tmp = UILabel()
        tmp.textColor = "#000000".color(alpha: 0.3)
        tmp.font = .pingFangSCRegular(12)
        return tmp
    }()
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(10.0)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.0)
        }
    }
}
