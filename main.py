"""Is the internet actually working?

"Working" is three separate questions and users conflate them, so this tests
them separately and says which one failed:

    1. is there a route out at all      (TCP to a public DNS resolver)
    2. does name resolution work        (DNS lookup)
    3. do real sites respond            (TCP to a well-known host, timed)

That distinction is the whole value. "DNS is not resolving" is something a
person can act on; "the internet is broken" is not.
"""
import socket
import sys
import time

TIMEOUT = 4


def reachable(host, port):
    """(ok, milliseconds)."""
    started = time.monotonic()
    try:
        with socket.create_connection((host, port), timeout=TIMEOUT):
            return True, (time.monotonic() - started) * 1000
    except OSError:
        return False, None


def resolves(name="www.google.com"):
    try:
        socket.getaddrinfo(name, 443, proto=socket.IPPROTO_TCP)
        return True
    except OSError:
        return False


def main():
    # 1.1.1.1 by IP, so this leg does not depend on DNS.
    route, latency = reachable("1.1.1.1", 443)
    if not route:
        print("I cannot reach anything outside this machine. The connection "
              "or the router looks to be down.")
        return 0

    if not resolves():
        print("You have a connection, but names are not resolving - that is a "
              "DNS problem, so pages will fail to load even though you are "
              "online.")
        return 0

    site, site_latency = reachable("www.google.com", 443)
    if not site:
        print("Your connection and DNS are fine, but websites are not "
              "responding. Something is blocking traffic.")
        return 0

    best = min(x for x in (latency, site_latency) if x is not None)
    if best < 60:
        quality = "and it is quick"
    elif best < 150:
        quality = "and it is responding normally"
    elif best < 400:
        quality = "though it is a little sluggish"
    else:
        quality = "but it is slow - around %d milliseconds to respond" % best
    print("Yes, you are online %s." % quality)
    return 0


if __name__ == "__main__":
    sys.exit(main())
