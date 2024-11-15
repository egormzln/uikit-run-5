//
//  ViewController.swift
//  UiKitRun5
//
//  Created by Егор Мизюлин on 15.11.2024.
//

import UIKit

class ViewController: UIViewController {

    private let presentButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        presentationController?.delegate = self
        setupBtn()
    }
    
    private func setupBtn() {
        view.addSubview(presentButton)
        
        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        presentButton.setTitle("Present", for: .normal)
        presentButton.setTitleColor(.link, for: .normal)
        presentButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
    
    @objc private func presentVC() {
        let vc = PopoverViewController()
        vc.preferredContentSize = .init(width: 300, height: 280)
        vc.modalPresentationStyle = .popover
        vc.delegate = self
        
        guard let presentVC = vc.popoverPresentationController else { return }
        presentVC.delegate = self
        presentVC.sourceView = presentButton
        presentVC.sourceRect = CGRect(x: presentButton.bounds.midX, y: presentButton.bounds.maxY, width: 0, height: 0)
        presentVC.permittedArrowDirections = .up
        presentButton.setTitleColor(.lightGray, for: .normal)
        present(vc, animated: true)
    }
}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }
}

extension ViewController: PopoverViewControllerDelegate {
    func popoverDidDissmised() {
        presentButton.setTitleColor(.link, for: .normal)
    }
}

protocol PopoverViewControllerDelegate {
    func popoverDidDissmised()
}

final class PopoverViewController: UIViewController {
    
    public var delegate: PopoverViewControllerDelegate?
    
    private let switchView = UISegmentedControl(items: ["280 pt", "150 pt "])
    
    private let closeBtn = UIButton(type: .close)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    private func setupView() {
        view.addSubview(switchView)
        view.addSubview(closeBtn)
        
        switchView.selectedSegmentIndex = 0
        
        switchView.setAction(UIAction(title: "280 pt", handler: { _ in
            UIView.animate(withDuration: 0.2) {
                self.preferredContentSize = CGSize(width: 300, height: 280)
            }
        }), forSegmentAt: 0)
        
        switchView.setAction(UIAction(title: "150 pt", handler: { _ in
            UIView.animate(withDuration: 0.2) {
                self.preferredContentSize = CGSize(width: 300, height: 150)
            }
        }), forSegmentAt: 1)
        
        closeBtn.addTarget(self, action: #selector(dismissPopover), for: .touchUpInside)
    }
    
    @objc func dismissPopover() {
        delegate?.popoverDidDissmised()
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        switchView.sizeToFit()
        switchView.center = CGPoint(x: view.bounds.midX, y: 40)
        
        closeBtn.sizeToFit()
        closeBtn.center = CGPoint(x: view.bounds.width - closeBtn.bounds.midX - 10, y: 40)
    }
}
