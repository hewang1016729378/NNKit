//
//  NNAlertActionVC.swift
//  NNIM
//
//  Created by ly on 2023/6/19.
//  Copyright © 2023 NN. All rights reserved.
//

import Foundation
import PanModal
import RxSwift

public class NNAlertActionVC: UIViewController {
    let disposeBag = DisposeBag()
    
    public var dataVMlist: [[String]] = [["标题"], ["取消"]]

    lazy var contentTableView: UITableView = {
        let tableView = TableViewFactory.create(.plain, hasHeader: false)
        tableView.separatorStyle = .none
        tableView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.registerClassOf(AlertActionBaseItemCell.self)
        return tableView
    }()

    public var didTapMenu: ((_ row: IndexPath) -> Void)?
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.addSubviews([contentTableView])
        contentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    static func show() {
        
    }
}

extension NNAlertActionVC: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataVMlist[section].count
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return dataVMlist.count
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlertActionBaseItemCell = tableView.dequeueReusableCell()
        cell.nameLabel.text = dataVMlist[indexPath.section][indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, kScreenWidth, 10))
        view.backgroundColor = "f5f5f5".color()
        return view
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        }
        return 10
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapMenu?(indexPath)
    }
}

extension NNAlertActionVC: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        return nil
    }

    public var cornerRadius: CGFloat {
        return 12
    }

    public var shortFormHeight: PanModalHeight {
        if let arry = dataVMlist[0] as? NSArray {
            if arry.count == 1 {
                return .contentHeight(162 - UIDevice.getSafeHeight())
            } else if arry.count == 2 {
                return .contentHeight(212 - UIDevice.getSafeHeight())
            } else {
                return .contentHeight(262 - UIDevice.getSafeHeight())
            }
        }
        return .contentHeight(162 - UIDevice.getSafeHeight())
    }

    public var longFormHeight: PanModalHeight {
        return .contentHeight(212 - UIDevice.getSafeHeight())
    }

    public var showDragIndicator: Bool {
        return false
    }
}

class AlertActionBaseItemCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var nameLabel: UILabel = {
        let tmp = UIView.createLabel(text: "文字频道", font: .pingFangSCRegular(16))
        tmp.textColor = "#333333".color()
        return tmp
    }()

    func setupSubviews() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
