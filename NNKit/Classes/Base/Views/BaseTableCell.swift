//
//  BaseTableCell.swift
//  NNHost
//
//  Created by Leigod on 2022/3/20.
//


import UIKit
import RxSwift

open class BaseTableCell: UITableViewCell {

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white

        selectionStyle = .none
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // 单元格重用时调用 RxSwift扩展
    public var disposeBag = DisposeBag()
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

open class BaseCollectCell: UICollectionViewCell {
    // 单元格重用时调用 RxSwift扩展
    public var disposeBag = DisposeBag()
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 自带圆角阴影背景
open class BaseShadowCollectCell: BaseCollectCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10.0
        contentView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowOpacity = 1.0
        contentView.layer.shadowRadius = 10.0
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
