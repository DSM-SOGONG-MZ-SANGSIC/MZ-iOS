import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class SavedProblumViewController: BaseVC<SavedProblumViewModel> {
    let savedProblumTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(SavedProblumCell.self, forCellReuseIdentifier: SavedProblumCell.identifier)
        $0.estimatedRowHeight = 140
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func attribute() {
        view.backgroundColor = .white
        navigationItem.title = "저장한 문제"
    }

    override func addView() {
        view.addSubview(savedProblumTableView)
    }

    override func setLayout() {
        savedProblumTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func bind() {
        let input = SavedProblumViewModel.Input(
            viewWillAppear: viewWillAppearRelay.asObservable(),
            selectedIndexpath: savedProblumTableView.rx.itemSelected.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.savedQuizList.asObservable()
            .bind(to: savedProblumTableView.rx.items(
                cellIdentifier: SavedProblumCell.identifier,
                cellType: SavedProblumCell.self
            )) { _, data, cell in
                cell.setup(with: data)
            }
            .disposed(by: disposeBag)
    }
}
