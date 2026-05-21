---
report_id: rpt_20260521_001
category: plan
title: 루트 배포 경로 및 시스템 로그 보강 작업 수행 계획서
status: published
created_at: 2026-05-21T08:50:00+09:00
updated_at: 2026-05-21T08:59:00+09:00
author: agent
project_key: report-hub-root-base-path-system-log-fix
tags:
  - github-pages
  - base-path
  - system-logging
  - report-hub
summary: GitHub Pages 사용자 페이지 루트 배포 기준에 맞춰 BASE_PATH 계산 오류를 수정하고 검증 문서와 로그 구조를 보강하는 작업 계획
---

# 루트 배포 경로 및 시스템 로그 보강 작업 수행 계획서

## 작업 배경
개발 작업 리포트 허브는 `ChatGPT-Agent-Test.github.io` 사용자 페이지 저장소로 배포되는 구조다. 이 배포 방식에서는 정적 파일 기준 경로가 루트(`/`)여야 한다.

기존 설정은 프로젝트 페이지 배포를 전제로 한 `report-hub-site` 경로가 남아 있어 실제 GitHub Pages 루트 접속 시 `data/reports.json` 조회가 실패할 수 있었다.

## 작업 목표
- 사용자 페이지 저장소에서는 `BASE_PATH`를 빈 문자열로 계산한다.
- 프로젝트 페이지 저장소로 재사용할 때는 기존처럼 첫 번째 경로 세그먼트를 base path로 유지한다.
- 수정 후 배포 캐시로 인해 예전 JS가 남는 문제를 줄인다.
- Supabase가 실제 설정된 경우 메인 초기화 성공/실패 로그를 `system_logs`에 기록할 수 있게 한다.
- 앞서 수행한 수정사항을 보고서 4종으로 문서화하고 페이지에서 확인 가능하게 연결한다.

## 수정 범위
- `assets/js/config.js`
- `assets/js/main.js`
- `assets/js/supabase-client.js`
- `assets/js/root-structure-validation-checklist.js`
- `index.html`
- `pages/report-detail.html`
- `pages/root-structure-validation-checklist.html`
- `data/reports.json`
- `data/root-structure-validation-checklist.json`
- `Integrated Agent Design System/root-structure-validation-checklist.md`
- `supabase/schema.sql`

## 제외 범위
- Supabase 실제 URL 및 anon key 주입
- RLS 정책 전체 작성
- GitHub Pages Actions 워크플로우 변경
- 기존 보고서 원문 재작성

## 완료 기준
- 로컬 메인 화면이 정상 로딩된다.
- 상세 화면에서 Markdown 본문이 정상 렌더링된다.
- 체크리스트 화면에 사용자 페이지 루트 배포 기준 문구가 반영된다.
- 경로 계산 시뮬레이션에서 `chatgpt-agent-test.github.io` 루트 접속 시 `BASE_PATH=''`가 나온다.
- 새 보고서 4종이 `reports.json`에 연결된다.

