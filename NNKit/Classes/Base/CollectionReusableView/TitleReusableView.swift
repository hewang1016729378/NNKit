//
//  RechargeTitleView.swift
//  NNIM
//
//  Created by ljf on 2023/2/27.
//

import Foundation

// 包含两个label，水平布局，一个主标题，一个副标题
public class TitleReusableView: UICollectionReusableView {
  public lazy var titleLabel: UILabel = {
      let tmp = UILabel()
      tmp.textColor = k_999999
      tmp.font = .pingfang(14)
      return tmp
  }()
  public lazy var subTitleLabel: UILabel = {
      let tmp = UILabel()
      tmp.textColor = k_999999
      tmp.font = .pingfang(14)
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
          make.centerY.left.equalToSuperview()
      }
      subTitleLabel.snp.makeConstraints { make in
          make.centerY.equalToSuperview()
          make.left.equalTo(titleLabel.snp.right)
          make.right.lessThanOrEqualToSuperview()
      }
  }
}
