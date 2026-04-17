//
//  NNNoticeAlertViewController.swift
//  NNIM
//
//  Created by leigodLi on 2023/7/10.
//  Copyright © 2023 NN. All rights reserved.
//

import Foundation
import RxSwift
import PanModal
import UIKit

public class NNNoticeAlertViewController: UIViewController {
    let disposeBag = DisposeBag()
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    public convenience init(title: String?, message: String?, btnMsg: String?) {
        self.init()
        titleLabel.text = title
        textView.text = message
        confirmBtn.setTitle(btnMsg, for: .normal)
    }
    public convenience init(message: String?) {
        self.init()
        textView.text = message
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var bgView: UIView = {
        let tmp = UIView()
        tmp.backgroundColor = .white
        tmp.layer.cornerRadius = 12.0
        tmp.layer.masksToBounds = true
        return tmp
    }()
    lazy var closeBtn: NNBigButton = {
        let tmp = NNBigButton(type: .custom)
        tmp.setBackgroundImage(.NoticeIcon.close)
        tmp.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
            self?.cancelBlock?()
        }).disposed(by: disposeBag)
        return tmp
    }()
    lazy var titleLabel: UILabel = {
        let tmp = UILabel.init()
        tmp.settingLabel(pingFangSCSize: 18.0, textColor: .black)
        tmp.text = .NoticeText.title
        tmp.numberOfLines = 0
        tmp.textAlignment = .center
        return tmp
    }()
    lazy var textView: UITextView = {
        let tmp = UITextView()
        tmp.text = ""
        tmp.textColor = k_666666
        tmp.font = kFont14
        tmp.isEditable = false
        tmp.bounces = false
        tmp.isScrollEnabled = false
        return tmp
    }()
    lazy var confirmBtn: UIButton = {
        let tmp = UIButton(type: .custom)
        tmp.backgroundColor = NNKitThemeColor
        tmp.setTitle(.NoticeText.confirm, for: .normal)
        tmp.titleLabel?.font = kFont16
        tmp.setTitleColor(.white, for: .normal)
        tmp.layer.cornerRadius = 23.0
        tmp.layer.masksToBounds = true
        tmp.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
            self?.confirmBlock?()
        }).disposed(by: disposeBag)
        return tmp
    }()
    public var confirmBlock: (() -> Void)?
    public var cancelBlock: (() -> Void)?
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.isScrollEnabled = true
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(320.0)
            make.height.lessThanOrEqualTo(500.0)
        }
        bgView.addSubviews([closeBtn, titleLabel, textView, confirmBtn])
        closeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-11.0)
            make.top.equalToSuperview().offset(11.0)
            make.width.height.equalTo(24.0)
        }
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-26.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(212.0)
            make.height.equalTo(46.0)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(240.0)
            make.height.lessThanOrEqualTo(300.0)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(270.0)
            make.bottom.equalTo(confirmBtn.snp.top).offset(-14.0)
        }
    }
}

extension NNNoticeAlertViewController: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        return nil
    }
    public var shortFormHeight: PanModalHeight {
        return .contentHeight(UIConstant.screenHeight())
    }
    public var showDragIndicator: Bool {
        return false
    }
    public func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return false
    }
}
