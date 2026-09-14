# Connection Check

Checks whether the internet is actually reachable and how fast the connection responds. Use this when the user asks if the internet is working, if they are online, or why something will not load.

A feature for [Mavis AI](https://www.mavis-ai.com) — a desktop voice assistant.

```
You: "is my internet working"
```

Mavis answers out loud:

```
"Internet is up and looking good - 6 milliseconds to Cloudflare."
"Your local network is fine but nothing is getting out - that looks like your line or your provider."
"The internet is reachable at 14 milliseconds, but DNS isn't resolving - that's a name server problem."
```

It reports the **exception, not the inventory** — the reply is spoken, so a list would be unusable.

## Install

From the Mavis Appstore — find **Connection Check** and click Install.

Or install it directly:

```python
from utils.feature_install import install_from_github
install_from_github("https://github.com/keefng8/net-check")
```

## What you can say

- *"is my internet working"*
- *"am i online"*
- *"why is the internet slow"*
- *"check my connection"*

These are not matched word for word. Mavis gives them to its language model as examples of intent, so close variations work too.

## How it works

Separates the three failures that need different responses from you: your router, your DNS, or your line.

## Requirements

Python 3.8 or newer, and nothing else — the standard library only. No `pip install`, no model to download, no account.

## Building your own

See [Building features for Mavis](https://github.com/keefng8/mavis-feature-docs) — a feature is just a GitHub repository with a `mavis.json`.

## License

MIT — see [LICENSE](LICENSE).
