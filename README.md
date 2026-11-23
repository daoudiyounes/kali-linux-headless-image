# kali-linux-headless

A Docker image of the official [`kalilinux/kali-rolling`](https://hub.docker.com/r/kalilinux/kali-rolling)
base with Kali's **`kali-linux-headless`** toolset preinstalled, so you never
wait through an `apt install` again. It is Kali's own container/server set:
every command-line tool, without the GUI apps (VS Code, Chromium, Xorg) that a
container cannot use.

A GitHub Actions workflow checks the base image daily. When Kali republishes
`kali-rolling` (new digest), it rebuilds and pushes a fresh `latest` — and skips
the build entirely when nothing changed upstream.

## Use it

```bash
docker pull daoudii/kali-linux-headless:latest
docker run --rm -it daoudii/kali-linux-headless:latest
```

Tags:

- `latest` — newest build
- `base-<hash>` — pinned to one specific base image (the hash of the upstream
  `kali-rolling` image), useful for reproducible setups

## Build locally

```bash
docker build -t kali-linux-headless .
```

## Notes

- **Toolset:** `kali-linux-headless` installed with `--no-install-recommends`,
  ~1300 packages. It drops GUI-only tools (`burpsuite`, `armitage`, VS Code,
  Chromium) and `seclists`. To add wordlists back:
  `docker run ... bash -c "apt-get update && apt-get -y install seclists"`.
- The image is **a few GB** compressed. First pull is slow; it is cached
  afterwards.
- **Multi-arch:** built natively for `linux/amd64` and `linux/arm64`, so the
  same `latest` tag works on Intel/AMD and ARM machines (Snapdragon, Apple
  Silicon, Raspberry Pi 4/5). `docker pull` picks the right one automatically.
  Each arch builds on its own native GitHub runner; no QEMU.
- If a tool has no arm64 package, it is missing from the arm64 image only. The
  build log shows which.
- GitHub disables scheduled workflows after 60 days without repo activity, and
  scheduled runs can be delayed. The manual **Run workflow** button is a
  fallback; set `force` to rebuild even without an upstream change.
- Editing only the `Dockerfile` does not trigger a rebuild — the skip check
  hashes the upstream base image only. After such a change, run the workflow
  manually with `force` ticked.
- `kali-rolling` is a rolling release, so "a new version" means the base image
  digest changed, not a numbered release.
