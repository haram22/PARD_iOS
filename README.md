# PARD
<img src="https://github.com/user-attachments/assets/fdca657d-6cec-49c6-be6d-a98070180284" width="300"/>

- 앱스토어 URl : https://apps.apple.com/kr/app/pard/id6466456333
- 노션 : https://we-pard.notion.site/iOS-7d043d2c79844b9b9609796647451917?pvs=4
- 코딩 컨벤션 : https://we-pard.notion.site/69a2d277d8704194a417b79ff2f91335?pvs=4

- 로그인 방법 : 애플로 회원가입을 하면, 게스트 모드로 앱을 사용 할 수 있어요 !

<br>


## 😮 프로젝트 목적
1기 flutter 앱 파트 프로젝트를 위해 개발된 파드 앱에서 데이터상 문제, 어드민 UX 문제 등이 발견되었습니다.
- 임기응변 식으로 구현되어 꼬인 데이터 구조
- 더이상 파드에서 사용되지 않는 Flutter → 유지보수 문제
- 몇가지 부분에서 유저친화적이지 않은 사용자 경험을 제공하는 어드민

위와 같은 세부 문제들을 개선하고자 다음과 같은 목표를 가지고 개발을 시작하게 되었어요.
- Firebase → Spring으로 재구현
- iOS 버전 개발 및 플러터 유지보수
- 어드민 개선

<br>

## 👋 프로젝트 소개
<img src="https://github.com/user-attachments/assets/1e725845-6b21-4e9d-b071-f2c64e7a7cd0" width="300"/>
<img src="https://github.com/user-attachments/assets/857a9e9f-b365-48a6-a856-af7cd7390cc2" width="300"/>
<img src="https://github.com/user-attachments/assets/3eb09290-0f98-49fa-b3bd-248ea7fc52f4" width="300"/>

IT 협업 동아리 파드에서 발생하는 다음과 같은 어려움을 해결하고자 만들어진 앱 입니다.
<br>

**1️⃣ 운영진의 어려움:** 
- 출석체크 관리하는 것이 어려움
- TT점수, 벌점을 관리하는 것이 어려움
- 파디들이 공지를 잘 확인하지 않음

**2️⃣ 동아리원들의 어려움:** 
- 공지가 분산되어 있어서 확인이 어려움
- 일정을 확인하는 것이 어려움

### 👉 목표
1. 파드 앱 제작 프로젝트를 통해 앱 개발자들이 프로젝트 경험 및 유의미한 결과물 제작 경험을 쌓을 수 있다. 
2. 운영진이 1기에 겪었던 문제를 해결하여 운영 관리를 용이하게 한다. 
3. 사용자들이 파드를 통한 본인의 **성장 과정**을 봄으로써 소속감을 느끼게 해준다. → 지금까지 한 세미나가 내가 밟아온 스탭처럼 보이도록 할 수 있다.
4. 사용자들이 **필요한 정보를 쉽고 정확**하게 보여줌으로써 궁금증을 해결해준다.

<br>

