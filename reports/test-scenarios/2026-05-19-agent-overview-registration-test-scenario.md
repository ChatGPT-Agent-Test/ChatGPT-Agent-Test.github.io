# agent-overview 문서 등록 검증 테스트 시나리오 보고서

## 검증 대상 기능
- `docs/agent-overview.md` 원본 문서 등록
- `docs/agent-overview.html`의 Markdown 기반 요약 표시 동작

## 사전 조건
- 대상 저장소가 `ChatGPT-Agent-Test/ChatGPT-Agent-Test.github.io`인지 확인합니다.
- 반영 브랜치가 `dev`인지 확인합니다.
- `docs/` 경로에 신규 파일 생성이 가능한 상태여야 합니다.

## 테스트 케이스 목록
1. Markdown 원본 파일이 지정 경로에 등록되는지 확인
2. HTML 파일이 동일 폴더의 `agent-overview.md`를 상대 경로로 참조하는지 확인
3. HTML의 주요 섹션 파싱 로직이 `##` 제목 단위를 기준으로 구성되어 있는지 확인
4. Markdown 로드 실패 시 오류 안내 카드가 표시되도록 처리되어 있는지 확인

## 정상 흐름
1. 사용자가 `docs/agent-overview.html`을 열면 `agent-overview.md`를 읽습니다.
2. Markdown의 `##` 섹션을 기준으로 문서 개요와 요약 카드가 렌더링됩니다.
3. 사용자는 원본 문서 기반의 소개 화면을 확인할 수 있습니다.

## 실패 또는 예외 흐름
- Markdown 파일이 누락되면 오류 메시지가 표시됩니다.
- 정적 사이트의 `fetch` 제약이 있는 환경에서는 원격 호스팅 상태에서 확인이 필요합니다.

## 기대 결과
- 두 파일이 모두 `docs/` 아래에 등록됩니다.
- HTML은 Markdown 원본을 기준으로 요약 UI를 구성합니다.
- 오류 상황에서는 조용히 실패하지 않고 안내 문구를 보여줍니다.

## 실패 시 확인할 항목
- 경로가 `./agent-overview.md`로 정확히 지정되어 있는지
- 브라우저 또는 배포 환경에서 정적 파일 `fetch`가 가능한지
- 인코딩이 UTF-8로 유지되는지
