//
//  CardView.swift
//  TheatreLink
//
//  Created by Natalie Meneses on 12/4/20.
//
import AlamofireImage
import UIKit

protocol CardViewDelegate: AnyObject {
    func panCard(_ sender: UIPanGestureRecognizer)
}

class CardView: UIView {


    @IBOutlet var contentView: UIView!

    @IBOutlet var posterView: UIImageView!
    
    
    weak var delegate: CardViewDelegate?
    
    let panGesture = UIPanGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView(){
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(contentView)
        panGesture.addTarget(self, action: #selector(handlePanGesture(panGesture:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer){
        delegate?.panCard(panGesture)
    }
}
