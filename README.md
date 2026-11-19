# remotecontrol-app

Remote control for a [Deskconn](https://github.com/xconnio/deskconn) machine: screen brightness, lock and
wallpaper, screenshots, media players (MPRIS), audio mute and printing.

It runs next to `deskconnd` on the machine and registers its procedures on deskconnd's local socket
(`~/.deskconn/deskconn.sock`). If deskconnd isn't up yet, or restarts, the app keeps retrying the connection.

Calls are end-to-end encrypted, by this app itself. It serves its own key exchange,
`com.deskconn.remotecontrol.key.exchange`, the same X25519 exchange as deskconnd's `key.exchange`
but with separate keys: a client exchanges keys with it before calling the procedures below, and encrypts with
those keys, not deskconnd's.

On a desktop (`DISPLAY` or `WAYLAND_DISPLAY` set) everything is served; on a headless server only printing is.

## Procedures

| Procedure                                      | Needs a desktop |
|------------------------------------------------|-----------------|
| `com.deskconn.remotecontrol.screen.brightness.get` | yes             |
| `com.deskconn.remotecontrol.screen.brightness.set` | yes             |
| `com.deskconn.remotecontrol.screen.lock`           | yes             |
| `com.deskconn.remotecontrol.screen.islocked`       | yes             |
| `com.deskconn.remotecontrol.wallpaper.get`         | yes             |
| `com.deskconn.remotecontrol.wallpaper.checksum`    | yes             |
| `com.deskconn.remotecontrol.screenshot`            | yes             |
| `com.deskconn.remotecontrol.screenshot.permission` | yes             |
| `com.deskconn.remotecontrol.mpris.*`               | yes             |
| `com.deskconn.remotecontrol.audio.*`               | yes             |
| `com.deskconn.remotecontrol.printer.list`          | no              |
| `com.deskconn.remotecontrol.printer.print`         | no              |

Screenshots and printing are off until enabled in `~/.deskconn/config.yml` (`screenshot.enabled`,
`printing.mode`).

## Build and run

```bash
make build      # bin/remotecontrol-app
make run
```
