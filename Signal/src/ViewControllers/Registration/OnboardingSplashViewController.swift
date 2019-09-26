//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import UIKit
import PromiseKit

@objc
public class OnboardingSplashViewController: OnboardingBaseViewController {
    var viewsToAnimate:[UIView] = []
    
    override public func loadView() {
        super.loadView()

        view.backgroundColor = Theme.backgroundColor
        view.layoutMargins = .zero
        
        let heroImageView = UIImageView()
        let heroImage = UIImage(named: "Bubble")
        heroImageView.image = heroImage
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.layer.minificationFilter = kCAFilterTrilinear
        heroImageView.layer.magnificationFilter = kCAFilterTrilinear
        heroImageView.setCompressionResistanceLow()
        heroImageView.setContentHuggingVerticalLow()

        let titleLabel = self.titleLabel(text: NSLocalizedString("ONBOARDING_SPLASH_TITLE", comment: "Title of the 'onboarding splash' view."))
        view.addSubview(titleLabel)
        titleLabel.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)

        let explanationLabel = UILabel()
        explanationLabel.text = NSLocalizedString("ONBOARDING_SPLASH_TERM_AND_PRIVACY_POLICY",
                                                  comment: "Link to the 'terms and privacy policy' in the 'onboarding splash' view.")
        explanationLabel.textColor = .ows_materialBlue
        explanationLabel.font = UIFont.ows_dynamicTypeSubheadlineClamped
        explanationLabel.numberOfLines = 0
        explanationLabel.textAlignment = .center
        explanationLabel.lineBreakMode = .byWordWrapping
        explanationLabel.isUserInteractionEnabled = true
        explanationLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(explanationLabelTapped)))

        let continueButton = self.button(title: NSLocalizedString("BUTTON_CONTINUE",
                                                                 comment: "Label for 'continue' button."),
                                                    selector: #selector(continuePressed))
        view.addSubview(continueButton)

        let stackView = UIStackView(arrangedSubviews: [
            heroImageView,
            UIView.spacer(withHeight: 22),
            titleLabel,
            UIView.spacer(withHeight: 92),
            explanationLabel,
            UIView.spacer(withHeight: 24),
            continueButton
            ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 32, left: 32, bottom: 32, right: 32)
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        stackView.autoPinWidthToSuperview()
        stackView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
        stackView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
        
        viewsToAnimate = [heroImageView, titleLabel, explanationLabel, continueButton]
    }

     // MARK: - Events

    @objc func explanationLabelTapped(sender: UIGestureRecognizer) {
        guard sender.state == .recognized else {
            return
        }
        guard let url = URL(string: kLegalTermsUrlString) else {
            owsFailDebug("Invalid URL.")
            return
        }
        UIApplication.shared.openURL(url)
    }

    @objc func continuePressed() {
        Logger.info("")

        onboardingController.onboardingSplashDidComplete(viewController: self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for view in viewsToAnimate {
            view.alpha = 0
            view.transform = CGAffineTransform(translationX: 0, y: 40).concatenating(CGAffineTransform(scaleX: 0.95, y: 0.95))
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var delay = 0.0
        for view in viewsToAnimate {
            //Animate the image on load
            UIView.animate(withDuration: 1, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                view.alpha = 1
                view.transform = .identity
            }, completion: nil)
            delay += 0.1
        }
        
    }
    
}
