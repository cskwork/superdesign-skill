# Install superdesign

<details>
<summary><strong>Claude Code</strong></summary>

### Install

```bash
claude plugin marketplace add cskwork/superdesign-skill
claude plugin install superdesign@superdesign
```

Type `/superdesign`.

### Verify

```bash
claude plugin list
```

### Update

```bash
claude plugin marketplace update superdesign
```

### Uninstall

```bash
claude plugin uninstall superdesign
claude plugin marketplace remove superdesign
```

</details>

<details>
<summary><strong>Codex</strong></summary>

### Install

```bash
codex plugin marketplace add cskwork/superdesign-skill --ref main
codex plugin add superdesign@superdesign
```

Type `$superdesign`.

### Verify

```bash
codex plugin list
```

### Uninstall

```bash
codex plugin remove superdesign
codex plugin marketplace remove superdesign
```

</details>

<details>
<summary><strong>Gemini CLI</strong></summary>

### Install (extension, always-on)

```bash
gemini extensions install https://github.com/cskwork/superdesign-skill
```

### Install (command, opt-in)

```bash
mkdir -p ~/.gemini/commands
curl -fsSL https://raw.githubusercontent.com/cskwork/superdesign-skill/main/skills/superdesign-skill/agents/gemini.toml \
  -o ~/.gemini/commands/superdesign.toml
```

Type `/superdesign` in a new session.

### Verify

```bash
gemini extensions list
```

### Uninstall

```bash
gemini extensions uninstall superdesign
```

</details>

<details>
<summary><strong>Cursor, OpenCode, Amp, and other agent-skills harnesses</strong></summary>

### Install

```bash
npx skills add cskwork/superdesign-skill
npx skills add cskwork/superdesign-skill -g
```

Type `/superdesign` in a new agent chat.

### Verify

```bash
npx skills list
```

### Update

```bash
npx skills update superdesign
```

### Uninstall

```bash
npx skills remove superdesign
```

</details>

<details>
<summary><strong>Antigravity (agy)</strong></summary>

### Install

```bash
agy plugin install https://github.com/cskwork/superdesign-skill
```

### Verify

```bash
agy plugin list
```

### Uninstall

```bash
agy plugin uninstall superdesign
```

</details>
