//
//  EpisodeCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

final class EpisodeCoordinator: Coordinator {
    
    
    struct Action {
        
    }
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var delegate: CoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let vm = EpisodeViewModel(usecase: EpisodeUseCase(), coordinator: self)
        let vc = EpisodeViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushList() {
        let epiListCoordinator = EpisodeListCoordinator(navigationController: navigationController)
        epiListCoordinator.start()
        childCoordinators.append(epiListCoordinator)
    }
    
    func setAction(_ action: Action) {
        
    }
}
