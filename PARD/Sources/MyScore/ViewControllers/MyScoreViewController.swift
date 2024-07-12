//
//  MyScoreViewController.swift
//  PARD
//
//  Created by 김민섭 on 3/4/24.
//
import UIKit
import PARD_DesignSystem

class MyScoreViewController: UIViewController {
    private let pardnerShipLabel = UILabel()
    private let scoreRecordsView = ScoreRecordsView()
    private var rank1: Rank?
    private var rank2: Rank?
    private var rank3: Rank?
    
    private let appearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackBackground
        $0.shadowColor = .pard.blackBackground
        $0.titleTextAttributes = [
            .foregroundColor: UIColor.pard.white100,
            .font: UIFont.pardFont.head1
        ]
    }
    
    private let previousAppearance = UINavigationBarAppearance().then {
        $0.configureWithOpaqueBackground()
        $0.backgroundColor = .pard.blackCard
        $0.shadowColor = .pard.blackCard
    }
  
    private var toolTipView: ToolTipViewInMyScore?
    
    private var scoreRecords: [(tag: String, title: String, date: String, points: String, pointsColor: UIColor)] = [
        ("스터디", "AI 스터디\n참여", "08.23(토) |", "+1점", UIColor.pard.gray30),
        ("MVP", "기디 연합 세미나\nMVP 선발", "08.16(토) | ", "+5점", UIColor.pard.gray30),
        ("벌점", "2차 세미나\n결석", "08.16(토) | ", "-1점", UIColor.pard.gray30),
        ("정보", "슬랙\n정보 공유", "08.09(토) | ", "+1점", UIColor.pard.gray30)
    ]

    private func loadData() {
        getRankTop3 { [weak self] ranks in
            guard let self = self else { return }
            DispatchQueue.main.async {
                RankManager.shared.rankList = ranks ?? []
                self.updateUIWithRanks()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            getRankMe()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            getReason()
        }
    }
    
    
    private func updateUIWithRanks() {
        if RankManager.shared.rankList.count >= 3 {
            rank1 = RankManager.shared.rankList[0]
            rank2 = RankManager.shared.rankList[1]
            rank3 = RankManager.shared.rankList[2]
        } else {
            print("Not enough data in rankList")
        }
        setupRankingMedals()
        setupRankingButton()
        setupCrownImages()
        setupScoreView()
        setupScoreStatusView()
        setupScoreRecordsView()
    }

    private func setNavigation() {
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                .font:  UIFont.pardFont.head2,
                .foregroundColor: UIColor.pard.white100
            ]
        }
        self.navigationItem.title = "내 점수"
        appearance.shadowColor = .clear
        let backButton = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        removeTabBarFAB(bool: false)
        navigationController?.navigationBar.standardAppearance = previousAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = previousAppearance
        navigationController?.popViewController(animated: false)
    }
    
    
    private func setupTextLabel() {
        let padding: CGFloat = 8
        let labelContainerView = UIView()
        labelContainerView.backgroundColor = .clear
        view.addSubview(labelContainerView)
        
        pardnerShipLabel.text = "🏆 PARDNERSHIP TOP 3 🏆"
        pardnerShipLabel.font = UIFont.pardFont.head2
        pardnerShipLabel.font = UIFont.boldSystemFont(ofSize: 16)
        pardnerShipLabel.textColor = UIColor(patternImage: gradientImage())
        pardnerShipLabel.textAlignment = .center
        labelContainerView.addSubview(pardnerShipLabel)
        
        pardnerShipLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        }
        
        labelContainerView.layer.borderWidth = 1
        labelContainerView.layer.borderColor = UIColor(patternImage: gradientImage()).cgColor
        labelContainerView.layer.cornerRadius = 18
        
        labelContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(230 + padding * 2)
            $0.height.equalTo(36)
        }
    }
    
    private func setupRankingButton() {
        let rankingButton = UIButton(type: .system).then {
            $0.setTitle("전체랭킹 확인하기", for: .normal)
            $0.setTitleColor(.pard.gray30, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
        }
        view.addSubview(rankingButton)
        
        rankingButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(240)
            $0.top.equalToSuperview().offset(325)
            $0.width.equalTo(120)
            $0.height.equalTo(14)
        }
        
        let attributedString = NSMutableAttributedString(string: "전체랭킹 확인하기", attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.pard.gray30
        ])
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        rankingButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    
    private func setupRankingMedals() {
        guard let rank1 = rank1, let rank2 = rank2, let rank3 = rank3 else { return }
        
        let goldRingImageView = UIImageView(image: UIImage(named: "goldRing"))
        view.addSubview(goldRingImageView)
        
        let goldRankLabel = UILabel().then {
            $0.text = "1"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(goldRankLabel)
        
        let goldPartLabel = UILabel().then {
            $0.text = "\(rank1.part)"
            $0.font = UIFont.pardFont.body3
            $0.textAlignment = .center
            $0.textColor = .pard.gray30
        }
        view.addSubview(goldPartLabel)
        
        let goldNameLabel = UILabel().then {
            $0.text = "\(rank1.name)"
            $0.font = UIFont.pardFont.body4
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(goldNameLabel)
        
        let silverRingImageView = UIImageView(image: UIImage(named: "silverRing"))
        view.addSubview(silverRingImageView)
        
        let silverRankLabel = UILabel().then {
            $0.text = "2"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(silverRankLabel)
        
        let silverPartLabel = UILabel().then {
            $0.text = "\(rank2.part)"
            $0.font = UIFont.pardFont.body3
            $0.textAlignment = .center
            $0.textColor = .pard.gray30
        }
        view.addSubview(silverPartLabel)
        
        let silverNameLabel = UILabel().then {
            $0.text = "\(rank2.name)"
            $0.font = UIFont.pardFont.body4
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(silverNameLabel)
        
        let bronzeRingImageView = UIImageView(image: UIImage(named: "bronzeRing"))
        view.addSubview(bronzeRingImageView)
        
        let bronzeRankLabel = UILabel().then {
            $0.text = "3"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(bronzeRankLabel)
        
        let bronzePartLabel = UILabel().then {
            $0.text = "\(rank3.part)"
            $0.font = UIFont.pardFont.body3
            $0.textAlignment = .center
            $0.textColor = .pard.gray30
        }
        view.addSubview(bronzePartLabel)
        
        let bronzeNameLabel = UILabel().then {
            $0.text = "\(rank3.name)"
            $0.font = UIFont.pardFont.body4
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(bronzeNameLabel)
        
        goldRingImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(181)
            $0.leading.equalToSuperview().offset(22)
            $0.width.height.equalTo(40)
        }
        
        goldRankLabel.snp.makeConstraints {
            $0.centerX.equalTo(goldRingImageView)
            $0.centerY.equalTo(goldRingImageView)
        }
        
        goldPartLabel.snp.makeConstraints {
            $0.centerX.equalTo(goldNameLabel.snp.centerX)
            $0.bottom.equalTo(goldNameLabel.snp.top).offset(-2)
        }
        
        goldNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(197)
            $0.leading.equalToSuperview().offset(70)
        }
        
        silverRingImageView.snp.makeConstraints {
            $0.centerY.equalTo(goldRingImageView)
            $0.leading.equalToSuperview().offset(138)
            $0.width.height.equalTo(40)
        }
        
        silverRankLabel.snp.makeConstraints {
            $0.centerX.equalTo(silverRingImageView)
            $0.centerY.equalTo(silverRingImageView)
        }
        
        silverPartLabel.snp.makeConstraints {
            $0.centerX.equalTo(silverNameLabel.snp.centerX)
            $0.bottom.equalTo(silverNameLabel.snp.top).offset(-2)
        }
        
        silverNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(197)
            $0.leading.equalToSuperview().offset(186)
        }
        
        bronzeRingImageView.snp.makeConstraints {
            $0.centerY.equalTo(goldRingImageView)
            $0.leading.equalToSuperview().offset(254)
            $0.width.height.equalTo(40)
        }
        
        bronzeRankLabel.snp.makeConstraints {
            $0.centerX.equalTo(bronzeRingImageView)
            $0.centerY.equalTo(bronzeRingImageView)
        }
        
        bronzePartLabel.snp.makeConstraints {
            $0.centerX.equalTo(bronzeNameLabel.snp.centerX)
            $0.bottom.equalTo(bronzeNameLabel.snp.top).offset(-2)
        }
        
        bronzeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(197)
            $0.leading.equalToSuperview().offset(302)
        }
    }

    
    private func setupCrownImages() {
        let goldCrownImageView = UIImageView(image: UIImage(named: "gold"))
        view.addSubview(goldCrownImageView)
        
        goldCrownImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-155)
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(20)
        }
        
        let silverCrownImageView = UIImageView(image: UIImage(named: "silver"))
        view.addSubview(silverCrownImageView)
        
        silverCrownImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(-39)
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(20)
        }
        
        let bronzeCrownImageView = UIImageView(image: UIImage(named: "bronze"))
        view.addSubview(bronzeCrownImageView)
        
        bronzeCrownImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview().offset(77)
            $0.top.equalTo(pardnerShipLabel.snp.bottom).offset(16)
            $0.width.height.equalTo(20)
        }
    }
    
    private func setupScoreView() {
        let myScoreBorderView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(patternImage: gradientImage()).cgColor
        }
        view.addSubview(myScoreBorderView)
        
        myScoreBorderView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(245)
            $0.leading.equalToSuperview().offset(24)
            $0.width.equalTo(155.5)
            $0.height.equalTo(68)
        }
        
        let totalScoreBorderView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(patternImage: gradientImage()).cgColor
        }
        view.addSubview(totalScoreBorderView)
        
        totalScoreBorderView.snp.makeConstraints {
            $0.top.equalTo(myScoreBorderView.snp.top)
            $0.leading.equalTo(myScoreBorderView.snp.trailing).offset(16)
            $0.width.equalTo(155.5)
            $0.height.equalTo(68)
        }
        
        let myScoreLabel = UILabel().then {
            $0.text = "파트 내 랭킹"
            $0.font = UIFont.pardFont.body2
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(myScoreLabel)
        
        myScoreLabel.snp.makeConstraints {
            $0.top.equalTo(myScoreBorderView.snp.top).offset(12)
            $0.centerX.equalTo(myScoreBorderView.snp.centerX)
        }
        
        let myRankLabel = UILabel().then {
            $0.text = "\(partRanking)위"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(myRankLabel)
        
        myRankLabel.snp.makeConstraints {
            $0.top.equalTo(myScoreLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(myScoreBorderView.snp.centerX)
        }
        
        let totalScoreLabel = UILabel().then {
            $0.text = "전체 랭킹"
            $0.font = UIFont.pardFont.body2
            $0.textAlignment = .center
            $0.textColor = .pard.gray10
        }
        view.addSubview(totalScoreLabel)
        
        totalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(totalScoreBorderView.snp.top).offset(12)
            $0.centerX.equalTo(totalScoreBorderView.snp.centerX)
        }
        
        let totalRankLabel = UILabel().then {
            $0.text = "\(totalRanking)위"
            $0.font = UIFont.pardFont.head2
            $0.textAlignment = .center
            $0.textColor = .white
        }
        view.addSubview(totalRankLabel)
        
        totalRankLabel.snp.makeConstraints {
            $0.top.equalTo(totalScoreLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(totalScoreBorderView.snp.centerX)
        }
    }
    
    private func setupScoreStatusView() {
        let scoreStatusLabel = UILabel().then {
            $0.text = "내 점수 현황"
            $0.font = UIFont.pardFont.head1
            $0.textColor = .white
            $0.textAlignment = .left
        }
        view.addSubview(scoreStatusLabel)
        
        scoreStatusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(367)
            $0.leading.equalToSuperview().offset(28)
            $0.trailing.equalToSuperview().offset(260)
        }
        
        let scoreStatusView = UIView().then {
            $0.backgroundColor = UIColor.pard.blackCard
            $0.layer.cornerRadius = 8
        }
        view.addSubview(scoreStatusView)
        
        scoreStatusView.snp.makeConstraints {
            $0.top.equalTo(scoreStatusLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(92)
        }
        
        let partPointsLabel = UILabel().then {
            $0.text = "파트 포인트"
            $0.font = UIFont.pardFont.body2
            $0.textColor = .pard.gray10
            $0.textAlignment = .center
        }
        scoreStatusView.addSubview(partPointsLabel)
        
        partPointsLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(24)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(54.5)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-217.5)
        }
        
        let partPointsValueLabel = UILabel().then {
            $0.text = "+\(totalBonus)점"
            $0.font = UIFont.pardFont.head2
            $0.textColor = UIColor.pard.primaryGreen
            $0.textAlignment = .center
        }
        scoreStatusView.addSubview(partPointsValueLabel)
        
        partPointsValueLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(48)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(65)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-228)
        }
        
        let separatorView = UIView().then {
            $0.backgroundColor = .pard.gray30
        }
        
        scoreStatusView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints {
            $0.centerX.equalTo(scoreStatusView)
            $0.centerY.equalTo(scoreStatusView)
            $0.width.equalTo(1)
            $0.height.equalTo(44)
        }
        
        let penaltyPointsLabel = UILabel().then {
            $0.text = "벌점"
            $0.font = UIFont.pardFont.body3
            $0.textColor = .pard.gray10
            $0.textAlignment = .center
        }
        scoreStatusView.addSubview(penaltyPointsLabel)
        
        penaltyPointsLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(24)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(234.5)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-71.5)
        }
        
        let penaltyPointsValueLabel = UILabel().then {
            $0.text = "-\(totalMinus)점"
            $0.font = UIFont.pardFont.head2
            $0.textColor = UIColor.pard.errorRed
            $0.textAlignment = .center
            
        }
        scoreStatusView.addSubview(penaltyPointsValueLabel)
        
        penaltyPointsValueLabel.snp.makeConstraints {
            $0.top.equalTo(scoreStatusView.snp.top).offset(48)
            $0.leading.equalTo(scoreStatusView.snp.leading).offset(230.5)
            $0.trailing.equalTo(scoreStatusView.snp.trailing).offset(-67.5)
        }
        
        let questionImageButton = UIButton().then {
            $0.setImage(UIImage(named: "myscore-question-line")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        view.addSubview(questionImageButton)
        
        questionImageButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(257)
            $0.top.equalToSuperview().offset(538)
            $0.width.equalTo(14)
            $0.height.equalTo(14)
        }
        
        questionImageButton.addTarget(self, action: #selector(tappedQuestionButton), for: .touchUpInside)
    }
    
    @objc private func tappedQuestionButton() {
        toggleToolTip()
    }
    
    @objc private func scorePolicyTapped() {
        toggleToolTip()
    }
    
    private func toggleToolTip() {
        if toolTipView == nil {
            let toolTip = ToolTipViewInMyScore()
            view.addSubview(toolTip)
            toolTip.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(563)
                make.leading.equalToSuperview().offset(45)
                make.trailing.equalToSuperview().offset(-18)
                make.height.equalTo(200)
            }
            toolTipView = toolTip
        } else {
            toolTipView?.removeFromSuperview()
            toolTipView = nil
        }
    }
    
    
    private func setupScoreRecordsView() {
        let scoreRecordsTitleLabel = UILabel().then {
            $0.text = "점수 기록"
            $0.font = UIFont.pardFont.head1
            $0.textColor = .white
            $0.textAlignment = .left
        }
        view.addSubview(scoreRecordsTitleLabel)
        
        let scorePolicyLabel = UILabel().then {
            $0.text = "점수정책 확인하기"
            $0.font = UIFont.pardFont.body2
            $0.textColor = .pard.primaryBlue
            $0.textAlignment = .right
            $0.isUserInteractionEnabled = true
        }
        view.addSubview(scorePolicyLabel)
        
        let questionImageView = UIImageView(image: UIImage(named: "questionImageMark"))
        view.addSubview(questionImageView)
        
        let scorePolicyTapGesture = UITapGestureRecognizer(target: self, action: #selector(scorePolicyTapped))
        scorePolicyLabel.addGestureRecognizer(scorePolicyTapGesture)
        
        scoreRecordsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(531)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-280)
        }
        
        questionImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(538)
            $0.leading.equalToSuperview().offset(257)
        }
        
        scorePolicyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(537)
            $0.leading.equalToSuperview().offset(273)
        }
        
        view.addSubview(scoreRecordsView)
        
        scoreRecordsView.snp.makeConstraints {
            $0.top.equalTo(scoreRecordsTitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(136)
        }
        
        scoreRecordsView.layer.cornerRadius = 12
        scoreRecordsView.layer.masksToBounds = true
        
        scoreRecordsView.configure(with: scoreRecords)
    }
    
    
    
    
    
    class ScoreRecordCell: UICollectionViewCell {
        static let identifier = "ScoreRecordCell"
        
        let tagLabel = UILabel()
        let titleLabel = UILabel()
        let dateLabel = UILabel()
        let pointsLabel = UILabel()
        let backgroundCardView = UIView()
        let separatorView = UIView()  // Separator view
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            contentView.backgroundColor = .clear
            
            backgroundCardView.backgroundColor = .pard.blackCard
            backgroundCardView.layer.borderWidth = 1
            backgroundCardView.layer.borderColor = UIColor.pard.blackBackground.cgColor
            contentView.addSubview(backgroundCardView)
            
            tagLabel.font = UIFont.pardFont.body2
            tagLabel.textAlignment = .center
            tagLabel.layer.cornerRadius = 8
            tagLabel.layer.borderWidth = 1
            tagLabel.layer.masksToBounds = true
            
            titleLabel.font = UIFont.pardFont.body4
            titleLabel.textColor = .pard.gray10
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            
            dateLabel.font = UIFont.pardFont.body3
            dateLabel.textColor = .pard.gray30
            dateLabel.textAlignment = .left
            
            pointsLabel.font = UIFont.pardFont.body3
            pointsLabel.textColor = .pard.gray30
            pointsLabel.textAlignment = .right
            
            separatorView.backgroundColor = .pard.gray30
            contentView.addSubview(separatorView)
            
            backgroundCardView.addSubview(tagLabel)
            backgroundCardView.addSubview(titleLabel)
            backgroundCardView.addSubview(dateLabel)
            backgroundCardView.addSubview(pointsLabel)
            
            backgroundCardView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            tagLabel.snp.makeConstraints { make in
                make.top.equalTo(backgroundCardView).offset(24)
                make.centerX.equalTo(backgroundCardView)
                make.width.equalTo(56)
                make.height.equalTo(24)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(tagLabel.snp.bottom).offset(12)
                make.leading.equalTo(backgroundCardView).offset(12)
                make.trailing.equalTo(backgroundCardView).offset(-12)
            }
            
            dateLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.equalTo(backgroundCardView).offset(28)
            }
            
            pointsLabel.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.top)
                make.trailing.equalTo(backgroundCardView).offset(-28)
            }
            
            separatorView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.width.equalTo(1)
            }
        }
        
        func configure(with record: (tag: String, title: String, date: String, points: String, pointsColor: UIColor), isLastItem: Bool) {
            tagLabel.text = record.tag
            titleLabel.text = record.title
            dateLabel.text = record.date
            pointsLabel.text = record.points
            pointsLabel.textColor = record.pointsColor
            
            separatorView.isHidden = isLastItem
            
            if record.tag == "벌점" {
                tagLabel.layer.borderColor = UIColor.pard.errorRed.cgColor
                tagLabel.textColor = .pard.errorRed
                tagLabel.backgroundColor = .clear
            } else {
                tagLabel.layer.borderColor = UIColor.pard.primaryPurple.cgColor
                tagLabel.textColor = .pard.primaryPurple
                tagLabel.backgroundColor = .clear
            }
        }
    }
    class ToolTipView: UIView {

        private let closeButton = UIButton()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            backgroundColor = .pard.blackBackground
            layer.cornerRadius = 8
            layer.borderWidth = 1
            layer.borderColor = UIColor.pard.primaryPurple.cgColor

            // Close Button
            closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            closeButton.tintColor = .white
            closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            addSubview(closeButton)

            closeButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-8)
                make.width.height.equalTo(20)
            }

            // Add labels and points
            let contentStack = UIStackView()
            contentStack.axis = .vertical
            contentStack.spacing = 8 // 8px spacing between sections
            contentStack.alignment = .leading
            addSubview(contentStack)

            contentStack.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalTo(closeButton.snp.leading).offset(-8)
