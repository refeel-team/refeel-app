# Refeel

'Refeel'은 Re (다시) + feel (느끼다)의 합성어로,  
지난 날의 감정을 다시 느끼고 마주하며  
나 자신을 더 잘 이해하고 성장할 수 있도록 돕는 회고 앱입니다.

## 팀원

<div align="center">

|                                                              **박현준**                                                              |                                                         **김동녕**                                                          |                                                                 **전광호**                                                                 |                                                                 **김유진**                                                                 |
| :----------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------: |
| [<img src="https://avatars.githubusercontent.com/morgan4563" height=150 width=150> <br/> @morgan4563](https://github.com/morgan4563) | [<img src="https://avatars.githubusercontent.com/kdn0325" height=150 width=150> <br/> @kdn0325](https://github.com/kdn0325) | [<img src="https://avatars.githubusercontent.com/Jeon-GwangHo" height=150 width=150> <br/> @Jeon-GwangHo](https://github.com/Jeon-GwangHo) | [<img src="https://avatars.githubusercontent.com/kimyujin0822" height=150 width=150> <br/> @kimyujin0822](https://github.com/kimyujin0822) |

</div>

### 앱 소개

<div align="center">

| ![Image](https://github-production-user-asset-6210df.s3.amazonaws.com/91298955/444339968-c270dbc7-1b7a-4086-8d39-298897de7416.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250516T011821Z&X-Amz-Expires=300&X-Amz-Signature=cced2444a5b7edc9a4fdc2c92e65f806788cb9ab66478e2c7bf23b1af974527d&X-Amz-SignedHeaders=host) | ![Image](https://github-production-user-asset-6210df.s3.amazonaws.com/91298955/444339957-627b3df8-57b4-43e5-a0ff-007ec7a0c380.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20250516%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250516T011711Z&X-Amz-Expires=300&X-Amz-Signature=28bcaa6b04acb6af6e0e014e4a2868d36c16e4e80326c3f69e777b1e671c7111&X-Amz-SignedHeaders=host) |
| :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |

</div>

### **활용 기술**

- **프로그래밍 언어**: Swift
- **UI 프레임워크**: SwiftUI
- **로컬 데이터베이스**: SwiftData
- **아키텍처 및 상태 관리**: `@State`, `@Binding` 등 SwiftUI 상태 관리 도구 활용
- **날짜 및 시간 처리**: `DateFormatter`, `Calendar` API 활용하여 캘린더 데이터 및 날짜 표시 처리
- **UI/UX 개선**: 다크 모드 지원, Dynamic Type(가변 글자 크기) 대응, 접근성(Accessibility) 고려
- **버전 관리 및 협업**: Git 기반 코드 리뷰 및 PR 프로세스 활용하여 협업 효율성 제고

### **핵심 기능**

- 회고 작성 및 편집 기능
- 카테고리 선택 및 저장 기능
- 회고 리스트 및 상세 보기
- 달력 뷰를 통한 회고 기록 탐색

### **구현 결과**

- SwiftData 기반 로컬 회고 데이터 관리 기능 정상 구현
- 회고 등록 → 리스트 → 상세 → 편집/삭제의 흐름 완성
- 달력 기반 날짜별 회고 탐색 UI 구현
- SwiftUI 뷰 구성 및 화면 간 이동 구조 안정화

### **전체 프로젝트 수행 과정**

**기간별 기획**

| 기간          | 단계                    | 주요 작업                                     |
| ------------- | ----------------------- | --------------------------------------------- |
| 05.12 ~ 05.12 | 🔍 기획 및 리서치       | 회고 방식 리서치- 유사 앱 분석 핵심 기능 정의 |
| 05.12 ~ 05.12 | 🎨 UI/UX 설계           | Figma에서 와이어프레임 제작- 레이아웃 구성    |
| 05.13 ~ 05.13 | 💻 Swift 개발 (1차 MVP) | Swift 기반 회고 저장 기능 구현                |
| 05.13 ~ 05.14 | 🔁 테스트 및 피드백     | QA 테스트- 기능 개선 및 UI 다듬기             |
| 05.14 ~ 05.15 | 🚀 고도화 및 마무리     | 발표자료 제작 및 배포 준비                    |

**단계별 기획**

| 단계               | 내용                                                                                         |
| ------------------ | -------------------------------------------------------------------------------------------- |
| **기획**           | “Refeel”이라는 이름으로, 사용자가 자신이 작성한 회고를 다시 돌아볼 수 있는 개인 기록 앱 기획 |
| **설계**           | SwiftData 기반 회고 모델 설계 (제목, 본문, 날짜, 카테고리 필드 중심)                         |
| **UI 디자인**      | SwiftUI를 사용하여 회고 작성 뷰, 리스트 뷰, 달력 뷰, 상세 뷰를 각 모듈로 분리                |
| **기능 개발**      | - 회고 CRUD 기능 구현 - 통계 리스트 정렬 및 날짜 필터링 - 달력 기반 탐색 기능 구현           |
| **테스트 및 개선** | 실제 iOS 기기 테스트 진행, 뷰 전환 오류 수정                                                 |

### 프로젝트 구조

```
Refeel
├─ README.md                                         // 프로젝트 소개, 실행 방법, 기술 스택 등을 설명하는 문서
├─ Refeel                                                    // 실제 앱 소스 코드가 위치한 폴더
│  ├─ Enums
│  │  └─ Category.swift                              // 회고 등의 분류(Category)를 정의한 enum 파일
│
│  ├─ Extension                                          // Swift 타입 확장을 모아둔 폴더
│  │  ├─ Color+Extension.swift                  // Color에 앱 전용 색상 정의 등 확장을 추가한 파일
│  │  └─ Font+Extension.swift                   // Font에 커스텀 폰트 설정 등을 추가한 파일
│
│  ├─ FlowLayout.swift                               // 유동적인 레이아웃(예: 태그 레이아웃 등)을 구현한 커스텀 Layout
│
│  ├─ Font
│  │  └─ Cafe24SsurroundAir-v1.1.ttf         // 앱에서 사용하는 커스텀 폰트 파일
│
│  ├─ Info.plist                                             // 앱의 기본 설정 정보 (권한, 폰트 등록 등 포함)
│
│  ├─ Models
│  │  └─ Retrospect.swift                            // 회고(Retrospect) 데이터 모델 정의
│
│  ├─ RefeelApp.swift                                  // 앱의 진입점 (SwiftUI @main 구조, 앱 전체 View 흐름 정의)
│
│  ├─ Util
│  │  └─ FormattedDate.swift                      // 날짜를 형식화하는 유틸리티 함수 또는 구조체
│
│  └─ Views                                                  // 화면을 구성하는 SwiftUI View들을 폴더별로 정리
│     ├─ Home
│     │  ├─ CalendarView.swift                     // 달력 UI 구성 View
│     │  └─ HomeView.swift                         // 홈 화면 전체 구성 View
│
│     ├─ RetrospectDetail
│     │  ├─ RetrospectDetailView.swift             // 회고 상세 화면 View
│     │  └─ TagView.swift                                  // 태그를 표시하거나 선택하는 View
│
│     ├─ Splash
│     │  ├─ FirstLaunchedSplashView.swift                // 앱을 처음 실행했을 때의 스플래시 화면
│     │  └─ LogoOnlySplashView.swift                       // 로고만 나오는 간단한 스플래시 화면
│
│     ├─ Statistics
│     │  └─ StatisticsView.swift                       // 통계 화면을 보여주는 View
│
│     └─ Tab
│        ├─ CustomMainTabView.swift              // 메인 탭 바 구조 정의 View
│        └─ TabBarButton.swift                         // 탭 바에 사용되는 개별 버튼 View


```
---

## 실행 방법

### 1. 프로젝트 클론

```bash
git clone https://github.com/refeel-team/refeel-app.git
cd refeel-app
```

### 2. Xcode에서 열기

- `Refeel.xcodeproj` 또는 `Refeel.xcworkspace ( **Xcode 15 이상 권장**)

### 3. 실행

- 시뮬레이터 또는 실제 디바이스를 선택 후 버튼으로 왼쪽 상단에 재생 버튼 또는 `Shift+R` 실행합니다.
