---
report_id: rpt_20260520_002
category: test-scenario
title: 개발 작업 리포트 허브 검증 테스트 시나리오
status: published
created_at: 2026-05-20T10:00:00+09:00
updated_at: 2026-05-20T15:10:00+09:00
author: agent
project_key: report-hub
tags:
  - github-pages
  - validation
  - base-path
  - regression
summary: GitHub Pages 루트 배포 기준에서 경로 계산 오류 수정 전후를 검증하기 위한 테스트 시나리오 정리
---

# 개발 작업 리포트 허브 검증 테스트 시나리오

## 테스트 목적
- GitHub Pages 루트 배포 환경에서 데이터 파일과 상세 페이지 링크가 올바른 경로로 호출되는지 검증한다.
- 캐시 문제와 경로 문제를 구분해 재현 가능하게 점검한다.
- 수정 이후 동일 문제가 다시 발생하지 않는지 회귀 테스트 기준을 마련한다.

## 테스트 대상
- 메인 페이지: `index.html`
- 경로 설정: `assets/js/config.js`
- 데이터 조회: `assets/js/api.js`
- 메인 렌더링: `assets/js/main.js`
- 메타데이터: `data/reports.json`
- 상세 페이지: `pages/report-detail.html`

## 사전 조건
- 배포 주소는 `https://chatgpt-agent-test.github.io/` 이다.
- 브라우저 캐시는 비운 상태와 남아 있는 상태를 각각 확인한다.
- Supabase 키는 미설정 상태여도 테스트 가능해야 한다.

## 테스트 시나리오
### 시나리오 1. 루트 주소 접속 시 메인 데이터 로딩
- 절차
  1. `https://chatgpt-agent-test.github.io/` 로 접속한다.
  2. 시스템 상태, 바로가기, 카테고리 요약, 보고서 목록 영역을 확인한다.
- 기대 결과
  - 각 영역에 실패 문구가 아닌 실제 보고서 데이터가 표시된다.
  - 콘솔에 `reports.json 파일을 불러오지 못했습니다.` 오류가 발생하지 않는다.

### 시나리오 2. 데이터 파일 실제 요청 경로 확인
- 절차
  1. 브라우저 개발자 도구 Network 탭을 연다.
  2. 메인 페이지를 새로고침한다.
  3. `reports.json` 요청 URL을 확인한다.
- 기대 결과
  - 요청 경로가 `/data/reports.json` 또는 `https://chatgpt-agent-test.github.io/data/reports.json` 형태다.
  - `/report-hub-site/data/reports.json` 형태로 요청되지 않는다.

### 시나리오 3. 상세 페이지 링크 이동
- 절차
  1. 메인 페이지에서 보고서 상세 링크를 클릭한다.
  2. 상세 페이지 URL과 내용 렌더링 여부를 확인한다.
- 기대 결과
  - `pages/report-detail.html?reportId=...` 경로로 정상 이동한다.
  - 상세 문서 제목, 요약, 본문이 정상 렌더링된다.

### 시나리오 4. 캐시 초기화 전후 동작 비교
- 절차
  1. 수정 전 배포 또는 캐시된 상태에서 페이지를 확인한다.
  2. 강력 새로고침 또는 캐시 초기화 후 다시 접속한다.
- 기대 결과
  - 캐시된 예전 파일이 남아 있으면 이전 증상이 보일 수 있다.
  - 캐시 초기화 후에는 최신 설정 기준으로 정상 동작한다.

### 시나리오 5. Supabase 미설정 상태 폴백 확인
- 절차
  1. 현재 placeholder Supabase 설정 상태에서 메인 화면을 확인한다.
  2. 연결 상태 메시지와 데이터 렌더링 결과를 확인한다.
- 기대 결과
  - Supabase 미설정이어도 보고서 데이터 로딩은 정상 동작한다.
  - Supabase 관련 문구는 폴백 상태로 표시되며 전체 화면은 깨지지 않는다.

## 주요 확인 포인트
- `BASE_PATH` 계산값
- `buildAppPath()` 가 만드는 실제 요청 경로
- `init()` 진입 후 `fetchReports()` 실패 여부
- catch 블록으로 빠지는지 여부
- 캐시 제거 후 최신 자산 반영 여부

## 합격 기준
- 루트 배포 기준에서 메인/상세 페이지 모두 정상 동작한다.
- 잘못된 하위 경로 요청이 더 이상 발생하지 않는다.
- Supabase 미설정 상태에서도 실패 UI가 아닌 정상 콘텐츠가 표시된다.
