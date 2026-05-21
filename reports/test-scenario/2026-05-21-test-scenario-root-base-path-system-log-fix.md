---
report_id: rpt_20260521_002
category: test-scenario
title: 루트 배포 경로 및 시스템 로그 보강 검증 테스트 시나리오
status: published
created_at: 2026-05-21T08:53:00+09:00
updated_at: 2026-05-21T08:59:00+09:00
author: agent
project_key: report-hub-root-base-path-system-log-fix
tags:
  - validation
  - github-pages
  - base-path
  - cache
summary: BASE_PATH 수정, 정적 데이터 연결, 상세 화면 렌더링, 체크리스트 캐시 방지, 보고서 연결을 검증하기 위한 테스트 시나리오
---

# 루트 배포 경로 및 시스템 로그 보강 검증 테스트 시나리오

## 테스트 목적
앞서 수정한 루트 배포 경로 계산과 시스템 로그 보강이 실제 화면과 정적 데이터 구조에서 정상 동작하는지 검증한다.

## 사전 조건
- 로컬 정적 서버가 `http://127.0.0.1:8000/`에서 실행 중이다.
- Supabase 설정은 placeholder 상태일 수 있다.
- 보고서 데이터는 `data/reports.json`에서 로드된다.

## 시나리오 1. 메인 화면 로딩
절차:
1. `http://127.0.0.1:8000/`에 접속한다.
2. 시스템 상태, 보고서 4종 바로가기, 카테고리 요약, 보고서 목록을 확인한다.

기대 결과:
- 시스템 상태가 오류 문구가 아닌 실제 배포 기준 정보로 표시된다.
- 보고서 4종 바로가기 4개가 표시된다.
- 카테고리 요약 카드 4개가 표시된다.
- 선택된 카테고리 목록에 보고서가 표시된다.

## 시나리오 2. 상세 화면 렌더링
절차:
1. `pages/report-detail.html?reportId=rpt_20260520_010`으로 이동한다.
2. 제목, 메타데이터, 확인 버튼, Markdown 본문을 확인한다.

기대 결과:
- 상세 제목이 표시된다.
- Markdown 본문이 HTML로 렌더링된다.
- Supabase 미설정 상태에서는 확인 버튼이 비활성화되고 `확인 상태 저장 미설정`으로 표시된다.

## 시나리오 3. 체크리스트 데이터 갱신
절차:
1. `pages/root-structure-validation-checklist.html`로 이동한다.
2. GitHub Pages base path 점검 영역을 확인한다.

기대 결과:
- `현재 사용자 페이지 배포에서는 BASE_PATH='' 기준으로 정상 동작한다` 문구가 표시된다.
- 체크리스트 데이터와 보고서 데이터 fetch가 캐시 없이 수행된다.

## 시나리오 4. 경로 계산 시뮬레이션
절차:
1. `assets/js/config.js`를 Node VM으로 로드한다.
2. `chatgpt-agent-test.github.io` 루트, `index.html`, `pages/report-detail.html` 경로를 시뮬레이션한다.
3. 프로젝트 페이지 예시 `org.github.io/report-hub-site/`를 시뮬레이션한다.

기대 결과:
- 사용자 페이지 루트 경로는 `BASE_PATH=''`이다.
- 프로젝트 페이지 예시는 `BASE_PATH='/report-hub-site'`이다.

## 시나리오 5. 보고서 연결 검증
절차:
1. `data/reports.json`의 모든 `file_path`가 실제 Markdown 파일과 일치하는지 확인한다.
2. `detail_page_path`가 `pages/report-detail.html?reportId={report_id}` 규칙과 일치하는지 확인한다.

기대 결과:
- 누락 Markdown 파일이 없다.
- 상세 페이지 경로 불일치가 없다.

