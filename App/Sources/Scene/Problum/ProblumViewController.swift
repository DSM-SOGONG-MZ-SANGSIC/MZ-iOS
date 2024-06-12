import UIKit
import SnapKit
import Then

import RxSwift
import RxCocoa

class ProblumViewController: BaseVC<ProblumViewModel> {
    private let fetchQuizList = PublishRelay<CategoryType>()
    private let fetchNextQuiz = PublishRelay<Void>()
    
    private let problumContentView = ProblumContentView()
    private let questionSelectView = QuestionSelectView()
    private let quizResultView = QuizResultView().then {
        $0.isHidden = true
    }
    private let saveButton = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "square.and.arrow.down")
        $0.tintColor = .black
    }
    var category: CategoryType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        guard let category else { return }
        fetchQuizList.accept(category)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func attribute() {
        view.backgroundColor = .white
        navigationItem.title = category?.categoryName
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func addView() {
        view.addSubViews(
            problumContentView,
            questionSelectView,
            quizResultView
        )
    }
    
    override func setLayout() {
        problumContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        questionSelectView.snp.makeConstraints {
            $0.top.equalTo(problumContentView.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
        quizResultView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalToSuperview()
        }
    }
    
    override func bind() {
        let input = ProblumViewModel.Input(
            fetchQuizList: fetchQuizList.asObservable(),
            fetchQuestion: fetchNextQuiz.asObservable(),
            seletedQuestion: questionSelectView.selectedPickID.asObservable(),
            navigetToBack: quizResultView.backButton.rx.tap.asObservable(),
            saveQuiz: saveButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.fetchQuizListSuccess.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, _ in owner.fetchNextQuiz.accept(()) }
            )
            .disposed(by: disposeBag)
        
        output.quizContent.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, date in
                    owner.questionSelectView.setQuestionList(list: date.2)
                    owner.problumContentView.setProblumContent(
                        quizNum: date.0,
                        content: date.1.content
                    )
                    owner.quizResultView.isHidden = true
                }
            )
            .disposed(by: disposeBag)
        
        output.quizResult.asObservable()
            .subscribe(
                onNext: quizResultView.setQuizResult(_:),
                onError: {
                    print("error \($0.localizedDescription)")
                }
            )
            .disposed(by: disposeBag)

        output.correntFriend.asObservable()
            .bind(onNext: quizResultView.setCorrentFriend(_:))
            .disposed(by: disposeBag)
        
        output.saveQuizSuccess.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    let alert = UIAlertController(
                        title: "문제 저장",
                        message: "문제를 성공적으로 저장하였습니다.",
                        preferredStyle: .alert
                    )
                    let action = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(action)
                    owner.present(alert, animated: true)
                }
            )
            .disposed(by: disposeBag)
        
        quizResultView.nextQuizButton.rx.tap
            .bind(to: fetchNextQuiz)
            .disposed(by: disposeBag)
    }
}
