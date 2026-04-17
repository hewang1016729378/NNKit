//
//  BaseViewController.swift
//  NNAcc
//
//  Created by ly on 2021/11/30.
//

import Foundation
import RxSwift
import SnapKit
import UIKit

private let onceToken = "BaseViewController Method Swizzling"
// 动态关联属性的keys
struct AssociatedKeys {
    // 也可以是其他类型
    static var ViewContorllerWillDeinit: String = "NNPopFlagAssociated"
}
let naviBarHeight = TitleBarUIConstant.kTopBarH+UIConstant.statusBarHeight()
/// 最近加载ViewController的时间戳
var recentLoadVCTimeInterval: TimeInterval = 0

open class BaseViewController: UIViewController {
//    lazy var backgroundImageView : UIImageView = {
//        let tmp = UIImageView.init()
//        tmp.image = UIImage.init(named: "home_bg")
//        tmp.contentMode = .scaleAspectFill
//        tmp.layer.masksToBounds = true
//        return tmp
//    }()
    private var disposeBag = DisposeBag()
    public var didTapRightBtn: (() -> Void)?
    // 首次请求数据
    public var isfirstLoad = true
    public lazy var mainView: UIView = {
        () -> UIView in
        let tmp = UIView()
        return tmp
    }()
    public lazy var navigationTitleBar: BaseNavigationTitleBar = {
        () -> BaseNavigationTitleBar in
        let tmp = BaseNavigationTitleBar()
        return tmp
    }()
    deinit {
        print("")
    }
    public init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeApplicationResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeDidBecomeActiveNotification), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(observeApplicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
//        self.navigationController?.navigationBar.isHidden = true
    }
    open override var title: String? {
        didSet {
            navigationTitleBar.titleLabel.text = title
        }
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.insertSubview(self.backgroundImageView, belowSubview: self.mainView)
//        self.backgroundImageView.snp.makeConstraints { make in
//            make.height.equalTo(TitleBarUIConstant.kTopBarH+TitleBarUIConstant.kMenuBarH+60.0)
//            make.top.equalTo(self.view)
//            make.left.right.equalTo(self.view)
//        }
        view.backgroundColor = UIColor.white
        view.addSubview(navigationTitleBar)
        view.addSubview(mainView)
        navigationTitleBar.snp.makeConstraints { make in
            make.top.equalTo(view).offset(0.0)
            make.left.equalTo(view).offset(0.0)
            make.right.equalTo(view).offset(0.0)
            make.height.equalTo(naviBarHeight)
        }
        mainView.snp.makeConstraints { make in
            make.top.equalTo(navigationTitleBar.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(0.0)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(0.0)
            make.bottom.equalTo(view).offset(-kBottomSafeAreaHeight)
        }
        navigationTitleBar.leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.back()
        }).disposed(by: disposeBag)
        navigationTitleBar.rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let rightcloSure = self?.didTapRightBtn {
                rightcloSure()
            }
        })
        recentLoadVCTimeInterval = Date.init().timeIntervalSince1970
    }
    /*
     * 回到App
     */
    @objc open func observeDidBecomeActiveNotification() {
        print("observeDidBecomeActiveNotification")
    }
    /*
     * App返回到后台
     */
    @objc open func observeApplicationResignActive() {
        print("observeApplicationResignActive")
    }
    @objc open func observeApplicationWillEnterForeground() {
        print("observeApplicationWillEnter")
    }
    open func back() {
        backToPreViewController(animation: true)
    }
    @objc public var navigationTitle = "" {
        didSet {
            self.navigationTitleBar.titleLabel.text = navigationTitle
        }
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func hiddenLeftBtn(){
        navigationTitleBar.leftBtn.isHidden = true
    }
}

/*
 * Private Func
 */
extension BaseViewController {
    
    public func backToPreViewController(animation: Bool) {
        if let _ = presentingViewController {
            guard let nav = navigationController else { return }
            if nav.viewControllers.count >= 2 {
                navigationController?.popViewController(animated: animation)
            } else if nav.viewControllers.count == 1 {
                dismiss(animated: animation, completion: nil)
            }
        } else {
            guard let nav = navigationController else { return }
            if nav.viewControllers.count >= 2 {
                nav.popViewController(animated: animation)
            }
        }
    }
}

/*
 * UIKit Extension
 */
extension BaseViewController {
    /// 强提示框
    public func showStrongMessage(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "确认", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

/*
 * 检测内存泄漏
 */
extension BaseViewController {
    public class func initializeMethod() {
        if self != BaseViewController.self { return }
        // DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
        DispatchQueue.once(token: onceToken) {
            // 交换viewWillAppear
            let originalSelector = #selector(BaseViewController.viewWillAppear(_:))
            let swizzledSelector = #selector(BaseViewController.swizzled_viewWillAppear(animated:))
            MethodSwizzlingTool.swizzling(cls: self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
            // 交换viewWillDisappear
            let originalSelector1 = #selector(BaseViewController.viewWillDisappear(_:))
            let swizzledSelector1 = #selector(BaseViewController.swizzled_viewWillDisappear(animated:))
            MethodSwizzlingTool.swizzling(cls: self, originalSelector: originalSelector1, swizzledSelector: swizzledSelector1)
            // 交换dissmiss
            let originalSelector2 = #selector(BaseViewController.dismiss(animated:completion:))
            let swizzledSelector2 = #selector(BaseViewController.swizzlied_dismiss(animated:completion:))
            MethodSwizzlingTool.swizzling(cls: self, originalSelector: originalSelector2, swizzledSelector: swizzledSelector2)
        }
    }

    @objc func swizzled_viewWillAppear(animated: Bool) {
        swizzled_viewWillAppear(animated: animated)
        // 更改关联属性状态设置false，表示view才将要显示了
        objc_setAssociatedObject(self, &AssociatedKeys.ViewContorllerWillDeinit, false, .OBJC_ASSOCIATION_ASSIGN)
    }

    @objc func swizzled_viewWillDisappear(animated: Bool) {
        swizzled_viewWillDisappear(animated: animated)
        // 得到关联属性的状态，如果是true，表示视图要消失即将回收VC的资源，这个时候才是关键！！给self发送对象看它是否响应，若响应了，说明没有释放内存
        guard let state = objc_getAssociatedObject(self, &AssociatedKeys.ViewContorllerWillDeinit) as? Bool else { return }
        if state {
            willDeinit()
        }
    }

    @objc func swizzlied_dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        swizzlied_dismiss(animated: flag, completion: completion)
        // 给要dimiss出去的VC更改关联属性状态，true表示准备释放这个VC
        objc_setAssociatedObject(self, &AssociatedKeys.ViewContorllerWillDeinit, true, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }

    private func willDeinit() {
        /* 核心思想：
            1.给nil对象发送消息是不会崩溃的
            2.查看pop出去的那个控制器是否还有内存，如果是，则没有被释放
         */
        // ps:这里的延时是因为popViewController执行还是需要一定的时间
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            // 如果self被释放了，给nil发送消息是不会响应的
            self?.isNotDeinit()
        }
    }

    private func isNotDeinit() {
        // 打印VC内存
        print(String(format: "%p is not deinit", self))
    }
}
