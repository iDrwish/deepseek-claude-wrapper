#!/usr/bin/env bash
set -euo pipefail

run_install() {
  local os shell profile fake_home stubdir
  os="$1"
  shell="$2"
  profile="$3"

  fake_home="$(mktemp -d)"
  stubdir="$(mktemp -d)"

  cat > "$stubdir/uname" <<STUB
#!/usr/bin/env bash
echo "$os"
STUB
  chmod +x "$stubdir/uname"

  cat > "$stubdir/npm" <<'STUB'
#!/usr/bin/env bash
exit 0
STUB
  chmod +x "$stubdir/npm"

  HOME="$fake_home" PATH="$stubdir:$PATH" SHELL="$shell" DEEPSEEK_API_KEY=test bash install-deepseek-claude.sh >/dev/null 2>&1

  if [ ! -f "$fake_home/$profile" ]; then
    echo "Expected profile $profile not created"
    return 1
  fi

  grep -q 'export PATH="\$HOME/.deepseek-claude:\$PATH"' "$fake_home/$profile"
}

run_install Darwin /bin/bash .bash_profile
run_install Linux /bin/bash .bashrc
run_install Linux /bin/zsh .zshrc

echo "Profile detection tests passed." 
