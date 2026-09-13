# Net Check

Tells you whether the internet is up, and which part is broken when it isn't - your network, your DNS, or your line.

A feature for [Mavis AI](https://www.mavis-ai.com) — a desktop voice assistant.

```
You: "is the internet working"
```

Mavis answers out loud:

```
"Internet is up and looking good - 6 milliseconds to Cloudflare."
"Your local network is fine but nothing is getting out - that looks like your line or your provider."
"The internet is reachable at 14 milliseconds, but DNS isn't resolving - that's a name server problem."
```

It reports the **exception, not the inventory** — the reply is spoken, so a list would be unusable.

## Install

From the Mavis Appstore — find **Net Check** and click Install.

Or install it directly:

```python
from utils.feature_install import install_from_github
install_from_github("https://github.com/keefng8/net-check")
```

## What you can say

- *"is the internet working"*
- *"check my connection"*
- *"is the wifi down"*
- *"why is the internet slow"*
- *"network status"*

These are not matched word for word. Mavis gives them to its language model as examples of intent, so close variations work too.

## How it works

Separates the three failures that need different responses from you: your router, your DNS, or your line.

## Requirements

None. Windows PowerShell, which every Windows machine already has.

## Building your own

See [Building features for Mavis](https://github.com/keefng8/mavis-feature-docs) — a feature is just a GitHub repository with a `mavis.json`.

## License

MIT — see [LICENSE](LICENSE).