//                make.bottom.equalToSuperview().offset(-16)
            }

            // Create each row
            addMVPRow(to: contentStack, title: "MVP", details: [
                ("주요 행사 MVP", "5점"),
                ("세미나 파트별 MVP", "3점")
            ])
            addStudyRow(to: contentStack, title: "스터디", details: [
                ("개최 및 수료", "5점"),
                ("참여 및 수료", "3점")
            ])
            addRow(to: contentStack, title: "소통", detail: "파드 구성원과의 만남 후 사진을 슬랙에 인증", point: "1점/주 1회", highlight: true)
            addRow(to: contentStack, title: "회고", detail: "디스콰이어 작성 후 파트장에게 공유", point: "3점/필수과제 제외", highlight: true)
            addPenaltyRows(to: contentStack, title: "벌점", details: [
                ("세미나 지각(10분 이내)", "-1점"),
                ("세미나 결석", "-2점"),
                ("과제 지각", "-0.5점"),
                ("과제 미제출", "-1점")
            ])
        }

        private func addMVPRow(to stackView: UIStackView, title: String, details: [(String, String)]) {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.alignment = .center
            
            let titleLabel = createTitleLabel(withText: title, textColor: UIColor.pard.primaryPurple)
            rowStack.addArrangedSubview(titleLabel)

            for (detail, point) in details {
                let detailLabel = createLabel(withText: detail)
                rowStack.addArrangedSubview(detailLabel)

                let pointLabel = createDynamicPointLabel(withText: point)
                rowStack.addArrangedSubview(pointLabel)
            }

            stackView.addArrangedSubview(rowStack)
        }

        private func addStudyRow(to stackView: UIStackView, title: String, details: [(String, String)]) {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.alignment = .center
            
            let titleLabel = createTitleLabel(withText: title, textColor: UIColor.pard.primaryPurple)
            rowStack.addArrangedSubview(titleLabel)

            for (detail, point) in details {
                let detailLabel = createLabel(withText: detail)
                rowStack.addArrangedSubview(detailLabel)

                let pointLabel = createDynamicPointLabel(withText: point)
                rowStack.addArrangedSubview(pointLabel)
            }

            stackView.addArrangedSubview(rowStack)
        }

        private func addRow(to stackView: UIStackView, title: String, detail: String, point: String, highlight: Bool) {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 8
            rowStack.alignment = .center
            
            let titleLabel = createTitleLabel(withText: title, textColor: highlight ? UIColor.pard.primaryPurple : UIColor.pard.errorRed)
            rowStack.addArrangedSubview(titleLabel)

            let detailLabel = createLabel(withText: detail)
            rowStack.addArrangedSubview(detailLabel)

            let pointLabel = createDynamicPointLabel(withText: point)
            rowStack.addArrangedSubview(pointLabel)

            stackView.addArrangedSubview(rowStack)
        }

        private func addPenaltyRows(to stackView: UIStackView, title: String, details: [(String, String)]) {
            let titleLabel = createTitleLabel(withText: title, textColor: UIColor.pard.errorRed)

            let titleStack = UIStackView()
            titleStack.axis = .horizontal
            titleStack.spacing = 8
            titleStack.alignment = .center
            titleStack.addArrangedSubview(titleLabel)

            let firstRowStack = UIStackView()
            firstRowStack.axis = .horizontal
            firstRowStack.spacing = 8
            firstRowStack.alignment = .center

            let secondRowStack = UIStackView()
            secondRowStack.axis = .horizontal
            secondRowStack.spacing = 8
            secondRowStack.alignment = .center

            for (index, detail) in details.enumerated() {
                let detailLabel = createLabel(withText: detail.0)
                let pointLabel = createDynamicPointLabel(withText: detail.1)

                if index < 2 {
                    firstRowStack.addArrangedSubview(detailLabel)
                    firstRowStack.addArrangedSubview(pointLabel)
                } else {
                    secondRowStack.addArrangedSubview(detailLabel)
                    secondRowStack.addArrangedSubview(pointLabel)
                }
            }

            let combinedStack = UIStackView()
            combinedStack.axis = .vertical
            combinedStack.spacing = 8
            combinedStack.alignment = .leading
            combinedStack.addArrangedSubview(firstRowStack)
            combinedStack.addArrangedSubview(secondRowStack)

            let mainStack = UIStackView()
            mainStack.axis = .horizontal
            mainStack.spacing = 8
            mainStack.alignment = .center
            mainStack.addArrangedSubview(titleStack)
            mainStack.addArrangedSubview(combinedStack)

            stackView.addArrangedSubview(mainStack)
        }



        private func createLabel(withText text: String, textColor: UIColor = .white) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textColor = textColor
            label.font = UIFont.systemFont(ofSize: 10)
            label.setContentHuggingPriority(.defaultLow, for: .horizontal)
            label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            return label
        }

        private func createTitleLabel(withText text: String, textColor: UIColor = .white) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textColor = textColor
            label.font = UIFont.boldSystemFont(ofSize: 10)
            label.textAlignment = .center
            label.layer.cornerRadius = 8
            label.layer.borderWidth = 1
            label.layer.borderColor = textColor.cgColor
            label.layer.masksToBounds = true
            label.snp.makeConstraints { make in
                make.width.equalTo(40)
                make.height.equalTo(20)
            }
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            return label
        }

        private func createDynamicPointLabel(withText text: String, textColor: UIColor = .white) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textColor = textColor
            label.font = UIFont.systemFont(ofSize: 10)
            label.layer.cornerRadius = 8
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.darkGray.cgColor
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            return label
        }

        @objc private func closeTapped() {
            removeFromSuperview()
        }
    }


    
    @objc private func rankingButtonTapped() {
        let rankingViewController = RankingViewController()
        navigationController?.pushViewController(rankingViewController, animated: true)
    }
    
    private func gradientImage() -> UIImage {
        let gradientLayer = CAGradientLayer().then {
            $0.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
            $0.colors = [UIColor(red: 82/255, green: 98/255, blue: 245/255, alpha: 1).cgColor, UIColor(red: 123/255, green: 63/255, blue: 239/255, alpha: 1).cgColor]
            $0.startPoint = CGPoint(x: 0, y: 0)
            $0.endPoint = CGPoint(x: 1, y: 1)
        }
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension MyScoreViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        removeTabBarFAB(bool: true)
        view.backgroundColor = .pard.blackBackground
        setNavigation()
        setupTextLabel()
        loadData()
        
    }
    
    private func removeTabBarFAB(bool : Bool) {
        tabBarController?.setTabBarVisible(visible: !bool, animated: false)
        if let tabBarViewController = tabBarController as? HomeTabBarViewController {
            tabBarViewController.floatingButton.isHidden = bool
        }
    }
}
