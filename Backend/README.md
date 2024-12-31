본 계획은 MVVM패턴 연습을 위해 uikit을 활용하여 구현함에 있음. 
이에 아래 확인란을 평가지표로 사용함. 

## Model

- [ ] Model이 데이터를 캡슐화하고 주요 로직을 처리하고 있는가?  
- [ ] Model이 다른 계층(ViewModel 등)에 의존하지 않고 독립적으로 데이터를 관리할 수 있는가?  
- [ ] Model이 외부 데이터 소스(API, DB 등)와 상호작용하며 필요한 데이터를 적절히 제공하고 있는가?  

## ViewModel

- [ ] ViewModel이 핵심 로직을 처리하고 Model의 데이터를 가공하여 제공하고 있는가?  
- [ ] ViewModel이 다른 계층(View 등)에 의존하지 않고 데이터 상태를 독립적으로 관리할 수 있는가?  
- [ ] ViewModel이 사용자 입력이나 이벤트를 처리하여 적절히 데이터를 관리하거나 Model과 상호작용하고 있는가?  

## View

- [ ] View가 순수하게 UI 렌더링만 담당하며 비즈니스 로직을 포함하지 않고 있는가?  
- [ ] View가 ViewModel과 Binding 또는 Observable을 통해 데이터와 동기화하고 있는가?  
- [ ] View가 UI 레이아웃과 스타일링에 집중하며 변경이 다른 계층에 영향을 주지 않고 있는가?  

---



# 계획 개요 

각 task에 point를 추가하는 간단한 구조의 앱. 

## ERD
![IMG_D110E04EF88D-1](https://github.com/user-attachments/assets/ecf74652-3685-4168-a40f-e8bd8f9984d4)


## Wireframe
![IMG_234C954D624B-1](https://github.com/user-attachments/assets/e2ef1dab-bab5-44e7-9139-e82c7ce8a312)




---
이에 5가지 구조로 나누어 작업함.

- login
- task
- taskFolder
- addTask
- addtaskFolder
