[English](README.md) | **한국어**

# superdesign

마스터 웹/모바일 디자이너를 Claude Code 스킬로. 의도를 읽고, 현재 트렌드를 조사하고, 알맞은 미감으로 라우팅해, 결정적 안티슬롭 게이트를 통과하는 우아한 UI를 산출합니다. 자기완결형이자 포터블: Stitch, gpt-image-2, 웹 검색 없이도 동작하며 우아하게 degrade합니다.

랜딩 페이지: https://cskwork.github.io/superdesign-skill

## 일반 디자인 프롬프트보다 더하는 것

- **의도 기반 라우팅.** 디자인 작업을 6개 모드 중 하나로 분류하고, 단일 기본 하우스 스타일 대신 맞는 매체 + 미감 패밀리를 고릅니다.
- **트렌드 인지, 추종 아님.** 라이브 `WebSearch` 트렌드 펄스(날짜 표기 오프라인 스냅샷 폴백)로 최신성을 유지하되, 브리프에 봉사하는 트렌드만 적용합니다. 트렌드 read는 날짜와 함께 기록.
- **안티슬롭은 눈대중이 아니라 강제.** 결정적 디텍터(`templates/anti-slop-gate.mjs`) + WCAG 대비 게이트가 빌드된 소스를 스캔합니다. 디자이너는 자기승인하지 않습니다.
- **우아한 폴백.** 도구가 없으면 문서화된 플레이스홀더와 내장 스냅샷으로 degrade하며, 가짜 에셋이나 지어낸 데이터는 없습니다.

## 원칙

- 우아함은 기본값이지 군더더기가 아니다.
- 의도를 먼저 읽는다. 기본 템플릿이 아니라 브리프에 맞춰 디자인.
- 트렌드 인지 != 추종. 트렌드 read는 날짜와 함께 기록.
- 안티슬롭은 게이트로 강제. 디자이너는 자기승인 금지.
- 자기완결 + 우아한 폴백. 가짜 에셋/데이터 금지.
- Hard stop: 외부 게시/파괴적 단계는 명시 동의.

## 모드

| 모드 | 용도 |
|---|---|
| CREATE | 새 UI / 랜딩 / 앱 / 화면을 처음부터 |
| REDESIGN | 기존 UI 현대화/개선 (감사 우선) |
| SYSTEM | 디자인 토큰 / 팔레트 / 타입 / 테마만 |
| CRITIQUE | 디자인 리뷰/감사 (디텍터 실행, 빌드 없음) |
| EXPLORE | 발산형 방향/무드보드, 커밋 없음 |
| ASSET | 이미지/아이콘/일러스트/SVG/로고 단건 (폴백 체인) |

매체(웹 vs 모바일/네이티브)는 루프에서 결정: `reference/web.md` 또는 `reference/mobile.md`.

## 기본 루프 (CREATE / REDESIGN)

1. **Read** - 브리프를 한 줄로 진술.
2. **Trend pulse** - 현재 트렌드 검색(스냅샷 폴백), 날짜와 함께 기록.
3. **Direction** - 다이얼 설정, 시스템/패밀리/레인 하나 선택, 매체 선택.
4. **Build** - `reference/taste-core.md` + 선택 패밀리/매체로 구현; 에셋은 체인으로 조달.
5. **Critique** (독립) - `templates/preflight-gate.sh` 실행; 모든 위반 기록.
6. **Verify** - 수정, 게이트 그린까지 재실행, 출력과 함께 보고.

## 예시

```
/superdesign 개발자 도구 스타트업을 위한 차분한 랜딩 페이지
/superdesign 이 관리자 대시보드를 덜 평범하게 리디자인
/superdesign 핀테크 앱 디자인 시스템: 라이트 + 다크 토큰
/superdesign 이 페이지 비평해줘  (코드 / URL / 스크린샷 첨부)
/superdesign 포트폴리오 방향 3가지 탐색
/superdesign AI 노트 앱용 히어로 일러스트
```

## 안티슬롭 게이트

```bash
# 빌드된 UI 소스에서 기계 검출 가능한 AI tell 스캔
node templates/anti-slop-gate.mjs path/to/index.html

# 열거된 텍스트/배경 쌍에 대한 WCAG 대비
node templates/contrast-gate.mjs contrast-pairs.json

# 표면 vault 전체 pre-flight (claims + anti-slop + contrast)
bash templates/preflight-gate.sh <vault-dir> path/to/index.html
```

행 단위 이스케이프: `taste-ok`를 포함한 행은 의도적이고 정당한 선택(예: 중립적 Inter read)에 대해 디텍터를 억제합니다.

## 설치

```bash
git clone <superdesign-skill-repo> ~/skills/superdesign-skill
ln -s ~/skills/superdesign-skill ~/.claude/skills/superdesign
```

이후 Claude Code에서 `/superdesign <디자인 의도>`.

## 테스트

```bash
bash tests/gate-scenarios.test.sh
bash tests/reference-links-contract.test.sh
bash tests/mode-routing-contract.test.sh
bash tests/asset-fallback-contract.test.sh
```

## 크레딧

자매 스킬 [supergoal-skill](https://github.com/cskwork/supergoal-skill)(구조, 대비 게이트) 기반. 안티슬롭 규칙은 [taste-skill](https://github.com/leonxlnx/taste-skill)(MIT) 적응; 안티패턴 개념은 [impeccable](https://github.com/pbakaus/impeccable)(Apache-2.0, 코드 미복사) distill; 에셋/랜딩 흐름은 [stitch-landing-skill](https://github.com/cskwork/stitch-landing-skill)(MIT) 참고. 전체 귀속은 `reference/sources.md`. 라이선스: MIT.