## 😆 개발 Team mates
| Who! | 이름 | 역할 | Github |
|------|------|------|--------|
| <img src="https://github.com/user-attachments/assets/5a2eb8d0-08ed-4586-9262-339b4fb82555" width="200"/> | 김하람 | 개발 리더 / iOS 개발<br><br>- 애플로그인 구현<br>- 구글 로그인 구현<br>- QR 기능 구현<br>- 서버 통신 구현<br>- 디자인시스템 SPM 개발<br>- QA진행 및 UI 수정 | [haram22](https://github.com/haram22) |
| <img src="https://github.com/user-attachments/assets/b2ed0f5e-a308-482d-83a0-73249812de1d" width="200"/> | 진세진 | iOS 개발<br><br>- 팝업 모달 구현<br>- 홈화면 UI 개발<br>- 토스트바 구현<br>- 햄버거바 구현<br>- 이용약관 UI개발<br>- 내 일정 페이지 UI 개발| [jinsejin](https://github.com/jinsejin) |
| <img src="https://github.com/user-attachments/assets/c0760559-cb5e-4370-b7b2-a6f60448ae7b" width="200"/> | 김민섭 | iOS 개발<br><br>- 전체 랭킹페이지 개발<br>- 마이페이지 개발<br>- 툴팁 구현<br>- 내 점수 페이지 개발<br>- UI 수정 및 디테일 반영 | [mingseobi](https://github.com/mingseobi) |

<br>

## ⚙️ 개발 환경 및 라이브러리
![Swift](https://img.shields.io/badge/swift-5.10-orange)
![Xcode](https://img.shields.io/badge/Xcode-15.3-blue)
![SnapKit](https://img.shields.io/badge/SnapKit-5.7.1-yellow)
![Then](https://img.shields.io/badge/Then-3.0.0-blue)
![GoogleSignIn](https://img.shields.io/badge/GoogleSignIn-latest-brightgreen)
![AppAuth](https://img.shields.io/badge/AppAuth-1.4.0-blue)

<br>

## ✨ 프로젝트 주요 기능 및 페이지

### 1️⃣ 스플래시 화면 및 로그인 화면

<img src="https://github.com/user-attachments/assets/63495b56-e3be-48c9-83b2-6cba6962d712" width="300"/>
<img src="https://github.com/user-attachments/assets/2a4717cc-0409-416a-9e4f-11009a923359" width="300"/>

<br><br>

### 2️⃣ 이용 약관 동의 페이지
<img src="https://github.com/user-attachments/assets/17646e9e-1124-44fd-b303-9fca4913336c" width="300"/>
<img src="https://github.com/user-attachments/assets/397eaf33-e826-4937-9632-28b27e375ce6" width="300"/>

<br><br>

### 3️⃣ 홈화면 및 툴팁
<img src="https://github.com/user-attachments/assets/8b21b1c5-bcab-414a-8a2a-e928d34842b1" width="300"/>
<img src="https://github.com/user-attachments/assets/4734ab39-c12c-435b-ba6b-1fba093c2dda" width="300"/>
<img src="https://github.com/user-attachments/assets/24a00917-b2f5-46c8-b137-ba68385153b9" width="300"/>

<br><br>

### 4️⃣ PARDNERSHIP 더보기 페이지 & 전체 랭킹 확인하기 페이지
<img src="https://github.com/user-attachments/assets/86496d87-3560-475e-bb36-8a884d24d7e3" width="300"/>
<img src="https://github.com/user-attachments/assets/752b705c-dbd2-4b9b-bfd6-05e273dedb2a" width="300"/>
<img src="https://github.com/user-attachments/assets/c434485b-ed32-4fb1-a522-8b651703c7b6" width="300"/>

<br><br>

### 5️⃣ UPCOMMING EVENT 더보기 페이지
<img src="https://github.com/user-attachments/assets/0886cbad-91fc-4e99-8770-69ddd9b25512" width="300"/>

<br><br>

### 6️⃣ 마이 페이지
<img src="https://github.com/user-attachments/assets/ff771370-4409-404d-a436-241ef7eb2314" width="300"/>

<br><br>

### 7️⃣ QR 출석 기능
- 큐알 인식 화면 / 지각 시 화면
<img src="https://github.com/user-attachments/assets/f9fa3b0d-fb84-4d7b-8b71-bc2d38f0f2bc" width="300"/>
<img src="https://github.com/user-attachments/assets/608441d8-be85-486e-9171-384056068255" width="300"/>

<br><br>

- 이미 출석 한 경우 화면 / 출석 성공 화면
<img src="https://github.com/user-attachments/assets/d2e4489d-bd8d-4f10-8fb4-be8d05d9ffa4" width="300"/>
<img src="https://github.com/user-attachments/assets/4ac370e1-84f5-429e-adbd-a77f86501ba2" width="300"/>


<br><br>

### 8️⃣ 로그아웃 및 탈퇴
<img src="https://github.com/user-attachments/assets/16a97fcd-cebe-48d4-9d1a-c77881615089" width="300"/>
<img src="https://github.com/user-attachments/assets/c839ab9f-e08f-4f10-8c3e-00a098a6f941" width="300"/>

